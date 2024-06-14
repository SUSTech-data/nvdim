return {
    -- { "IndianBoy42/tree-sitter-just", ft = { "just" }, config = true },
    { "NoahTheDuke/vim-just", ft = { "just" } },
    {
        "catppuccin",
        optional = true,
        opts = {
            integrations = { overseer = true },
        },
    },
    {
        "folke/which-key.nvim",
        event = function(event) return "User IceLoad" end,
        opts = {
            defaults = {
                ["<leader>o"] = { name = "+overseer" },
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
        cmd = {
            "OverseerOpen",
            "OverseerClose",
            "OverseerToggle",
            "OverseerSaveBundle",
            "OverseerLoadBundle",
            "OverseerDeleteBundle",
            "OverseerRunCmd",
            "OverseerRun",
            "OverseerInfo",
            "OverseerBuild",
            "OverseerQuickAction",
            "OverseerTaskAction",
            "OverseerClearCache",
        },
        dependencies = "nvim-telescope/telescope.nvim",
        opts = {
            dap = false,
            task_list = {
                bindings = {
                    ["<C-h>"] = false,
                    ["<C-j>"] = false,
                    ["<C-k>"] = false,
                    ["<C-l>"] = false,
                },
            },
            form = {
                win_opts = {
                    winblend = 0,
                },
            },
            confirm = {
                win_opts = {
                    winblend = 0,
                },
            },
            task_win = {
                win_opts = {
                    winblend = 0,
                },
            },
        },
    -- stylua: ignore
    keys = {
      { "<leader>ow", "<cmd>OverseerToggle<cr>",      desc = "Task list" },
      { "<leader>oo", "<cmd>OverseerRun<cr>",         desc = "Run task" },
      { "<leader>oq", "<cmd>OverseerQuickAction<cr>", desc = "Action recent task" },
      { "<leader>oi", "<cmd>OverseerInfo<cr>",        desc = "Overseer Info" },
      { "<leader>ob", "<cmd>OverseerBuild<cr>",       desc = "Task builder" },
      { "<leader>ot", "<cmd>OverseerTaskAction<cr>",  desc = "Task action" },
      { "<leader>oc", "<cmd>OverseerClearCache<cr>",  desc = "Clear cache" },
    },
    },
}
