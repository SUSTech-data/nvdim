-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set
local Util = require("lazyvim.util")

-- Fold
map({ "n", "v", "o" }, "H", "^", { desc = "First character of line" })
map({ "n", "v", "o" }, "L", "$", { desc = "Last character of line" })
map({ "n", "v", "o" }, "J", "<C-d>", { desc = "Join line with smart whitespace removal" })
map({ "n", "v", "o" }, "K", "<C-u>", { desc = "Join line with smart whitespace removal" })
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

-- better up/down
map({ "n", "x" }, "j", [[v:count == 0 ? 'gj' : 'j']], { expr = true })
map({ "n", "x" }, "k", [[v:count == 0 ? 'gk' : 'k']], { expr = true })

-- buffers
map("n", "<C-S-h>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
map("n", "<C-H>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
map("n", "<C-S-l>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
map("n", "<C-L>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
map("n", "<C-left>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
map("n", "<C-right>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
map("n", "<S-left>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
map("n", "<S-right>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
map("n", "[b", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
map("n", "]b", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
map(
    "n",
    "<A-q>",
    function() require("mini.bufremove").delete(0, false) end,
    { desc = "del buffer" }
)
-- Clear search with <esc>
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- Clear search, diff update and redraw
-- taken from runtime/lua/_editor.lua
map(
    "n",
    "<leader>ur",
    "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
    { desc = "Redraw / clear hlsearch / diff update" }
)

map({ "n", "x" }, "gw", "*N", { desc = "Search word under cursor" })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map({ "n", "o", "x" }, "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map({ "n", "o", "x" }, "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

-- -- Add undo break-points
-- map("i", ",", ",<c-g>u")
-- map("i", ".", ".<c-g>u")
-- map("i", ";", ";<c-g>u")

--keywordprg
-- map("n", "<leader>K", "<cmd>norm! K<cr>", { desc = "Keywordprg" })

-- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- lazy
-- map("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })

-- new file
-- map("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })

map("n", "<leader>xl", "<cmd>lopen<cr>", { desc = "Location List" })
map("n", "<leader>xq", "<cmd>copen<cr>", { desc = "Quickfix List" })

if not Util.has("trouble.nvim") then
    map("n", "[q", vim.cmd.cprev, { desc = "Previous quickfix" })
    map("n", "]q", vim.cmd.cnext, { desc = "Next quickfix" })
end

-- stylua: ignore start

-- toggle options
map("n", "<leader>uf", require("lazyvim.util.format").toggle, { desc = "Toggle format on Save" })
map("n", "<leader>us", function() Util.toggle("spell") end, { desc = "Toggle Spelling" })
map("n", "<leader>uw", function() Util.toggle("wrap") end, { desc = "Toggle Word Wrap" })
map("n", "<leader>ul", function() Util.toggle.number() end, { desc = "Toggle Line Numbers" })
map("n", "<leader>ud", Util.toggle.diagnostics, { desc = "Toggle Diagnostics" })
local conceallevel = vim.o.conceallevel > 0 and vim.o.conceallevel or 3
map("n", "<leader>uc", function() Util.toggle("conceallevel", false, {0, conceallevel}) end, { desc = "Toggle Conceal" })
if vim.lsp.inlay_hint then
  map("n", "<leader>uh", function() vim.lsp.inlay_hint(0, nil) end, { desc = "Toggle Inlay Hints" })
end
map("n", "<leader>ut", function() vim.lsp.semantic_tokens(0, nil) end, { desc = "Toggle Inlay Hints" })
-- lazygit
map("n", "<leader>gg", function() Util.terminal.open({ "lazygit" }, { cwd = Util.root.get(), esc_esc = false, ctrl_hjkl = false }) end, { desc = "Lazygit (root dir)" })
-- map("n", "<leader>gG", function() Util.float_term({ "lazygit" }, {esc_esc = false, ctrl_hjkl = false}) end, { desc = "Lazygit (cwd)" })

-- quit
map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit all" })

-- highlights under cursor
if vim.fn.has("nvim-0.9.0") == 1 then
  map("n", "<leader>ui", vim.show_pos, { desc = "Inspect Pos" })
end

-- LazyVim Changelog
-- map("n", "<leader>L", Util.changelog, {desc = "LazyVim Changelog"})

-- floating terminal
local lazyterm = function() Util.terminal.open(nil, { cwd = Util.root.get() }) end
map("n", "<leader>ft", lazyterm, { desc = "Terminal (root dir)" })
map("n", "<leader>fT", function() Util.terminal.open() end, { desc = "Terminal (cwd)" })
map("n", "<c-/>", lazyterm, { desc = "Terminal (root dir)" })
map("n", "<c-_>", lazyterm, { desc = "which_key_ignore" })

-- Terminal Mappings
map("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Enter Normal Mode" })
map("t", "<C-/>", "<cmd>close<cr>", { desc = "Hide Terminal" })
map("t", "<c-_>", "<cmd>close<cr>", { desc = "which_key_ignore" })


-- tabs
map("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last Tab" })
map("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First Tab" })
map("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
map("n", "<leader><tab>]", "<cmd>tabnext<cr>", { desc = "Next Tab" })
map("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })
map("n", "<leader><tab>[", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })
-- Add empty lines before and after cursor line
-- map(
--     "n",
--     "O",
--     "<Cmd>call append(line('.') - 1, repeat([''], v:count1))<CR>",
--     { desc = "Put empty line above" }
-- )
-- map(
--     "n",
--     "o",
--     "<Cmd>call append(line('.'),     repeat([''], v:count1))<CR>",
--     { desc = "Put empty line below" }
-- )

-- Copy/paste with system clipboard
map({ "x" }, "y", 'mmy`m', { desc = "no move yank" })
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
