local format = function() require("lazyvim.plugins.lsp.format").format({ force = true }) end
return {
    { "smjonas/inc-rename.nvim", opts = {} },
    { "williamboman/mason.nvim", version = "1.6.2" },
    {
        "neovim/nvim-lspconfig",
        init = function()
            local keys = {}
            keys[#keys + 1] = { "K", false }
            keys[#keys + 1] = { "gd", false }
            keys[#keys + 1] = { "gr", false }
            keys[#keys + 1] = { "D", vim.lsp.buf.hover, desc = "Hover" }
            keys[#keys + 1] = { "<leader>cf", false }
            keys[#keys + 1] = { "<leader>fm", format, desc = "Format Document", has = "formatting" }
            keys[#keys + 1] =
                { "<leader>fm", format, desc = "Format Range", mode = "v", has = "rangeFormatting" }
            vim.list_extend(require("lazyvim.plugins.lsp.keymaps").get(), keys)
        end,

        opts = {
            diagnostics = {
                virtual_text = {
                    severity = {
                        vim.diagnostic.severity.INFO,
                        vim.diagnostic.severity.WARN,
                        vim.diagnostic.severity.ERROR,
                    },
                    prefix = "icons",
                },
                signs = {
                    severity = {
                        vim.diagnostic.severity.HINT,
                    },
                },
            },
            inlay_hints = {
                enabled = false,
            },
            autoformat = false,
            format_notify = true,
            servers = {
                pylance = require("plugins.lsp.servers.pylance"),
                ruff_lsp = require("plugins.lsp.servers.ruff"),
            },
        },
    },
    {
        "nvimdev/lspsaga.nvim",
        -- enabled = false,
        event = "LspAttach",
        keys = {
            -- {
            --     "D",
            --     "<cmd>Lspsaga hover_doc<cr>",
            --     desc = "Hover",
            -- },
            {
                "gd",
                "<cmd>Lspsaga peek_definition<cr>",
                -- "<cmd>Lspsaga finder def ++inexist<cr>",
                desc = "go to definition",
            },
            {
                "gr",
                "<cmd>Lspsaga finder ++inexist<cr>",
                -- "<cmd>Lspsaga finder<cr>",
                desc = "go to reference",
            },
            {
                "ga",
                "<cmd>Lspsaga code_action<cr>",
                desc = "Code Action (preview)",
                mode = { "n", "v" },
            },
            {
                "<leader>rn",
                "<cmd>Lspsaga rename ++project<cr>",
                desc = "lsp: Rename in project range",
                mode = { "n", "v" },
            },
        },
        config = function()
            local Util = require("lazyvim.util")
            require("lspsaga").setup({
                request_timeout = 3000,
                symbol_in_winbar = {
                    enable = not Util.has("dropbar.nvim"),
                },
                code_action = {
                    num_shortcut = true,
                    show_server_name = true,
                    extend_gitsigns = false,
                    keys = {
                        quit = "q",
                        exec = "<CR>",
                    },
                },
                definition = {
                    width = 0.6,
                    height = 0.5,
                    keys = {
                        edit = "<CR>",
                        vsplit = "v",
                        split = "s",
                        tabe = "t",
                    },
                },
                lightbulb = { enable = false },
                finder = {
                    keys = {
                        toggle_or_open = "<CR>",
                        vsplit = "v",
                        split = "s",
                        tabe = "t",
                    },
                },
                rename = {
                    in_select = false,
                    auto_save = false,
                    project_max_width = 0.5,
                    project_max_height = 0.5,
                    keys = {
                        quit = "q",
                        exec = "<CR>",
                        select = "x",
                    },
                },
                scroll_preview = {
                    scroll_down = "<C-d>",
                    scroll_up = "<C-u>",
                },
            })
        end,
        dependencies = {
            "nvim-treesitter/nvim-treesitter", -- optional
            "nvim-tree/nvim-web-devicons", -- optional
        },
    },
}
