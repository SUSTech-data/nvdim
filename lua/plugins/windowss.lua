return {
    {
        "akinsho/bufferline.nvim",
        opts = {
            options = {
                -- always_show_bufferline = true,
                diagnostics = false,
                diagnostics_indicator = false,
            },
        },
        keys = {
            { "<S-h>", false },
            { "<S-l>", false },
        },
    },
    {
        "leath-dub/snipe.nvim",
        keys = {
            {
                "gb",
                function() require("snipe").open_buffer_menu() end,
                desc = "Open Snipe buffer menu",
            },
        },
        opts = {},
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
        opts = { highlight_moving_win = true },
        keys = {
            { "<leader>ws", "<CMD>WinShift<CR>", desc = "Win Shift/Swap" },
            { "<C-w>s", "<CMD>WinShift<CR>", desc = "Win Shift/Swap" },
        },
    },
    -- { "kwkarlwang/bufresize.nvim", opts = {}, event = "WinEnter" }, -- on terminal resize
    {
        "mrjones2014/smart-splits.nvim",
        event = { "UIEnter" },
        keys = {
            {
                "<A-h>",
                function() require("smart-splits").move_cursor_left() end,
                mode = { "n", "x", "o", "i", "t" },
            },
            {
                "<A-j>",
                function() require("smart-splits").move_cursor_down() end,
                mode = { "n", "x", "o", "i", "t" },
            },
            {
                "<A-k>",
                function() require("smart-splits").move_cursor_up() end,
                mode = { "n", "x", "o", "i", "t" },
            },
            {
                "<A-l>",
                function() require("smart-splits").move_cursor_right() end,
                mode = { "n", "x", "o", "i", "t" },
            },
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
    {
        "s1n7ax/nvim-window-picker",
        keys = {
            {
                "<A-a>",
                function()
                    local pick_id = require("window-picker").pick_window()
                        or vim.api.nvim_get_current_win()
                    vim.api.nvim_set_current_win(pick_id)
                end,
            },
        },
        name = "window-picker",
        -- version = "2.*",
        opts = {
            hint = "floating-big-letter",
            selection_chars = "FJDKSLA;CMRUEIWOQP",
            filter_rules = {
                include_current_win = false,
                autoselect_one = true,
                -- filter using buffer options
                bo = {
                    -- if the file type is one of following, the window will be ignored
                    filetype = {
                        "neo-tree",
                        "neo-tree-popup",
                        "notify",
                        "noice",
                        "lualine",
                        "incline",
                    },
                    -- if the buffer type is one of following, the window will be ignored
                    buftype = { "terminal", "quickfix" },
                },
            },
        },
        config = true,
        -- config = function()
        --     require("window-picker").setup({
        --         hint = "floating-big-letter",
        --     })
        -- end,
    },
    {
        "nvim-zh/colorful-winsep.nvim",
        config = true,
        event = { "WinLeave" },
    },
}
