return {
    {
        "yetone/avante.nvim",
        -- init = function() require("avante_lib").load() end,
        keys = { "<leader>a" },
        opts = {
            provider = "copilot",
            hints = { enabled = false },
        },
        build = LazyVim.is_win()
                and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
            or "make",
    },
    {
        "GeorgesAlkhouri/nvim-aider",
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
