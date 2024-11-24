return {
    {
        "coffebar/project.nvim",
        event = "User IceLoad",
        config = function()
            require("project_nvim").setup({
                ignore_lsp = { "copilot" },
                silent_chdir = true,
                scope_chdir = "global",
                patterns = {
                    "!>home",
                    "!=tmp",
                    ".lazy.lua",
                    ".justfile",
                    ".git",
                    ".idea",
                    ".svn",
                    "PKGBUILD",
                    "composer.json",
                    "package.json",
                    "Makefile",
                    "README.md",
                    "Cargo.toml",
                },
            })
        end,
        lazy = true,
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
            { "<leader>fp", "<cmd>Telescope persisted<cr>" },
            -- { "<leader>fp", "<cmd>SessionLoad<cr>", desc = "session: load" },
            -- { "<leader>qd", "SessionDelete", desc = "session: start" },
        },
        opts = {
            -- autoload = true,
            autostart = true,
            use_git_branch = false, -- create session files based on the branch of the git enabled repository
            should_save = function()
                return not vim.tbl_contains(
                    { "alpha", "dashboard", "snacks_dashboard", "oil", "harpoon" },
                    vim.bo.filetype
                )
            end, -- function to determine if a session should be autosaved
        },
    },
    {
        "folke/persistence.nvim",
        enabled = false,
        event = "BufReadPre",
        opts = {},
    },
}
