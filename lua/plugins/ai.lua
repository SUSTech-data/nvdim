return {
    -- {
    --     "sourcegraph/sg.nvim",
    --     event = "BufRead",
    --     dependencies = { "nvim-lua/plenary.nvim" },
    --     build = "nvim -l build/init.lua",
    -- },
    -- {
    --     "jcdickinson/codeium.nvim",
    --     enabled=false,
    --     event = "BufRead",
    --     dependencies = {
    --         "nvim-lua/plenary.nvim",
    --         "hrsh7th/nvim-cmp",
    --     },
    --     config = function() require("codeium").setup({}) end,
    -- },
    {
        "zbirenbaum/copilot.lua",
        event = "InsertEnter",
        cmd = "Copilot",
        opts = {
            suggestion = {
                enabled = true,
                auto_trigger = true,
                keymap = {
                    accept = "<M-i>",
                    accept_word = "<M-w>",
                    accept_line = "<M-l>",
                },
            },
            panel = { enabled = true, auto_refresh = true },
            filetypes = {
                markdown = true,
                help = true,
            },
        },
    },

    { "zbirenbaum/copilot-cmp", enabled = false },
}
