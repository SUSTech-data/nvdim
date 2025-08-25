local editor = {
    {
        "mattboehm/vim-unstack",
        cmd = { "UnstackFromSelection", "UnstackFromClipboard", "Unstack" },
    },
    {
        "okuuva/auto-save.nvim",
        event = "User IceLoad",
        cond = vim.env.KITTY_SCROLLBACK_NVIM ~= "true",
        opts = {
            execution_message = {
                message = function()
                    return " AutoSave: saved at " .. vim.fn.strftime("%H:%M:%S")
                end,
                dim = 0.18,
                cleaning_interval = 1250,
            },
            condition = function(buf)
                -- some recommended exclusions. you can use `:lua print(vim.bo.filetype)` to
                -- get the filetype string of the current buffer
                local excluded_filetypes = {
                    -- this one is especially useful if you use neovim as a commit message editor
                    "gitcommit",
                    -- most of these are usually set to non-modifiable, which prevents autosaving
                    -- by default, but it doesn't hurt to be extra safe.
                    "NvimTree",
                    "Outline",
                    "TelescopePrompt",
                    "alpha",
                    "dashboard",
                    "lazygit",
                    "neo-tree",
                    "oil",
                    "prompt",
                    "toggleterm",
                    "OverseerForm",
                    "harpoon",
                    "VoltWindow",
                }
                local buf_filetype = vim.fn.getbufvar(buf, "&filetype")
                if
                    buf_filetype == ""
                    or vim.tbl_contains(excluded_filetypes, buf_filetype)
                    or string.match(vim.fn.expand("%:t"), "%[Claude Code]")
                then
                    return false
                end
                return true
            end,
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
            -- { "<Tab>", "<cmd>AerialNext<CR>" },
            -- { "<S-Tab>", "<cmd>AerialPrev<CR>" },
        },
    },
}

return editor
