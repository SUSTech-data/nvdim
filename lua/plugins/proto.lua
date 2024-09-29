return {
    {
        "neovim/nvim-lspconfig",
        -- opts = function(_, opts)
        --     opts.servers["protols"] = {}
        --     opts.servers["clangd"].filetypes = { "c", "cpp", "cuda" }
        -- end,
        opts = {
            servers = {
                protols = {},
                clangd = { filetypes = { "c", "cpp", "cuda" } },
            },
        },
    },
    {
        "williamboman/mason.nvim",
        opts = { ensure_installed = { "protols" } },
    },
    -- {
    --     "nvim-treesitter/nvim-treesitter",
    --     opts = function(_, opts)
    --         if type(opts.ensure_installed) == "table" then
    --             vim.list_extend(opts.ensure_installed, { "proto" })
    --         end
    --     end,
    -- },
}
