return {
    -- { "tpope/vim-fugitive", cmd = "G" }, -- Git commands in nvim
    -- 'tpope/vim-rhubarb' -- Fugitive-companion to interact with github
    {
        "sindrets/diffview.nvim",
        keys = {
            { "<leader>gh", "<Cmd>DiffviewFileHistory %<CR>", desc = "file history" },
            { "<leader>gH", "<Cmd>DiffviewFileHistory <CR>", desc = "Commit history" },
            { "<leader>gv", "<Cmd>DiffviewOpen<CR>", desc = "Diff View" },
        },
    },
    {
        "fredrikaverpil/pr.nvim",
        lazy = true,
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        ---@type PR.Config
        opts = {},
        keys = {
            {
                "<leader>gp",
                function() require("pr").view() end,
                desc = "View PR in browser",
            },
        },
    },
    {
        "johnseth97/gh-dash.nvim",
        cmd = { "GHdashToggle", "GHdash" },
        keys = {
            {
                "<leader>cc",
                function() require("gh_dash").toggle() end,
                desc = "Toggle gh-dash popup",
            },
        },
    },
}
