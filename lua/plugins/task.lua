return {
    -- { "IndianBoy42/tree-sitter-just", ft = { "just" }, config = true },
    -- { "NoahTheDuke/vim-just", ft = { "just" } },

    {
        "folke/which-key.nvim",
        event = function(event) return "User IceLoad" end,
        opts = {
            spec = {
                ["<leader>o"] = { group = "overseer" },
            },
        },
    },
    {
        "nvim-lualine/lualine.nvim",
        optional = true,
        opts = function(_, opts)
            local overseer = require("overseer")
            table.insert(opts.sections.lualine_x, {
                "overseer",
                label = "", -- Prefix for task counts
                colored = true, -- Color the task icons and counts
                symbols = {
                    [overseer.STATUS.CANCELED] = " ",
                    [overseer.STATUS.FAILURE] = " ",
                    [overseer.STATUS.SUCCESS] = " ",
                    [overseer.STATUS.RUNNING] = " ",
                },
                unique = false, -- Unique-ify non-running task count by name
                name = nil, -- List of task names to search for
                name_not = false, -- When true, invert the name search
                status = nil, -- List of task statuses to display
                status_not = false, -- When true, invert the status search
            })
        end,
    },
    {
        "stevearc/overseer.nvim",
        opts = {
            templates = {
                "cargo",
                "just",
                "make",
                "npm",
                -- "shell",
                "tox",
                "vscode",
                "mage",
                "mix",
                "deno",
                "rake",
                "task",
                "composer",
                "cargo-make",
            },
        },
    },
}
