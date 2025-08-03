return {

    {
        "williamboman/mason.nvim",
        -- opts = function(_, opts)
        --     vim.list_extend(opts.ensure_installed, { "pylance" })
        --     opts.registries = { "github:fecet/mason-registry" }
        -- end,
        opts = { ensure_installed = { "pylance" }, registries = { "github:fecet/mason-registry" } },
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
                    root_dir = function(fname)
                        local root_dir = util.root_pattern(unpack({
                            ".venv",
                            "pixi.toml",
                            ".git",
                            "pyproject.toml",
                            "setup.py",
                            "setup.cfg",
                            "requirements.txt",
                            "Pipfile",
                            "pyrightconfig.json",
                            "environment.yml",
                        }))
                        local result = root_dir(fname)

                        if result == vim.fn.expand("~") then return vim.fs.dirname(fname) end
                        return result
                    end,
                    cmd = { "pylance", "--stdio" },
                    single_file_support = true,
                    capabilities = capabilities,
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
