return {
    {
        "nvim-treesitter/nvim-treesitter",
        event = function(event) return "User IceLoad" end,
        opts = function(_, opts)
            if type(opts.ensure_installed) == "table" then
                vim.list_extend(opts.ensure_installed, { "proto", "latex", "just" })
            end
            opts.indent.disable = { "yaml" }
            vim.treesitter.language.register("bash", "zsh")
        end,
        dependencies = {
            { "nvim-treesitter-textobjects", event = function(event) return "User IceLoad" end },
            -- { "mfussenegger/nvim-treehopper" },
            {
                "mizlan/iswap.nvim",
                keys = {
                    { "<leader>sw", ":ISwapNodeWith<CR>", desc = "swap node" },
                },
            },
            { "NvChad/nvim-colorizer.lua" },
            {
                "hiphish/rainbow-delimiters.nvim",
                -- enabled = false,
            },
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
                "aaronik/treewalker.nvim",
                cmd = "Treewalker",
                opts = {
                    highlight = true, -- default is false
                },
                keys = {
                    { "<Tab>", "<cmd>Treewalker Down<CR>" },
                    { "<S-Tab>", "<cmd>Treewalker Up<CR>" },
                },
            },
            {
                "sustech-data/wildfire.nvim",
                config = function(_, opts)
                    require("wildfire").setup(opts)
                    -- vim.api.nvim_set_keymap(
                    --     "n",
                    --     "<leader>a",
                    --     ":lua require'wildfire'.init_selection()<CR>:lua require('tsht').nodes()<CR>",
                    --     { noremap = true, silent = true }
                    -- )
                end,
            },
            {
                "andymass/vim-matchup",
                enabled = false, -- FIXME: this hert performance
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
            {
                "bennypowers/splitjoin.nvim",
                keys = {
                    {
                        "gj",
                        function() require("splitjoin").join() end,
                        desc = "Join the object under cursor",
                    },
                    {
                        "g,",
                        function() require("splitjoin").split() end,
                        desc = "Split the object under cursor",
                    },
                },
            },
            {
                "folke/ts-comments.nvim",
                opts = {
                    lang = {
                        just = "# %s",
                        rmd = "-- %s",
                        lean3 = "-- %s",
                        quarto = "<!-- %s -->",
                        markdown = "<!-- %s -->",
                        qmd = "-- %s",
                        toml = "# %s",
                        graphql = "# %s",
                    },
                },
            },
        },
    },
}
