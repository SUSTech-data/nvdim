return {
    {
        "yetone/avante.nvim",
        event = "VeryLazy",
        dependencies = {
            "stevearc/dressing.nvim",
            "ibhagwan/fzf-lua",
        },
        opts = {
            provider = "openrouter",
            hints = { enabled = false },
            auto_suggestions_provider = "openrouter_qwen", -- Since auto-suggestions are a high-frequency operation and therefore expensive, it is recommended to specify an inexpensive provider or even a free provider: copilot
            cursor_applying_provider = "openrouter_qwen",
            vendors = {
                openrouter_gemini = {
                    __inherited_from = "openai",
                    endpoint = "https://openrouter.ai/api/v1",
                    api_key_name = "OPENROUTER_API_KEY",
                    model = "google/gemini-2.5-pro-preview-03-25",
                },
                openrouter_qwen = {
                    __inherited_from = "openai",
                    endpoint = "https://openrouter.ai/api/v1",
                    api_key_name = "OPENROUTER_API_KEY",
                    model = "qwen/qwen-2.5-coder-32b-instruct",
                },
                openrouter = {
                    __inherited_from = "openai",
                    endpoint = "https://openrouter.ai/api/v1",
                    api_key_name = "OPENROUTER_API_KEY",
                    model = "anthropic/claude-3.7-sonnet",
                },
            },
            -- File selector configuration
            file_selector = {
                provider = "telescope", -- Avoid native provider issues
                provider_opts = {},
            },
            behaviour = {
                enable_cursor_planning_mode = false,
                enable_claude_text_editor_tool_mode = true,
                auto_suggestions = false,
            },
        },
        build = LazyVim.is_win()
                and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
            or "make",
        keys = {
            { "<leader>aC", "<cmd>AvanteClear<cr>", desc = "avante: clear" },
        },
    },
    {
        "MeanderingProgrammer/render-markdown.nvim",
        optional = true,
        ft = function(_, ft) vim.list_extend(ft, { "Avante" }) end,
        opts = function(_, opts)
            opts.file_types = vim.list_extend(opts.file_types or {}, { "Avante" })
        end,
    },
    {
        "folke/which-key.nvim",
        optional = true,
        opts = {
            spec = {
                { "<leader>a", group = "ai" },
            },
        },
    },
    {
        "GeorgesAlkhouri/nvim-aider",
        enabled = false,
        cmd = {
            "Aider",
        },
        keys = {
            { "<leader>a/", "<cmd>Aider toggle<cr>", desc = "Toggle Aider" },
            { "<leader>as", "<cmd>Aider send<cr>", desc = "Send to Aider", mode = { "n", "v" } },
            { "<leader>ac", "<cmd>Aider command<cr>", desc = "Aider Commands" },
            { "<leader>ab", "<cmd>Aider buffer<cr>", desc = "Send Buffer" },
            { "<leader>a+", "<cmd>Aider add<cr>", desc = "Add File" },
            { "<leader>a-", "<cmd>Aider drop<cr>", desc = "Drop File" },
            { "<leader>ar", "<cmd>Aider add readonly<cr>", desc = "Add Read-Only" },
            {
                "<leader>aa",
                function()
                    local buffers = vim.api.nvim_list_bufs()
                    local api = require("nvim_aider").api
                    for _, bufnr in ipairs(buffers) do
                        if vim.api.nvim_buf_is_valid(bufnr) then
                            local bufname = vim.api.nvim_buf_get_name(bufnr)
                            if bufname:find("^" .. LazyVim.root()) then api.add_file(bufname) end
                        end
                    end
                end,
                desc = "Add all Buffer",
            },
        },
        dependencies = {
            "folke/snacks.nvim",
            --- The below dependencies are optional
            "catppuccin/nvim",
            "nvim-tree/nvim-tree.lua",
        },
        config = true,
    },
}
