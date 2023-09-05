local pairs_spec = {
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = true,
    },
    {
        "altermo/ultimate-autopair.nvim",
        enabled = false,
        event = { "InsertEnter", "CmdlineEnter" },
        opts = {
            --Config goes here
        },
    },
    {
        "kylechui/nvim-surround",
        event = "VeryLazy",
        opts = {
            keymaps = {
                insert = "<C-g>s",
                insert_line = "<C-g>S",
                normal = "ys",
                normal_cur = "yss",
                normal_line = "yS",
                normal_cur_line = "ySS",
                visual = "s",
                visual_line = "gs",
                delete = "sd",
                change = "sc",
                change_line = "cS",
            },
        },
    },
    {
        "nvim-treesitter/nvim-treesitter",
        dependencies = {
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

for key, v in pairs(pairs_spec) do
    v.vscode = true
end
return pairs_spec
