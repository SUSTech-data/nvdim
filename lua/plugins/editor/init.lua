local editor = {
    {
        "mattboehm/vim-unstack",
        cmd = { "UnstackFromSelection", "UnstackFromClipboard", "Unstack" },
    },
    {
        "Pocco81/auto-save.nvim",
        event = "BufRead",
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
            conditions = {
                exists = true,
                filetype_is_not = { "oil" },
                modifiable = true,
            },
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
        "roobert/hoversplit.nvim",
        enabled = false,
        event = "LspAttach",
        config = true,
    },
    
}

return editor
