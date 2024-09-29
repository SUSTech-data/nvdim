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
            vim.g.mkdp_auto_start = 0
            vim.g.mkdp_auto_close = 0
            vim.g.mkdp_theme = "light"
            vim.g.mkdp_combine_preview = 1
        end,
    },

    {
        "vhyrro/luarocks.nvim",
        priority = 1001, -- this plugin needs to run before anything else
        opts = {
            rocks = { "magick" },
        },
    },
    {
        "3rd/image.nvim",
        -- event = "BufRead",
        cond = function() return vim.g.neovide == nil and vim.g.vscode == nil end,
        ft = { "markdown", "norg", "rmd", "org", "quarto" },
        dependencies = { "luarocks.nvim" },
        config = function()
            -- default config
            require("image").setup({
                backend = "kitty",
                integrations = {
                    markdown = {
                        enabled = true,
                        clear_in_insert_mode = true,
                        download_remote_images = true,
                        only_render_image_at_cursor = true,
                        filetypes = { "markdown", "vimwiki", "quarto" }, -- markdown extensions (ie. quarto) can go here
                    },
                    neorg = {
                        enabled = true,
                        clear_in_insert_mode = false,
                        download_remote_images = true,
                        only_render_image_at_cursor = false,
                        filetypes = { "norg" },
                    },
                    html = {
                        enabled = false,
                    },
                    css = {
                        enabled = false,
                    },
                },
                max_width = 100,
                max_height = 12,
                max_width_window_percentage = math.huge,
                max_height_window_percentage = math.huge,
                window_overlap_clear_enabled = false, -- toggles images when windows are overlapped
                window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
                editor_only_render_when_focused = false, -- auto show/hide images when the editor gains/looses focus
                tmux_show_only_in_active_window = false, -- auto show/hide images in the correct Tmux window (needs visual-activity off)
                hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp" }, -- render image files as images when opened
            })
        end,
    },
}
