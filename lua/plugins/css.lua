return {
    {
        "stevearc/conform.nvim",
        keys = {
            { "<leader>cF", false },
            {
                "<leader>fm",
                -- function() require("conform").format({ formatters = { "injected" } }) end,
                "<cmd>LazyFormat<CR>",
                mode = { "n", "v" },
                desc = "Format Injected Langs",
            },
        },
        opts = {
            formatters_by_ft = {
                just = { "just" },
                scss = { "prettier" },
                css = { "prettierd", "prettier", "stylelint" },
            },
        },
    },
}
