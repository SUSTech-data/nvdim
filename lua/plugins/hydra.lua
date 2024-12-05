return {
    "nvimtools/hydra.nvim",
    event = "User IceLoad",
    config = function()
        local Hydra = require("hydra")
        -- local splits = require("smart-splits")
        --
        -- local cmd = require("hydra.keymap-util").cmd
        local pcmd = require("hydra.keymap-util").pcmd

        Hydra({
            name = "UI Options",
            hint = [[
  ^ ^        UI Options
  ^
  _v_ %{ve} virtual edit
  _i_ %{list} invisible characters
  _s_ %{spell} spell
  _w_ %{wrap} wrap
  _c_ %{cul} cursor line
  _n_ %{nu} number
  _r_ %{rnu} relative number
  ^
       ^^^^                _<Esc>_
]],
            config = {
                color = "amaranth",
                invoke_on_body = true,
                hint = {
                    -- border = "rounded",
                    position = "middle",
                },
            },
            mode = { "n", "x" },
            body = "<leader>U",
            heads = {
                { "n", function() vim.o.number = not vim.o.number end, { desc = "number" } },
                {
                    "r",
                    function() vim.o.relativenumber = not vim.o.relativenumber end,
                    { desc = "relativenumber" },
                },
                {
                    "v",
                    function()
                        if vim.o.virtualedit == "all" then
                            vim.o.virtualedit = "block"
                        else
                            vim.o.virtualedit = "all"
                        end
                    end,
                    { desc = "virtualedit" },
                },
                { "i", function() vim.o.list = not vim.o.list end, { desc = "show invisible" } },
                {
                    "s",
                    function() vim.o.spell = not vim.o.spell end,
                    { exit = true, desc = "spell" },
                },
                { "w", function() vim.o.wrap = not vim.o.wrap end, { desc = "wrap" } },
                {
                    "c",
                    function() vim.o.cursorline = not vim.o.cursorline end,
                    { desc = "cursor line" },
                },
                { "<Esc>", nil, { exit = true } },
            },
        })
    end,
}
