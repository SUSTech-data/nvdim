return {
    {
        "vyfor/cord.nvim",
        build = "./build || .\\build",
        event = "User IceLoad",
        opts = { log_level = "trace" }, -- calls require('cord').setup()
    },
}
