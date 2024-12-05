local markdown_family = { "markdown", "rmd", "quarto", "qmd", "norg" }

return {
    {
        "quarto-dev/quarto-nvim",
        opts = {
            lspFeatures = {
                languages = { "r", "python", "julia", "bash", "html", "lua" },
            },
            keymap = { hover = "D" },
        },
        ft = "quarto",
    },

    {
        "jmbuhr/otter.nvim",
        -- enabled = false,
        opts = {
            buffers = {
                set_filetype = false,
            },
        },
    },
    {
        "jalvesaq/zotcite",
        enabled = false,
        -- ft = markdown_family,
        config = function() --[[ vim.env.ZCitationTemplate = "" ]]
        end,
    },
    {
        "jalvesaq/cmp-zotcite",
        enabled = false,
    },
}
