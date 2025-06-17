return {
    -- {
    --     "xb-bx/editable-term.nvim",
    --     config = true,
    -- },
    {
        "nvzone/floaterm",
        dependencies = "nvzone/volt",
        opts = {
            mappings = {
                term = function(buf)
                    vim.keymap.set(
                        { "t", "n" },
                        "<A-h>",
                        function() require("floaterm.api").switch_wins() end,
                        { buffer = buf }
                    )
                    vim.keymap.set(
                        { "n", "t" },
                        "<A-k>",
                        function() require("floaterm.api").cycle_term_bufs("prev") end,
                        { buffer = buf }
                    )
                    vim.keymap.set(
                        { "n", "t" },
                        "<A-j>",
                        function() require("floaterm.api").cycle_term_bufs("next") end,
                        { buffer = buf }
                    )
                    vim.keymap.set({ "t" }, "<esc>", [[<c-\><c-n>]], { buffer = buf })
                end,
            },
        },
        cmd = "FloatermToggle",
        keys = {
            { "<leader>ft", "<cmd>FloatermToggle<cr>", desc = "Terminal (cwd)" },
            { "<C-/>", "<cmd>FloatermToggle<cr>", mode = { "n", "t" }, desc = "Terminal (cwd)" },
        },
    },
}
