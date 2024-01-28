return {
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
            vim.g.mkdp_auto_start = false
            vim.g.mkdp_auto_close = false
        end,
    },
    {
        "lukas-reineke/headlines.nvim",
        opts = function()
            local opts = {}
            for _, ft in ipairs({ "markdown", "norg", "rmd", "org", "quarto" }) do
                opts[ft] = {
                    headline_highlights = {},
                }
                for i = 1, 6 do
                    local hl = "Headline" .. i
                    vim.api.nvim_set_hl(0, hl, { link = "Headline", default = true })
                    table.insert(opts[ft].headline_highlights, hl)
                end
            end
            return opts
        end,
        ft = { "markdown", "norg", "rmd", "org", "quarto" },
    },
    {
        "quarto-dev/quarto-nvim",
        opts = {
            lspFeatures = {
                languages = { "r", "python", "julia", "bash", "html", "lua" },
            },
            keymap = { hover = "D" },
        },
        ft = "quarto",
    },

    {
        "jmbuhr/otter.nvim",
        -- enabled = false,
        opts = {
            buffers = {
                set_filetype = false,
            },
        },
    },
}
