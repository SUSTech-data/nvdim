return {

    {
        "williamboman/mason.nvim",
        opts = function(_, opts)
            vim.list_extend(opts.ensure_installed, { "pylance" })
            opts.registries = { "github:fecet/mason-registry" }
        end,
    },
    {
        "neovim/nvim-lspconfig",
        opts = function(_, opts)
            opts.servers.pyright = false
            -- sources.set_registries({ "lua:mason-registry.index" })
            local util = require("lspconfig.util")
            local configs = require("lspconfig.configs")
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = false
            configs["pylance"] = {
                default_config = {
                    filetypes = { "python" },
                    root_dir = util.root_pattern(unpack({
                        ".venv",
                        ".git",
                        "pyproject.toml",
                        "setup.py",
                        "setup.cfg",
                        "requirements.txt",
                        "Pipfile",
                        "pyrightconfig.json",
                        "environment.yml",
                    })),
                    cmd = { "pylance", "--stdio" },
                    single_file_support = true,
                    capabilities = capabilities,
                    on_init = function(client)
                        if vim.env.VIRTUAL_ENV then
                            -- local path = require("mason-core.path")
                            client.config.settings.python.pythonPath =
                                vim.fn.resolve(vim.env.VIRTUAL_ENV .. "/bin/python")
                        else
                            client.config.settings.python.pythonPath = vim.fn.exepath("python3")
                                or vim.fn.exepath("python")
                                or "python"
                        end
                    end,
                    before_init = function() end,
                    on_new_config = function(new_config, new_root_dir)
                        new_config.settings.python.pythonPath = vim.fn.exepath("python")
                            or vim.fn.exepath("python3")
                            or "python"
                    end,
                    settings = {
                        editor = { formatOnType = false },
                        python = {
                            analysis = {
                                autoSearchPaths = true,
                                useLibraryCodeForTypes = true,
                                diagnosticMode = "openFilesOnly",
                                -- typeCheckingMode = "basic",
                                typeCheckingMode = "basic",
                                indexing = false,
                            },
                        },
                    },
                },
            }
            -- opts.servers.pylance = {}
        end,
        -- setup = {
        --   pylance = {},
        -- },
    },
    {
        "wookayin/semshi",
        enabled = false,
        event = { "LspAttach", "BufReadPost" },
        cond = function()
            local clients = vim.lsp.get_clients({ bufnr = vim.api.nvim_get_current_buf() })
            -- print(vim.inspect(clients))
            return not vim.tbl_contains(clients, "pylance")
        end,
    },
}
