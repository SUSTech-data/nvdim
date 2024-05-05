return {
    {
        "akinsho/bufferline.nvim",
        -- enabled = false,
        event = function() return "User IceLoad" end,
        opts = function(_, opts)
            opts.options = {
                -- mode = "tabs",
                always_show_bufferline = true,
            }
            return opts
        end,
        keys = {
            { "<S-h>", false },
            { "<S-l>", false },
        },
    },
    {
        "nanozuki/tabby.nvim",
        enabled = false,
        event = { "UIEnter" },
        config = function()
            require("tabby.tabline").use_preset("active_wins_at_tail", {
                tab_name = {
                    name_fallback = function(tabid)
                        return " " .. vim.fn.fnamemodify(vim.fn.getcwd(-1, tabid), ":~")
                    end,
                },
            })
        end,
    },
    {
        "folke/zen-mode.nvim",
        opts = {
            plugins = {
                wezterm = { enabled = true, font = "+2" },
            },
        },
        cmd = "ZenMode",
        keys = { { "<leader>uz", "<Cmd>ZenMode<CR>", desc = "Zen Mode" } },
        dependencies = { "folke/twilight.nvim", opts = {} },
    },
    {
        "sindrets/winshift.nvim",
        cmd = "WinShift",
        opts = { highlight_moving_win = true },
        -- keys = { "<leader>wS", "<CMD>WinShift<CR>", desc = "Win Shift/Swap" },
    },
    -- { "kwkarlwang/bufresize.nvim", opts = {}, event = "WinEnter" }, -- on terminal resize
    {
        "mrjones2014/smart-splits.nvim",
        keys = {
            { "<A-h>", function() require("smart-splits").move_cursor_left() end },
            { "<A-j>", function() require("smart-splits").move_cursor_down() end },
            { "<A-k>", function() require("smart-splits").move_cursor_up() end },
            { "<A-l>", function() require("smart-splits").move_cursor_right() end },
            { "<M-Left>", "<CMD>SmartResizeLeft<CR>" },
            { "<M-Down>", "<CMD>SmartResizeDown<CR>" },
            { "<M-Up>", "<CMD>SmartResizeUp<CR>" },
            { "<M-Right>", "<CMD>SmartResizeRight<CR>" },
        },
        build = "./kitty/install-kittens.bash",
        opts = {
            resize_mode = { hooks = { on_leave = function() require("bufresize").register() end } },
        },
    },
}
