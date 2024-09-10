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
}
