return {
    {
        "smoka7/hop.nvim",
        -- event = function() return "User IceLoad" end,
        opts = { keys = "etovxqpdygfblzhckisuran" },
        keys = {
            -- {
            --     "f",
            --     "<cmd>HopAnywhereCurrentLine<CR>",
            --     mode = { "n", "x", "o" },
            -- },
            {
                "S",
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
        event = function() return "User IceLoad" end,
        opts = {
            labels = "fjdklsa'oqcvnbgheriptyu",
            modes = {
                char = { enabled = true },
            },
            jump = { autojump = true, nohlsearch = false },
        },
        keys = function()
            return {
                -- {
                --     "S",
                --     mode = { "n", "x", "o" },
                --     function() require("flash").jump() end,
                --     desc = "Flash",
                -- },
            }
        end,
    },
    {
        "rainzm/flash-zh.nvim",
        dependencies = "folke/flash.nvim",
        keys = {
            {
                "F",
                mode = { "n", "x", "o" },
                function()
                    require("flash-zh").jump({
                        chinese_only = false,
                    })
                end,
                desc = "Flash between Chinese",
            },
        },
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
