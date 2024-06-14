return {
    "numToStr/Comment.nvim",
    -- event = { "CursorHold", "CursorHoldI" },
    opts = {
        -- ignore = function()
        --     -- Only ignore empty lines for lua files
        --     if vim.bo.filetype == "python" then return "^(%s*)# %%" end
        -- end,
        -- pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
    },
    config = function(_, opts)
        require("Comment").setup(opts)
        local ft = require("Comment.ft")
        ft.javascript = { "//%s", "/*%s*/" }
        ft.yaml = "#%s"
        ft({ "go", "rust" }, ft.get("c"))
        ft({ "toml", "graphql" }, "#%s")
        ft({ "rmd", "lean3", "quarto", "qmd" }, "-- %s")
    end,
}
