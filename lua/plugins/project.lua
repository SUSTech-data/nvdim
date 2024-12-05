return {
    {
        "coffebar/project.nvim",
        event = "BufRead",
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
    }, -- Lazy.nvim
    {
        "you-n-g/navigate-note.nvim",
        event = "BufRead",
        opts = {
            filename = "nav.md", -- The filename of the markdown.
            width = 0.6, -- The width of the popup window when jumping in the file with <tab>.
            keymaps = {
                nav_mode = {
                    -- Navigation & Jumping
                    next = "<tab>",
                    prev = "<s-tab>",
                    open = "<cr>",
                    switch_back = "<leader>nb", -- Switch back to the previous file from `nav.md`.
                    -- Editing
                    append_link = "<leader>np", -- (P)aste will more align with the meaning.
                    -- Mode switching
                    -- jump_mode = "<m-l>", -- When we jump to a file, jump to the file only or jump to the exact file:line.
                },
                add = "<leader>na",
                open_nav = "<leader>nn", -- Switch to `nav.md`.
            },
            context_line_count = { -- It would be a total of `2 * context_line_count - 1` lines.
                tab = 4,
                vline = 5,
            },
        },
    },
}
