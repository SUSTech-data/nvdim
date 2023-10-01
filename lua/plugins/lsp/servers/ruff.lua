local ignored_codes = {
    "E402",
    "E501",
    "W291",
    "PLR0913",
    "W293",
    "S101",
    "RET504",
    "RET505",
    "C901",
    "TRY003",
    "F401",
    "E401",
    "F403",
    "F405",
    "F841",
    "F811",
    "I001",
    "E741",
}

return {
    init_options = {
        settings = {
            args = {
                "--extend-select",
                "I",
                "--ignore",
                table.concat(ignored_codes, ","),
            },
        },
    },
}
