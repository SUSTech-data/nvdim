return {
    {
        "coffebar/project.nvim",
        event = { "CursorHold", "CursorHoldI" },
        config = function()
            require("project_nvim").setup({
                ignore_lsp = { "copilot" },
                silent_chdir = false,
                scope_chdir = "win",
            })
        end,
    },
    {
        "Shatur/neovim-session-manager",
        enabled = false,
        event = "VeryLazy",
        config = function()
            local Autoload = require("session_manager.config").AutoloadMode
            local mode = Autoload.LastSession
            local project_root, _ = require("project_nvim.project").get_project_root()
            if project_root ~= nil then mode = Autoload.CurrentDir end
            require("session_manager").setup({
                autoload_mode = mode,
                autosave_last_session = true,
                autosave_ignore_not_normal = false,
                autosave_ignore_filetypes = {
                    "ccc-ui",
                    "gitcommit",
                    "qf",
                },
                autosave_only_in_session = true,
            })
        end,
        keys = {
            {
                "<leader>qs",
                "<cmd>SessionManager save_current_session<CR>",
                desc = "session: start",
            },
            {
                "<leader>ql",
                "<cmd>SessionManager load_current_dir_session<CR>",
                desc = "session: load",
            },
            { "<leader>fp", "<cmd>Telescope projects<cr>" },
            -- { "<leader>fp", "<cmd>SessionLoad<cr>", desc = "session: load" },
            -- { "<leader>qd", "SessionDelete", desc = "session: start" },
        },
    },
    {
        "folke/persistence.nvim",
        enabled = false,
    },
    {
        "olimorris/persisted.nvim",
        cmd = {
            "SessionToggle",
            "SessionStart",
            "SessionStop",
            "SessionSave",
            "SessionLoad",
            "SessionLoadLast",
            "SessionLoadFromFile",
            "SessionDelete",
        },
        keys = {
            { "<leader>qs", "<cmd>SessionStart<CR>", desc = "session: start" },
            { "<leader>ql", "<cmd>SessionLoad<cr>", desc = "session: load" },
            { "<leader>fp", "<cmd>Telescope projects<cr>" },
            -- { "<leader>fp", "<cmd>SessionLoad<cr>", desc = "session: load" },
            -- { "<leader>qd", "SessionDelete", desc = "session: start" },
        },
        opts = {
            use_git_branch = true, -- create session files based on the branch of the git enabled repository
            should_autosave = function()
                return not vim.tbl_contains({ "alpha", "dashboard" }, vim.bo.filetype)
            end, -- function to determine if a session should be autosaved
        },
    },
}
