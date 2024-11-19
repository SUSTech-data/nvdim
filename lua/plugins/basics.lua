return {
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                basics_ls = {
                    settings = {
                        buffer = {
                            enable = true,
                            minCompletionLength = 4, -- only provide completions for words longer than 4 characters
                            matchStrategy = "exact", -- or 'fuzzy'
                        },
                        path = {
                            enable = true,
                        },
                        snippet = {
                            enable = false,
                            sources = {}, -- paths to package containing snippets, see examples below
                            matchStrategy = "exact", -- or 'fuzzy'
                        },
                    },
                },
            },
        },
    },
    {
        "williamboman/mason.nvim",
        opts = { ensure_installed = { "basics-language-server" } },
    },
}
