return {
    {
        "fecet/claudecode.nvim",
        cmd = { "ClaudeCodeStart" },
        -- event = "User IceLoad",
        opts = {
            -- port_range = { min = 65535, max = 65535 }, -- WebSocket server port range
            log_level = "trace",
            terminal = {
                provider = "external",
                provider_opts = {
                    external_terminal_cmd = "kitty -e %s",
                },
            },
            streamable = {
                enabled = true, -- Streamable MCP server enabled by default
                path = "/mcp", -- Streamable endpoint path
                require_auth = false, -- Whether to require authentication for streamable connections (default on)
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
