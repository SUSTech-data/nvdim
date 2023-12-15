return {
    {
        "smoka7/hop.nvim",
        event = { "CursorHold", "CursorHoldI" },
        opts = { keys = "etovxqpdygfblzhckisuran" },
        keys = {
            -- {
            --     "f",
            --     "<cmd>HopAnywhereCurrentLine<CR>",
            --     mode = { "n", "x", "o" },
            -- },
            {
                "F",
                "<cmd>HopWordMW<CR>",
                mode = { "n", "x", "o" },
            },
            {
                "<leader>l",
                "<cmd>HopLineMW<CR>",
                mode = { "n", "x", "o" },
            },
        },
    },
    {
        "folke/flash.nvim",
        opts = {
            labels = "fjdklsa'oqcvnbgherioptyu",
            modes = {
                char = { enabled = false },
            },
            jump = { autojump = true, nohlsearch = false },
        },
        keys = function()
            return {
                -- {
                --     "R",
                --     mode = { "o", "x" },
                --     function() require("flash").treesitter_search() end,
                --     desc = "Treesitter Search",
                -- },
                {
                    "f",
                    mode = { "n", "x", "o" },
                    function() require("flash").jump() end,
                    desc = "Flash",
                },
                -- {
                --     "<leader>l",
                --     mode = { "n", "x", "o" },
                --     function()
                --         require("flash").jump({
                --             search = { mode = "search", max_length = 0 },
                --             label = { after = { 0, 0 } },
                --             pattern = "^",
                --         })
                --         -- vim.schedule(require("user.utils").schedule_command)
                --     end,
                --     desc = "Label beginning of line",
                -- },
                -- {
                --     "f",
                --     mode = { "n", "x", "o" },
                --     function()
                --         local Flash = require("flash")
                --
                --         local function format(opts)
                --             -- always show first and second label
                --             return {
                --                 { opts.match.label1, "FlashMatch" },
                --                 { opts.match.label2, "FlashLabel" },
                --             }
                --         end
                --
                --         Flash.jump({
                --             search = { mode = "search" },
                --             label = {
                --                 after = false,
                --                 before = { 0, 0 },
                --                 uppercase = false,
                --                 format = format,
                --             },
                --             pattern = [[\<]],
                --             action = function(match, state)
                --                 state:hide()
                --                 Flash.jump({
                --                     search = { max_length = 0 },
                --                     highlight = { matches = false },
                --                     label = { format = format },
                --                     matcher = function(win)
                --                         -- limit matches to the current label
                --                         return vim.tbl_filter(
                --                             function(m)
                --                                 return m.label == match.label and m.win == win
                --                             end,
                --                             state.results
                --                         )
                --                     end,
                --                     labeler = function(matches)
                --                         for _, m in ipairs(matches) do
                --                             m.label = m.label2 -- use the second label
                --                         end
                --                     end,
                --                 })
                --             end,
                --             labeler = function(matches, state)
                --                 local labels = state:labels()
                --                 for m, match in ipairs(matches) do
                --                     match.label1 = labels[math.floor((m - 1) / #labels) + 1]
                --                     match.label2 = labels[(m - 1) % #labels + 1]
                --                     match.label = match.label1
                --                 end
                --             end,
                --         })
                --     end,
                --     desc = "Flash",
                -- },
            }
        end,
    },
    {
        "chrisgrieser/nvim-spider",
        enabled = false,
        keys = {
            {
                "w",
                "<cmd>lua require('spider').motion('w')<CR>",
                desc = "spider-w",
                mode = { "n", "o", "x" },
            },
            {
                "e",
                "<cmd>lua require('spider').motion('e')<CR>",
                desc = "spider-e",
                mode = { "n", "o", "x" },
            },
            {
                "b",
                "<cmd>lua require('spider').motion('b')<CR>",
                desc = "spider-b",
                mode = { "n", "o", "x" },
            },
            { "<C-w>", "<Esc>cvb", mode = { "i" }, remap = true },
        },
        config = true,
    },
}
