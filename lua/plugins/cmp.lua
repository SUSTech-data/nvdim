return {
    {
        "hrsh7th/nvim-cmp",
        -- commit = "6c84bc75c64f778e9f1dcb798ed41c7fcb93b639",
        event = { "InsertEnter", "CmdlineEnter" },
        dependencies = {
            "hrsh7th/cmp-cmdline",
            "dmitmel/cmp-cmdline-history",
            "jalvesaq/cmp-zotcite",
            "saadparwaiz1/cmp_luasnip",
        },
        opts = function(_, opts)
            table.insert(
                opts.snippet,
                { expand = function(args) require("luasnip").lsp_expand(args.body) end }
            )
            local cmp = require("cmp")

            opts.mapping = vim.tbl_extend("force", opts.mapping, {
                ["<C-e>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.close()
                    else
                        cmp.complete()
                    end
                end),
                ["<C-k>"] = cmp.mapping.select_prev_item(),
                ["<C-j>"] = cmp.mapping.select_next_item(),
                -- ["<CR>"] = cmp.mapping(function(fallback)
                --     if cmp.visible() then
                --         vim.api.nvim_feedkeys(t("<C-g>u"), "n", true)
                --         cmp.confirm({ select = true })
                --     else
                --         fallback()
                --     end
                -- end),

                ["<tab>"] = cmp.mapping(
                    function(fallback)
                        return LazyVim.cmp.map({ "snippet_forward", "ai_accept" }, fallback)()
                    end
                ),
                -- ["<Tab>"] = cmp.mapping(function(fallback)
                --     local luasnip = require("luasnip")
                --     if require("luasnip").expand_or_jumpable() then
                --         luasnip.expand_or_jump()
                --     elseif require("copilot.suggestion").is_visible() then
                --         require("copilot.suggestion").accept()
                --     else
                --         fallback()
                --     end
                -- end, { "i", "s" }),
                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    local luasnip = require("luasnip")
                    if luasnip.jumpable(-1) then
                        luasnip.expand_or_jump()
                    else
                        fallback()
                    end
                end, { "i", "s" }),
            })

            local compare = require("cmp.config.compare")
            opts.sorting = {
                priority_weight = 2,
                comparators = {
                    -- require("copilot_cmp.comparators").prioritize,
                    -- require("copilot_cmp.comparators").score,
                    -- require("cmp_tabnine.compare"),
                    compare.offset, -- items closer to cursor will have lower priority
                    compare.exact,
                    compare.scopes,
                    compare.sort_text,
                    compare.score,
                    compare.recently_used,
                    -- compare.locality, -- items closer to cursor will have higher priority, conflicts with `offset`
                    compare.kind,
                    compare.length,
                    compare.order,
                },
            }
            opts.formatting = {
                fields = { "abbr", "kind", "menu" },
                format = function(entry, vim_item)
                    local icons = require("lazyvim.config").icons.kinds
                    -- load lspkind icons
                    vim_item.kind = string.format(
                        " %s  %s",
                        icons[vim_item.kind] or icons.TabNine,
                        vim_item.kind or ""
                    )

                    vim_item.menu = setmetatable({
                        cmp_tabnine = "[TN]",
                        copilot = "[CPT]",
                        buffer = "[BUF]",
                        orgmode = "[ORG]",
                        nvim_lsp = "[LSP]",
                        nvim_lua = "[LUA]",
                        path = "[PATH]",
                        tmux = "[TMUX]",
                        treesitter = "[TS]",
                        latex_symbols = "[LTEX]",
                        luasnip = "[SNIP]",
                        spell = "[SPELL]",
                        jupynium = "[JUP]",
                        codeium = "[CDM]",
                        neopyter = "[JUP]",
                    }, {
                        __index = function()
                            return "[BTN]" -- builtin/unknown source names
                        end,
                    })[entry.source.name]

                    local label = vim_item.abbr
                    local truncated_label = vim.fn.strcharpart(label, 0, 80)
                    if truncated_label ~= label then vim_item.abbr = truncated_label .. "..." end

                    return vim_item
                end,
            }
            vim.tbl_extend("force", opts.sources, {
                {
                    name = "luasnip",
                    group_index = 1,
                    option = { use_show_condition = true },
                    entry_filter = function()
                        local context = require("cmp.config.context")
                        local string_ctx = context.in_treesitter_capture("string")
                            or context.in_syntax_group("String")
                        local comment_ctx = context.in_treesitter_capture("comment")
                            or context.in_syntax_group("Comment")

                        return not string_ctx and not comment_ctx
                    end,
                },
                { name = "neopyter", option = { completers = { "CompletionProvider:kernel" } } },
                { name = "buffer" },
                { name = "cmp_zotcite" },
                { name = "jupynium" },
                { name = "path" },
                { name = "spell" },
            })
        end,

        config = function(_, opts)
            local cmp = require("cmp")
            cmp.setup(opts) -- insert mode completion
            cmp.setup.cmdline({ "/", "?" }, {
                completion = { completeopt = "menu,menuone,noselect" },
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = "buffer" },
                },
            })
            cmp.setup.cmdline(":", {
                completion = { completeopt = "menu,menuone,noselect" },
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = "path" },
                    { name = "cmdline" },
                    { name = "cmdline_history" },
                }),
            })
        end,
    },
    {
        "L3MON4D3/LuaSnip",
        event = "BufRead",
        dependencies = {
            { "fecet/vim-snippets" },
            {
                -- "fecet/luasnips-mathtex-snippets",
                "fecet/luasnip-latex-snippets.nvim",
                dependencies = {
                    "preservim/vim-markdown",
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
            local opts = {}
            luasnip.config.setup({
                update_events = "TextChanged,TextChangedI",
                delete_check_events = "TextChanged,InsertLeave",
                enable_autosnippets = true,
                store_selection_keys = "<tab>",
            })
            luasnip.config.setup(opts)
        end,
    },
}
