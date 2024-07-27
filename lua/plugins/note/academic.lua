local markdown_family = { "markdown", "rmd", "quarto", "qmd", "norg" }

return {
    {
        "quarto-dev/quarto-nvim",
        opts = {
            lspFeatures = {
                languages = { "r", "python", "julia", "bash", "html", "lua" },
            },
            keymap = { hover = "D" },
        },
        ft = "quarto",
    },

    {
        "jmbuhr/otter.nvim",
        -- enabled = false,
        opts = {
            buffers = {
                set_filetype = false,
            },
        },
    },
    {
        "jalvesaq/zotcite",
        enabled = false,
        -- ft = markdown_family,
        config = function() --[[ vim.env.ZCitationTemplate = "" ]]
        end,
    },
    {
        "jalvesaq/cmp-zotcite",
        enabled = false,
    },
    {
        "dhruvasagar/vim-table-mode",
        cmd = {
            "TableAddFormula",
            "TableEvalFormulaLine",
            "TableModeDisable",
            "TableModeEnable",
            "TableModeRealign",
            "TableModeToggle",
            "TableSort",
            "Tableize",
        },
        keys = {
            {
                "<C-t>f",
                "<CMD>TableAddFormula<CR>",
                desc = "Add Formula",
            },
            {
                "<C-t>e",
                "<CMD>TableEvalFormulaLine<CR>",
                desc = "Eval Formula Line",
            },
            {
                "<C-t>r",
                "<CMD>TableModeRealign<CR>",
                desc = "Realign",
            },
            {
                "<C-t>t",
                "<CMD>TableModeToggle<CR>",
                desc = "Toggle",
            },
            {
                "<C-t>s",
                "<CMD>TableSort<CR>",
                desc = "Sort",
            },
            {
                "<C-t>z",
                "<CMD>Tableize<CR>",
                desc = "Tableize",
            },
        },
        init = function()
            vim.g.table_mode_corner = "|"
            vim.g.table_mode_corner_corner = "|"
            vim.g.table_mode_header_fillchar = "-"
        end,
        config = function(_, opts)
            require("lazyvim.util").on_load(
                "which-key.nvim",
                function()
                    require("which-key").register({
                        mode = { "n" },
                        ["<C-t>"] = {
                            name = "Table",
                        },
                    })
                end
            )
        end,
        -- enabled = vim.builtin.vim_table_mode.active,
    },
    {
        "L3MON4D3/LuaSnip",
        event = "BufRead",
        dependencies = {
            { "fecet/vim-snippets" },
            {
                -- "fecet/luasnips-mathtex-snippets",
                "fecet/luasnip-latex-snippets.nvim",
                ft = markdown_family,
                dependencies = {
                    "preservim/vim-markdown",
                    -- "lervag/vimtex",
                },
                config = function()
                    vim.o.conceallevel = 2
                    vim.g.tex_conceal = "abdmgs"
                    vim.g.tex_flavor = "latex"
                    vim.g.vim_markdown_math = 1
                    vim.g.vim_markdown_folding_disabled = 1
                    vim.cmd("hi clear conceal")
                    require("luasnip-latex-snippets").setup({
                        use_treesitter = true,
                        allow_on_markdown = false,
                    })
                    require("luasnip-latex-snippets").setup_markdown()
                end,
            },
        },
        keys = function()
            return {
                { "<BS>", "<C-G>s", mode = "s" },
            }
        end,
        config = function()
            local luasnip = require("luasnip")
            require("luasnip.loaders.from_lua").lazy_load()
            require("luasnip.loaders.from_vscode").lazy_load()
            require("luasnip.loaders.from_snipmate").lazy_load()
            for i = 2, #markdown_family do
                luasnip.filetype_extend(markdown_family[i], { "markdown" })
            end
            luasnip.filetype_extend("quarto", { "qmd" })
            local opts = {
                update_events = "TextChanged,TextChangedI",
                delete_check_events = "TextChanged,InsertLeave",
                enable_autosnippets = true,
                store_selection_keys = "<tab>",
            }
            luasnip.config.setup(opts)
        end,
    },
}
