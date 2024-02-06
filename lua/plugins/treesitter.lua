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
                enabled = false,
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
            {
                "andymass/vim-matchup",
                config = function()
                    vim.cmd("nmap ; %")
                    -- vim.cmd("vmap ' %")
                    -- vim.cmd("omap ' %")
                end,
            },
            {
                "abecodes/tabout.nvim",
                opts = {
                    tabkey = "<tab>", -- key to trigger tabout, set to an empty string to disable
                    backwards_tabkey = "", -- key to trigger backwards tabout, set to an empty string to disable
                    act_as_tab = true, -- shift content if tab out is not possible
                    act_as_shift_tab = false, -- reverse shift content if tab out is not possible (if your keyboard/terminal supports <S-Tab>)
                    enable_backwards = true,
                    completion = true, -- if the tabkey is used in a completion pum
                    tabouts = {
                        { open = "'", close = "'" },
                        { open = '"', close = '"' },
                        { open = "`", close = "`" },
                        { open = "(", close = ")" },
                        { open = "[", close = "]" },
                        { open = "{", close = "}" },
                        { open = "⟨", close = "⟩" },
                    },
                    ignore_beginning = true, -- if the cursor is at the beginning of a filled element it will rather tab out than shift the content
                    exclude = {}, -- tabout will ignore these filetypes
                },
            },
        },
    },
}
