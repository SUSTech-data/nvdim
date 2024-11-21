vim.api.nvim_create_autocmd({ "BufRead", "BufEnter" }, {
    pattern = "*.yaml",
    callback = function()
        if vim.bo[vim.api.nvim_get_current_buf()].filetype == "helm" then
            vim.cmd("TSToggle highlight")
            vim.cmd("TSToggle highlight")
        end
    end,
})

return {
    {
        "towolf/vim-helm",
        ft = "helm",
        dependencis = {
            "nvim-treesitter/nvim-treesitter",
            opts = { ensure_installed = { "helm" } },
        },
    },
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                helm_ls = {},
            },
            setup = {
                yamlls = function()
                    LazyVim.lsp.on_attach(function(client, buffer)
                        if vim.bo[buffer].filetype == "helm" then
                            vim.schedule(function()
                                vim.cmd("LspStop ++force yamlls")
                                -- vim.cmd("TSToggle highlight")
                                -- vim.cmd("TSToggle highlight")
                            end)
                        end
                    end, "yamlls")
                end,
            },
        },
    },
}
