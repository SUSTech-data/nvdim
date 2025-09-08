return {
    {
        "yetone/avante.nvim",
        enabled = false,
        event = "VeryLazy",
        dependencies = {
            "stevearc/dressing.nvim",
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
                provider = "snacks", -- Avoid native provider issues
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
        "fecet/claudecode.nvim",
        cmd = { "ClaudeCodeStart" },
        -- event = "User IceLoad",
        opts = {
            log_level = "debug",
            terminal = {
                provider = "external",
                provider_opts = {
                    external_terminal_cmd = "kitty -e %s",
                },
            },
        },
        config = true,
        keys = {
            { "<leader>a", nil, desc = "AI/Claude Code" },
            { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
            -- { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
            { "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
            { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
            { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
            { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
            {
                "<leader>as",
                "<cmd>ClaudeCodeTreeAdd<cr>",
                desc = "Add file",
                ft = { "NvimTree", "neo-tree", "oil" },
            },
            -- Diff management
            { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
            { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
        },
    },
}
