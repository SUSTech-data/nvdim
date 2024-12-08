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
        "folke/which-key.nvim",
        optional = true,
        opts = {
            spec = {
                { "<leader>a", group = "ai" },
            },
        },
    },
}
