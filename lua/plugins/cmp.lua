-- Safe function to accept Copilot suggestions while preserving LuaSnip state
local function safe_copilot_accept()
    -- Check if Copilot suggestion is visible
    if not require("copilot.suggestion").is_visible() then return false end

    local current_buf = vim.api.nvim_get_current_buf()
    local session = require("luasnip.session")
    local current_node = session.current_nodes[current_buf]

    -- Save LuaSnip state information
    local jump_info = nil
    if current_node and current_node.parent and current_node.parent.snippet then
        local snippet = current_node.parent.snippet

        -- Save complete jump-related information
        jump_info = {
            -- Basic node information
            node = current_node,
            parent = current_node.parent,
            snippet = snippet,

            -- Save cursor position
            pos = vim.api.nvim_win_get_cursor(0),

            -- Save snippet-related information
            snippet_roots = vim.deepcopy(session.snippet_roots[current_buf] or {}),
            active_choice_nodes = vim.deepcopy(session.active_choice_nodes[current_buf] or {}),

            -- Save global state
            jump_active = session.jump_active,

            -- Save node link relationships
            next_node = current_node.next,
            prev_node = current_node.prev,

            -- Save snippet mark position information
            mark_begin_pos = nil,
            mark_end_pos = nil,
        }

        -- Try to get snippet mark position
        pcall(function()
            local begin_pos, end_pos = snippet.mark:pos_begin_end()
            jump_info.mark_begin_pos = begin_pos
            jump_info.mark_end_pos = end_pos
        end)

        -- Save insert_nodes information
        jump_info.insert_nodes = {}
        if snippet.insert_nodes then
            for pos, node in pairs(snippet.insert_nodes) do
                jump_info.insert_nodes[pos] = node
            end
        end

        -- Store all node mark information for later restoration
        -- This is crucial for maintaining the correct positions after text changes
        jump_info.node_marks = {}
        for _, node in ipairs(snippet.nodes) do
            if node.mark then
                local ok, begin_pos, end_pos = pcall(node.mark.pos_begin_end_raw, node.mark)
                if ok then
                    jump_info.node_marks[node] = {
                        begin_pos = begin_pos,
                        end_pos = end_pos,
                        opts = vim.deepcopy(node.mark.opts or {}),
                    }
                end
            end
        end

        -- Ensure snippet has necessary methods
        jump_info.has_update_all = type(snippet.update_all) == "function"
        jump_info.has_update = type(snippet.update) == "function"

        -- Save the entire jump chain for complete restoration
        -- This ensures all subsequent jumps work correctly after Copilot insertion
        jump_info.jump_chain = {}
        local temp_node = current_node
        local idx = 1
        -- Use a table to track visited nodes to detect circular references
        local visited_nodes = {}
        while temp_node and temp_node.next do
            -- Check if we've already seen this node (circular reference)
            if visited_nodes[temp_node.next] then
                -- We found a circular reference, break the loop
                break
            end

            -- Record this node as visited
            visited_nodes[temp_node.next] = true

            -- Store node information
            jump_info.jump_chain[idx] = {
                node = temp_node.next,
                pos = temp_node.next.pos,
                type = temp_node.next.type,
            }
            temp_node = temp_node.next
            idx = idx + 1
        end
    end

    -- Accept Copilot suggestion
    require("copilot.suggestion").accept()

    -- Restore LuaSnip state
    if jump_info then
        vim.schedule(function()
            -- Prevent other autocommands from triggering during restoration
            local old_jump_active = session.jump_active
            session.jump_active = true

            -- Reconnect all states
            session.current_nodes[current_buf] = jump_info.node

            -- Restore snippet_roots
            if jump_info.snippet_roots then
                session.snippet_roots[current_buf] = jump_info.snippet_roots
            end

            -- Restore active_choice_nodes
            if jump_info.active_choice_nodes then
                session.active_choice_nodes[current_buf] = jump_info.active_choice_nodes
            end

            -- Restore node link relationships
            if jump_info.node then
                if jump_info.next_node then jump_info.node.next = jump_info.next_node end
                if jump_info.prev_node then jump_info.node.prev = jump_info.prev_node end
            end

            -- Restore jump chain
            local prev_node = jump_info.node
            for _, jump_node_info in ipairs(jump_info.jump_chain) do
                if prev_node and jump_node_info.node then
                    prev_node.next = jump_node_info.node
                    jump_node_info.node.prev = prev_node
                    prev_node = jump_node_info.node
                end
            end

            -- Safely update extmarks
            if jump_info.snippet then
                -- Try to update all snippet extmarks
                if jump_info.has_update_all then
                    pcall(function() jump_info.snippet:update_all() end)
                elseif jump_info.has_update then
                    pcall(function() jump_info.snippet:update() end)
                end

                -- Update all insert_nodes
                for _, node in pairs(jump_info.insert_nodes or {}) do
                    if type(node.update) == "function" then pcall(function() node:update() end) end
                end

                -- Attempt to restore all node marks to their original positions
                -- This is critical for LuaSnip to correctly track snippet regions after text changes
                for node, mark_info in pairs(jump_info.node_marks or {}) do
                    if node.mark and node.mark.id then
                        -- Try to update existing marks safely
                        pcall(function()
                            -- Get current position after Copilot insertion
                            local current_begin, current_end = node.mark:pos_begin_end_raw()
                            -- Only update if positions have changed
                            if
                                not vim.deep_equal(current_begin, mark_info.begin_pos)
                                or not vim.deep_equal(current_end, mark_info.end_pos)
                            then
                                -- Restore mark to its original position with original options
                                node.mark:update(
                                    mark_info.opts,
                                    mark_info.begin_pos,
                                    mark_info.end_pos
                                )
                            end
                        end)
                    end
                end
            end

            -- Restore original jump_active state
            session.jump_active = old_jump_active
        end)
    end

    return true
end

return {
    {
        "Saghen/blink.cmp",
        dependencies = {
            { "Saghen/blink.compat" },
        },
        opts = {
            snippets = {
                preset = "luasnip",
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
                            snippets = 3,
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
                        auto_show = function(_)
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
                        if require("luasnip").expandable() then
                            vim.schedule(function() require("luasnip").expand() end)
                            return cmp.cancel()
                        end
                    end,
                    function(cmp)
                        if require("copilot.suggestion").is_visible() then
                            safe_copilot_accept()
                            cmp.cancel()
                            return cmp.cancel()
                        end
                    end,
                    function(_)
                        if require("luasnip").jumpable(1) then
                            require("luasnip").jump(1)
                            return true
                        end
                    end,
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
        "folke/noice.nvim",
        event = function(_) return "User IceLoad" end,
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
