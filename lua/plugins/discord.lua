return {
    {
        "vyfor/cord.nvim",
        build = ":Cord update",
        event = "User IceLoad",
        -- opts = { log_level = "trace" }, -- calls require('cord').setup()
    },
}
