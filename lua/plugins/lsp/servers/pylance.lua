return {
    capabilities = {
        workspace = {
            didChangeWatchedFiles = {
                dynamicRegistration = false,
            },
        },
    },
    settings = {
        python = {
            analysis = {
                -- loglevel = "trace",
                autoSearchPaths = true,
                typeCheckingMode = "off",
                completeFunctionParens = false,
                autoImportCompletions = true,
                autoFormatStrings = false,
                indexing = true,
                packageIndexDepths = {
                    { name = "vectorbtpro", depth = 10 },
                    { name = "torch", depth = 10 },
                    { name = "pytorch", depth = 10 },
                },
                inlayHints = {
                    variableTypes = true,
                    functionReturnTypes = true,
                    callArgumentNames = true,
                    pytestParameters = true,
                },
            },
        },
    },
}
