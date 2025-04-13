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
                compat = {
                    "neopyter",
                    "avante_commands",
                    "avante_mentions",
                    "avante_files",
                },
                default = {
                    "snippets",
                    "lsp",
                    "path",
                    "buffer",
                    "neopyter",
                    "avante_commands",
                    "avante_mentions",
                    "avante_files",
                },
                providers = {
                    neopyter = {
                        name = "neopyter",
                        module = "blink.compat.source",
                        opts = { completers = { "CompletionProvider:kernel" } },
                    },
                    avante_commands = {
                        name = "avante_commands",
                        module = "blink.compat.source",
                        score_offset = 90,
                        opts = {},
                    },
                    avante_files = {
                        name = "avante_files",
                        module = "blink.compat.source",
                        score_offset = 100,
                        opts = {},
                    },
                    avante_mentions = {
                        name = "avante_mentions",
                        module = "blink.compat.source",
                        score_offset = 1000,
                        opts = {},
                    },
                },
            },
            fuzzy = {
                sorts = {
                    function(a, b)
                        local source_priority = {
                            lsp = 4,
                            neopyter = 1,
                            path = 2,
                            buffer = 3,
                            ripgrep = 3,
                            snippets = 5,
                            avante = 4,
                        }

                        local function get_priority(source_id)
                            if source_priority[source_id] then return source_priority[source_id] end

                            for prefix, priority in pairs(source_priority) do
                                if source_id:find("^" .. prefix) then return priority end
                            end

                            return 0
                        end

                        return get_priority(a.source_id) > get_priority(b.source_id)
                    end,
                    "score",
                    "sort_text",
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
                completion = {
                    menu = {
                        auto_show = function(ctx)
                            return vim.fn.getcmdtype() == ":"
                            -- enable for inputs as well, with:
                            -- or vim.fn.getcmdtype() == '@'
                        end,
                    },
                },
            },
            keymap = {
                preset = "enter",
                ["<Tab>"] = {
                    function(cmp)
                        if require("luasnip").expandable() then return cmp.accept() end
                    end,
                    function(cmp)
                        if cmp.snippet_active() then return cmp.accept() end
                    end,
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
    {
        "folke/noice.nvim",
        event = function(event) return "User IceLoad" end,
        opts = {
            notify = { enabled = true },
            messages = {
                enabled = true, -- enables the Noice messages UI
                view = "mini",
            },
            routes = {
                {
                    filter = {
                        event = "notify",
                        any = { { find = "# Active:" }, { find = "# Inactive:" } },
                    },
                },
                {
                    filter = {
                        -- any = { { find = "kernelComplete" }, { find = "[cord.nvim]" } },
                        find = "kernelComplete",
                    },
                    opts = { skip = true },
                },
                -- {
                --     filter = {
                --         any = { { find = "Neopyter" }, { find = "incorrect offset" } },
                --     },
                --     opts = { skip = true },
                -- },
                {
                    filter = {
                        event = "notify",
                        any = { { find = "# Plugin Updates" } },
                    },
                    view = "notify_send",
                },
                {
                    filter = {
                        -- any = { { find = "kernelComplete" }, { find = "[cord.nvim]" } },
                        find = "SUCCESS",
                    },
                    view = "mini",
                },
                {
                    filter = {
                        -- any = { { find = "kernelComplete" }, { find = "[cord.nvim]" } },
                        find = "cord.nvim",
                    },
                    view = "mini",
                },
                {
                    view = "split",
                    filter = { event = "msg_show", min_height = 20 },
                },
            },
            popupmenu = {
                enabled = true, -- enables the Noice popupmenu UI
                backend = "nui", -- backend to use to show regular cmdline completions
            },
            lsp = {
                signature = {
                    auto_open = {
                        enabled = true,
                        trigger = true, -- Automatically show signature help when typing a trigger character from the LSP
                        luasnip = true, -- Will open signature help when jumping to Luasnip insert nodes
                        throttle = 50, -- Debounce lsp signature help request by 50ms
                    },
                },
            },
        },
    },
}
