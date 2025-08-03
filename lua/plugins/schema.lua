return {
    {
        "b0o/SchemaStore.nvim",
        lazy = true,
        version = false, -- last release is way too old
    },
    {
        "neovim/nvim-lspconfig",

        opts = {
            servers = {
                taplo = {
                    settings = {
                        evenBetterToml = {
                            schema = {
                                repositoryEnabled = true,
                                associations = {
                                    ["pixi.toml"] = "https://raw.githubusercontent.com/fecet/pixi/refs/heads/main/schema/schema.json", --FIXME: wait for merge
                                },
                            },
                        },
                    },
                },
            },
        },
    },
}
