local editor = {
    {
        "mattboehm/vim-unstack",
        cmd = { "UnstackFromSelection", "UnstackFromClipboard", "Unstack" },
    },
    {
        "Pocco81/auto-save.nvim",
        event = "User IceLoad",
        cond = vim.env.KITTY_SCROLLBACK_NVIM ~= "true",
        opts = {
            enabled = true,
            execution_message = {
                message = function()
                    return " AutoSave: saved at " .. vim.fn.strftime("%H:%M:%S")
                end,
                dim = 0.18,
                cleaning_interval = 1250,
            },
            trigger_events = { "InsertLeave", "TextChanged" },
            condition = function(buf)
                local fn = vim.fn
                local utils = require("auto-save.utils.data")

                if
                    fn.getbufvar(buf, "&modifiable") == 1
                    and utils.not_in(fn.getbufvar(buf, "&filetype"), { "oil", "OverseerForm", "harpoon" })
                then
                    return true -- met condition(s), can save
                end
                return false -- can't save
            end,
            write_all_buffers = false,
            on_off_commands = true,
            clean_command_line_interval = 0,
            debounce_delay = 135,
        },
    },
    { "lambdalisue/suda.vim", cmd = { "SudaRead", "SudaWrite" } },
    {
        "tzachar/highlight-undo.nvim",
        event = "BufReadPost",
        config = true,
    },
    {
        "kevinhwang91/rnvimr",
        enabled = false,
        cmd = "RnvimrToggle",
        keys = { { "<leader>ee", ":RnvimrToggle<CR>", desc = "ranger" } },
        config = function()
            vim.g.rnvimr_enable_ex = 1
            vim.g.rnvimr_enable_picker = 1
            vim.g.rnvimr_draw_border = 1
            vim.g.rnvimr_enable_bw = 1
            vim.g.rnvimr_action = {
                ["<C-t>"] = "NvimEdit tabedit",
                ["<C-x>"] = "NvimEdit split",
                ["<C-v>"] = "NvimEdit vsplit",
                ["gw"] = "JumpNvimCwd",
                ["yw"] = "EmitRangerCwd",
            }
            vim.g.rnvimr_ranger_views = {
                { minwidth = 90, ratio = {} },
                { minwidth = 50, maxwidth = 89, ratio = { 1, 1 } },
                { maxwidth = 49, ratio = { 1 } },
            }
        end,
    },
    {
        "mikavilpas/yazi.nvim",
        keys = {
            -- 👇 in this section, choose your own keymappings!
            {
                "<leader>ef",
                "<cmd>Yazi<cr>",
                desc = "Open yazi at the current file",
            },
            {
                -- Open in the current working directory
                "<leader>ew",
                "<cmd>Yazi cwd<cr>",
                desc = "Open the file manager in nvim's working directory",
            },
            {
                -- NOTE: this requires a version of yazi that includes
                -- https://github.com/sxyazi/yazi/pull/1305 from 2024-07-18
                "<leader>ee",
                "<cmd>Yazi toggle<cr>",
                desc = "Resume the last yazi session",
            },
        },
        opts = {
            -- if you want to open yazi instead of netrw, see below for more info
            open_for_directories = true,
            keymaps = {
                show_help = "<f1>",
            },
        },
    },
    {
        "roobert/hoversplit.nvim",
        enabled = false,
        event = "LspAttach",
        config = true,
    },
    {
        "wsdjeg/vim-fetch",
        enabled = false,
        -- event = "VeryLazy",
        config = true,
    },
    {
        "stevearc/aerial.nvim",
        keys = {
            -- { "go", "<cmd>AerialToggle<cr>", desc = "Aerial (Symbols)" },
            { "<Tab>", "<cmd>AerialNext<CR>" },
            { "<S-Tab>", "<cmd>AerialPrev<CR>" },
        },
    },
}

return editor
