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
                inlayHints = {
                    variableTypes = true,
                    functionReturnTypes = true,
                    callArgumentNames = "partial",
                    pytestParameters = true,
                },
            },
        },
    },
}
