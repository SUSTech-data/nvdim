return {
    settings = {
        python = {
            analysis = {
                -- loglevel = "trace",
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
