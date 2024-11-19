return {
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
            { "<leader>fp", "<cmd>Telescope persisted<cr>" },
            -- { "<leader>fp", "<cmd>SessionLoad<cr>", desc = "session: load" },
            -- { "<leader>qd", "SessionDelete", desc = "session: start" },
        },
        opts = {
            -- autoload = true,
            autostart = true,
            use_git_branch = true, -- create session files based on the branch of the git enabled repository
            should_save = function()
                return not vim.tbl_contains({ "alpha", "dashboard" }, vim.bo.filetype)
            end, -- function to determine if a session should be autosaved
        },
    },
}
