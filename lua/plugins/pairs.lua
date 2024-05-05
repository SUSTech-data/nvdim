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
        event = "User IceLoad",
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
}

for key, v in pairs(pairs_spec) do
    v.vscode = true
end
return pairs_spec
