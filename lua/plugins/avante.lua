return {
    {
        "yetone/avante.nvim",
        init = function() require("avante_lib").load() end,
        event = "VeryLazy",
        -- we want to use head for now, since the releases are not frequent
        version = false,
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
