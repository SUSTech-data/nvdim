return {
    {
        "nvim-treesitter/nvim-treesitter",
        keys = {
            { "<leader>sw", ":ISwapNodeWith<CR>", desc = "swap node" },
        },
        dependencies = {
            { "mfussenegger/nvim-treehopper" },
            { "mizlan/iswap.nvim" },
            { "NvChad/nvim-colorizer.lua" },
            { "JoosepAlviste/nvim-ts-context-commentstring" },
            {
                "roobert/tabtree.nvim",
                -- config = function() require("tabtree").setup() end,
                -- enabled = false,
                keys = {
                    {
                        "<Tab>",
                        function() require("tabtree").next() end,
                        desc = "tree tab next",
                        mode = { "n", "x", "o" },
                    },
                    {
                        "<S-Tab>",
                        function() require("tabtree").previous() end,
                        desc = "tree tab previous",
                        mode = { "n", "x", "o" },
                    },
                },
                opts = {
                    key_bindings_disabled = true,
                },
            },
            {
                "sustech-data/wildfire.nvim",
                config = function(_, opts)
                    require("wildfire").setup(opts)
                    vim.api.nvim_set_keymap(
                        "n",
                        "<leader>a",
                        ":lua require'wildfire'.init_selection()<CR>:lua require('tsht').nodes()<CR>",
                        { noremap = true, silent = true }
                    )
                end,
            },
        },
    },
}
