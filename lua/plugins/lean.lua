return {
    {
        "Julian/lean.nvim",
        -- event="BufReadPre",
        ft = { "lean", "lean3" },
        opts = {
            lsp = {},
            -- lsp3 = {
            --     -- cmd = { "lean-language-server", "--stdio", "--", "-M", "16384", "-T", "100000" },
            --     -- filetypes = { "lean", "lean3" },
            -- },
            mappings = true,
        },
    },
}
