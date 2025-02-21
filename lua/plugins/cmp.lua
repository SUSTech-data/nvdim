return {
    {
        "Saghen/blink.cmp",
        dependencies = {
            { "Saghen/blink.compat" },
        },
        opts = {
            snippets = {
                preset = "luasnip",
                expand = function(snippet) require("luasnip").lsp_expand(snippet) end,
                active = function(filter)
                    if filter and filter.direction then
                        return require("luasnip").jumpable(filter.direction)
                    end
                    return require("luasnip").in_snippet()
                end,
                jump = function(direction) require("luasnip").jump(direction) end,
            },
            sources = {
                compat = { "neopyter" },
                default = { "lsp", "path", "snippets", "buffer" },
                providers = {
                    neopyter = {
                        name = "neopyter",
                        module = "blink.compat.source",
                        opts = { completers = { "CompletionProvider:kernel" } },
                    },
                },
            },
            cmdline = {
                keymap = {
                    preset = "super-tab",
                    ["<Tab>"] = { "select_next" },
                    ["<S-Tab>"] = { "select_prev" },
                },
                sources = function()
                    local type = vim.fn.getcmdtype()
                    if type == "/" or type == "?" then return { "buffer" } end
                    if type == ":" or type == "@" then return { "cmdline" } end
                    return {}
                end,
            },
            keymap = {
                preset = "enter",
                ["<Tab>"] = {
                    function(cmp)
                        if cmp.snippet_active() then return cmp.accept() end
                    end,
                    LazyVim.cmp.map({ "snippet_forward", "ai_accept" }),
                    "fallback",
                },
                ["<S-Tab>"] = {
                    function(cmp)
                        if cmp.snippet_active() then return cmp.accept() end
                    end,
                    LazyVim.cmp.map({ "snippet_forward", "ai_accept" }),
                    "fallback",
                },
            },
        },
    },
    {
        "L3MON4D3/LuaSnip",
        event = "BufRead",
        opts = {
            history = true,
            delete_check_events = "TextChanged",
        },
        dependencies = {
            { "fecet/vim-snippets" },
            {
                -- "fecet/luasnips-mathtex-snippets",
                "fecet/luasnip-latex-snippets.nvim",
                dependencies = {
                    -- "preservim/vim-markdown",
                    -- "lervag/vimtex",
                },
                ft = { "markdown", "rmd", "quarto", "norg" },
                config = function()
                    -- vim.g.tex_conceal = "abdmgs"
                    -- vim.g.tex_flavor = "latex"
                    -- vim.g.vim_markdown_math = 1
                    -- vim.g.vim_markdown_folding_disabled = 1

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
                { "<BS>", "<C-G>c", mode = "s" },
            }
        end,
        config = function()
            local luasnip = require("luasnip")
            local markdown_family = { "markdown", "rmd", "quarto", "qmd", "norg" }

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
    {
        "L3MON4D3/LuaSnip",
        opts = function()
            LazyVim.cmp.actions.snippet_forward = function()
                if require("luasnip").jumpable(1) then
                    require("luasnip").jump(1)
                    return true
                end
            end
            LazyVim.cmp.actions.snippet_stop = function()
                if require("luasnip").expand_or_jumpable() then -- or just jumpable(1) is fine?
                    require("luasnip").unlink_current()
                    return true
                end
            end
        end,
    },
}
