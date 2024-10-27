return {
    {
        "azratul/live-share.nvim",
        cmd = { "LiveShareServer", "LiveShareJoin" },
        dependencies = {
            "jbyuki/instant.nvim",
        },
        config = function()
            vim.g.instant_userame = "anonymous"
            require("live-share").setup({
                port_internal = 9876,
                max_attempts = 20, -- 10 seconds
                service = "serveo.net",
            })
        end,
    },
}
