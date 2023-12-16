return {
    {
        "echasnovski/mini.map",
        config = function()
            local map = require("mini.map")
            map.setup({
                symbols = {
                    encode = require("mini.map").gen_encode_symbols.dot("4x2"),
                },
                integrations = {
                    require("mini.map").gen_integration.builtin_search(),
                    require("mini.map").gen_integration.gitsigns(),
                    require("mini.map").gen_integration.diagnostic(),
                },
                window = {
                    show_integration_count = false,
                },
            })
        end,
        keys = {
            { "<leader>mm", "<Cmd>lua MiniMap.toggle()<CR>", desc = "MiniMap" },
            { "<leader>mf", "<Cmd>lua MiniMap.toggle_focus()<CR>", desc = "MiniMap" },
            { "<leader>ms", "<Cmd>lua MiniMap.toggle_side()<CR>", desc = "MiniMap" },
        },
    },
    {
        "echasnovski/mini.bracketed",
        event = "VeryLazy",
        opts = {
            comment = { suffix = "gc" }, -- ]c is for git/diff change
            indent = { options = { change_type = "diff" } },
            treesitter = { suffix = "n" },
        },
        config = function(_, opts) require("mini.bracketed").setup(opts) end,
    },
    {
        "echasnovski/mini.indentscope",
        opts = {
            draw = {
                animation = require("mini.indentscope").gen_animation.none(),
            },
        },
    },
}
