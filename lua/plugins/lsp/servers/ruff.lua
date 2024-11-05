return {
    init_options = {
        settings = {
            format = {
                preview = true,
            },
            lint = {
                select = { "C4", "LOG", "PERF", "PLE" },
                ignore = {
                    "C408",
                    "D102",
                    "D105",
                    "D107",
                    "D203",
                    "D212",
                    "D213",
                    "D401",
                    "D404",
                    "D417",
                    "E501",
                    "E722",
                    "E741",
                    "PERF2",
                    "PERF4",
                },
            },
        },
    },
}
