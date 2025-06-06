return {
    {
        "folke/snacks.nvim",
        opts = { image = {} },
    },
    {
        "iamcco/markdown-preview.nvim",
        build = "cd app && yarn install",
        ft = { "quarto", "markdown", "rmd" },
        keys = {
            { "<leader>cp", false },
            {
                "<leader>pv",
                "<cmd>MarkdownPreviewToggle<cr>",
                desc = "Markdown Preview",
            },
        },
        init = function()
            vim.g.mkdp_preview_options = {
                mkit = {},
                katex = {},
                uml = {},
                maid = {},
                disable_sync_scroll = 0,
                sync_scroll_type = "middle",
                hide_yaml_meta = 1,
                sequence_diagrams = {},
                flowchart_diagrams = {},
                content_editable = false,
                disable_filename = 0,
            }

            vim.g.mkdp_command_for_global = 1
            vim.g.mkdp_echo_preview_url = 1
            vim.g.mkdp_open_to_the_world = 1
            -- vim.g.mkdp_port = '8296'
            vim.g.mkdp_page_title = "MarkdownPreview「${name}」"
            vim.g.mkdp_open_ip = ""

            -- Use a custom port to start server or random for empty
            vim.g.mkdp_port = ""
            vim.g.mkdp_auto_start = 0
            vim.g.mkdp_auto_close = 0
            vim.g.mkdp_theme = "light"
            vim.g.mkdp_combine_preview = 1
        end,
    },

    {
        "MeanderingProgrammer/render-markdown.nvim",
        ft = { "markdown", "norg", "rmd", "org", "quarto" },
    },
    {
        "neovim/nvim-lspconfig",
        -- opts = function(_, opts)
        --     opts.servers["protols"] = {}
        --     opts.servers["clangd"].filetypes = { "c", "cpp", "cuda" }
        -- end,
        opts = {
            servers = {
                marksman = false,
            },
        },
    },
    {
        "mfussenegger/nvim-lint",
        opts = {
            linters = {
                -- https://github.com/LazyVim/LazyVim/discussions/4094#discussioncomment-10178217
                ["markdownlint-cli2"] = {
                    args = {
                        "--config",
                        ---@diagnostic disable-next-line: param-type-mismatch
                        vim.fs.joinpath(vim.fn.stdpath("config"), "markdownlint.yaml"),
                        "--",
                    },
                },
            },
        },
    },
}
