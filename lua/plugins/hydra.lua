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
            name = "Buffers",
            body = "<leader>h",
            -- hint = [[
            --        ^<-^  ^-> ^
            -- Cycle  ^_h_^ ^_l_^
            -- Move   ^_H_^ ^_L_^
            -- ]],
            config = {
                -- hint = { type = "window", border = "single" },
                invoke_on_body = true,
                on_key = function()
                    -- Preserve animation
                    vim.wait(200, function() vim.cmd("redraw") end, 30, false)
                end,
            },
            heads = {
                {
                    "h",
                    "<cmd>BufferLineCyclePrev<Cr>",
                    { desc = "choose left", on_key = false },
                },
                {
                    "l",
                    "<cmd>BufferLineCycleNext<Cr>",
                    { desc = "choose right", on_key = false },
                },
                {
                    "H",
                    "<cmd>BufferLineMovePrev<Cr>",
                    { desc = "move left" },
                },
                {
                    "L",
                    "<cmd>BufferLineMoveNext<Cr>",
                    { desc = "move right" },
                },
                { "p", "<cmd>BufferLinePick<Cr>", { desc = "Pick" } },
                { "P", "<Cmd>BufferLineTogglePin<Cr>", { desc = "pin" } },
                {
                    "b",
                    "<Cmd>Telescope buffers<CR>",
                    { desc = "fuzzy pick " },
                },
                {
                    "d",
                    function() require("mini.bufremove").delete(0, false) end,
                    { desc = "close" },
                },
                { "q", function() require("mini.bufremove").unshow(0) end, { desc = "unshow" } },
                {
                    "c",
                    "<Cmd>BufferLinePickClose<CR>",
                    { desc = "Pick close" },
                },
                {
                    "sd",
                    "<Cmd>BufferLineSortByDirectory<CR>",
                    { desc = "by directory" },
                },
                {
                    "se",
                    "<Cmd>BufferLineSortByExtension<CR>",
                    { desc = "by extension" },
                },
                { "st", "<Cmd>BufferLineSortByTabs<CR>", { desc = "by tab" } },
                { "<Esc>", nil, { exit = true } },
            },
        })
        Hydra({
            name = "Windows",
            hint = [[
  ^^^^^^^^^^^^     Move      ^^    Size   ^^   ^^     Split
  ^^^^^^^^^^^^-------------  ^^-----------^^   ^^---------------
  ^ ^ _k_ ^ ^  ^ ^ _K_ ^ ^   ^   _<Up>_   ^   _s_: horizontally
  _h_ ^ ^ _l_  _H_ ^ ^ _L_   _<Left>_ _<Right>_   _v_: vertically
  ^ ^ _j_ ^ ^  ^ ^ _J_ ^ ^   ^   _<Down>_   ^   _q_, _c_: close
  focus^^^^^^  window^^^^^^  ^_=_: equalize^   _z_: maximize
  ^ ^ ^ ^ ^ ^  ^ ^ ^ ^ ^ ^   ^^ ^          ^   _o_: remain only
  _<Space>_: pick buffer
           ]],
            config = {
                -- on_key = function() vim.wait(1) end,
                invoke_on_body = true,
                -- hint = {
                --     border = "rounded",
                --     offset = -1,
                -- },
                timeout = 500,
            },
            mode = "n",
            body = "<C-w>",
            heads = {
                { "h", function() require("smart-splits").move_cursor_left() end },
                { "j", function() require("smart-splits").move_cursor_down() end },
                { "k", function() require("smart-splits").move_cursor_up() end },
                { "l", function() require("smart-splits").move_cursor_left() end },

                { "H", "<Cmd>WinShift left<CR>" },
                { "J", "<Cmd>WinShift down<CR>" },
                { "K", "<Cmd>WinShift up<CR>" },
                { "L", "<Cmd>WinShift right<CR>" },

                { "<Left>", "<CMD>SmartResizeLeft<CR>" },
                { "<Down>", "<CMD>SmartResizeDown<CR>" },
                { "<Up>", "<CMD>SmartResizeUp<CR>" },
                { "<Right>", "<CMD>SmartResizeRight<CR>" },
                { "=", "<C-w>=", { desc = "equalize" } },
                { "s", "<C-w>s" },
                { "<C-s>", "<C-w><C-s>", { desc = false } },
                { "v", "<C-w>v" },
                { "<C-v>", "<C-w><C-v>", { desc = false } },
                { "w", "<C-w>w", { exit = true, desc = false } },
                { "<C-w>", "<C-w>w", { exit = true, desc = false } },
                { "z", "<Cmd>ZenMode<CR>", { exit = true, desc = "Zen mode" } },
                { "o", "<C-w>o", { exit = true, desc = "remain only" } },
                -- { "<C-o>", "<C-w>o", { exit = true, desc = false } },
                -- { "}", "<C-w>}", { exit = true, desc = false } },
                {
                    "<Space>",
                    "<CMD>BufferLinePick<CR>",
                    {
                        exit = true,
                        desc = "choose buffer",
                    },
                },

                { "c", pcmd("close", "E444") },
                { "q", pcmd("close", "E444"), { desc = "close window" } },
                { "<C-c>", pcmd("close", "E444"), { desc = false } },
                { "<C-q>", pcmd("close", "E444"), { desc = false } },
                {
                    "<Esc>",
                    nil,
                    { exit = true, desc = false },
                },
            },
        })

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
