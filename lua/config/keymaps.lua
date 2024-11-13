-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set
local Util = require("lazyvim.util")

-- Fold
map({ "n", "v", "o" }, "H", "^", { desc = "First character of line" })
map({ "n", "o" }, "L", "$", { desc = "Last character of line" })
map({ "v" }, "L", "$h", { desc = "Last character of line" })
map({ "n", "v", "o" }, "J", "6j", { desc = "Join line with smart whitespace removal" })
map({ "n", "v", "o" }, "K", "6k", { desc = "Join line with smart whitespace removal" })
map("n", "Q", "<cmd>q<cr>", { desc = "quit" })
map({ "v" }, "C", "J", { desc = "Join line with smart whitespace removal" })

-- Don't yank empty line to clipboard
map("n", "dd", function()
    local is_empty_line = vim.api.nvim_get_current_line():match("^%s*$")
    if is_empty_line then
        return '"_dd'
    else
        return "dd"
    end
end, { noremap = true, expr = true })

-- buffers
map("n", "<C-S-h>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
map("n", "<C-H>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
map("n", "<C-S-l>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
map("n", "<C-L>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
map("n", "<C-left>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
map("n", "<C-right>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
map("n", "<S-left>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
map("n", "<S-right>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
map("n", "<A-q>", "<cmd>BufDel<cr>", { desc = "Delete Buffer" })

vim.keymap.del("n", "gco")
vim.keymap.del("n", "gcO")
vim.keymap.del({ "n", "v" }, "<leader>cf")

if not Util.has("trouble.nvim") then
    map("n", "[q", vim.cmd.cprev, { desc = "Previous quickfix" })
    map("n", "]q", vim.cmd.cnext, { desc = "Next quickfix" })
end

-- Copy/paste with system clipboard
map({ "x" }, "y", "mmy`m", { desc = "no move yank" })
map({ "n", "x" }, "gy", '"+y', { desc = "Copy to system clipboard" })
map("n", "gY", '"+y$', { desc = "Copy to system clipboard" })
map("n", "gp", '"+p', { desc = "Paste from system clipboard" })
-- Paste in Visual with `P` to not copy selected text (`:h v_P`)
map("x", "gp", '"+P', { desc = "Paste from system clipboard" })

-- gv: Reselect visual selection by default
-- Reselect latest changed, put, or yanked text
map(
    "n",
    "gV",
    '"`[" . strpart(getregtype(), 0, 1) . "`]"',
    { expr = true, desc = "Visually select changed text" }
)

-- Search inside visually highlighted text. Use `silent = false` for it to
-- make effect immediately.
map("x", "g/", "<esc>/\\%V", { silent = false, desc = "Search inside visual selection" })

vim.api.nvim_set_keymap("i", "<C-q>", "<ESC><CR>s)i", { noremap = false, silent = true })
-- vim.keymap.set("n", "<C-V>", '"+P') -- Paste normal mode
-- vim.keymap.set("v", "<C-V>", '"+P') -- Paste visual mode
-- vim.keymap.set("c", "<C-V>", "<C-R>+") -- Paste command mode
-- vim.keymap.set("i", "<C-V>", '<ESC>l"+Pli') -- Paste insert mode
vim.keymap.set("n", "<C-S-v>", '"+P') -- Paste normal mode
vim.keymap.set("v", "<C-S-v>", '"+P') -- Paste visual mode
vim.keymap.set("c", "<C-S-v>", "<C-R>+") -- Paste command mode
vim.keymap.set("i", "<C-S-v>", '<ESC>l"+Pli') -- Paste insert mode
vim.keymap.set("n", "<S-C-v>", '"+P') -- Paste normal mode
vim.keymap.set("v", "<S-C-v>", '"+P') -- Paste visual mode
vim.keymap.set("c", "<S-C-v>", "<C-R>+") -- Paste command mode
vim.keymap.set("i", "<S-C-v>", '<ESC>l"+Pli') -- Paste insert mode
vim.keymap.set(
    { "n", "x", "o", "i" },
    "<C-=>",
    function() vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.01 end
)
vim.keymap.set(
    { "n", "x", "o", "i" },
    "<C-->",
    function() vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.01 end
)

-- Allow clipboard copy paste in neovim
vim.api.nvim_set_keymap("", "<C-S-v>", "+p<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("!", "<C-S-v>", "<C-R>+", { noremap = true, silent = true })
vim.api.nvim_set_keymap("t", "<C-S-v>", "<C-R>+", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<C-S-v>", "<C-R>+", { noremap = true, silent = true })

vim.api.nvim_set_keymap("x", "/", "<Esc>/\\%V", { noremap = true, silent = true })

map("n", "<C-i>", "<C-i>")
