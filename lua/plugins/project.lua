return {
    {
        "coffebar/project.nvim",
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
        lazy = false,
    },
    {
        "coffebar/neovim-project",
        enabled = false,
        opts = {
            projects = { -- define project roots
                "~/codes/*",
                "~/.config/*",
                "~/Nutstore Files/codes/*",
                "~/Nutstore Files/codes/nvim-plugins/*",
            },
        },
        init = function()
            -- enable saving the state of plugins in the session
            vim.opt.sessionoptions:append("globals") -- save global variables that start with an uppercase letter and contain at least one lowercase letter.
        end,
        dependencies = {
            { "nvim-lua/plenary.nvim" },
            { "nvim-telescope/telescope.nvim" },
            { "Shatur/neovim-session-manager" },
        },
        lazy = false,
        priority = 100,
    },
    {
        "Shatur/neovim-session-manager",
        enabled = false,
        event = "VeryLazy",
        opts = {
            autosave_ignore_filetypes = { -- All buffers of these file types will be closed before the session is saved.
                "gitcommit",
                "gitrebase",
            },
        },
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
