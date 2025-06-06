return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        -- config = function(_, opts) require("catppuccin").setup(opts) end,
        priority = 1000,
        opts = {
            background = { light = "latte", dark = "mocha" },
            flavour = "macchiato",
            transparent_background = false,
            term_colors = true,
            styles = {
                comments = { "italic" },
                properties = { "italic" },
                functions = { "bold" },
                keywords = { "italic" },
                operators = { "bold" },
                conditionals = { "bold" },
                loops = { "bold" },
                booleans = { "bold", "italic" },
                numbers = {},
                types = {},
                strings = {},
                variables = {},
            },
            integrations = {
                treesitter = true,
                native_lsp = {
                    inlay_hints = {
                        background = false,
                    },
                },
                alpha = false,
                cmp = true,
                dap = { enabled = true, enable_ui = true },
                dashboard = true,
                dropbar = { enabled = true, color_mode = true },
                gitsigns = true,
                -- hop = true,
                flash = true,
                illuminate = true,
                indent_blankline = { enabled = true, colored_indent_levels = true },
                lsp_saga = true,
                markdown = true,
                navic = false,
                neogit = false,
                neotest = false,
                neotree = false,
                nvimtree = false,
                rainbow_delimiters = true,
                semantic_tokens = true,
                symbols_outline = false,
                telescope = { enabled = true, style = "nvchad" },
                ts_rainbow = false,
                headlines = true,
                jupynium = true,
                ufo = true,
            },
            highlight_overrides = {
                ---@param cp palette
                all = function(cp)
                    return {

                        -- For mason.nvim
                        MasonNormal = { link = "NormalFloat" },

                        -- For indent-blankline
                        IndentBlanklineChar = { fg = cp.surface0 },
                        IndentBlanklineContextChar = { fg = cp.surface2, style = { "bold" } },

                        -- For nvim-cmp and wilder.nvim
                        Pmenu = {
                            fg = cp.overlay2,
                            bg = transparent_background and cp.none or cp.base,
                        },
                        PmenuBorder = {
                            fg = cp.surface1,
                            bg = transparent_background and cp.none or cp.base,
                        },
                        PmenuSel = { bg = cp.green, fg = cp.base },
                        CmpItemAbbr = { fg = cp.overlay2 },
                        CmpItemAbbrMatch = { fg = cp.blue, style = { "bold" } },
                        CmpDoc = { link = "NormalFloat" },
                        CmpDocBorder = {
                            fg = transparent_background and cp.surface1 or cp.mantle,
                            bg = transparent_background and cp.none or cp.mantle,
                        },

                        -- For telescope.nvim
                        TelescopeMatching = { fg = cp.lavender },
                        TelescopeResultsDiffAdd = { fg = cp.green },
                        TelescopeResultsDiffChange = { fg = cp.yellow },
                        TelescopeResultsDiffDelete = { fg = cp.red },

                        -- For nvim-treehopper
                        TSNodeKey = {
                            fg = cp.peach,
                            bg = transparent_background and cp.none or cp.base,
                            style = { "bold", "underline" },
                        },

                        -- For treesitter
                        ["@keyword.return"] = { fg = cp.pink, style = clear },
                        ["@error.c"] = { fg = cp.none, style = clear },
                        ["@error.cpp"] = { fg = cp.none, style = clear },
                    }
                end,
            },
        },
    },
    { "srcery-colors/srcery-vim", name = "srcery" },
    {
        "0xstepit/flow.nvim",
        opts = {},
    },
    {
        "anAcc22/sakura.nvim",
        dependencies = {
            "rktjmp/lush.nvim",
            -- "preservim/vim-markdown",
            -- "lervag/vimtex",
        },
    },
}
