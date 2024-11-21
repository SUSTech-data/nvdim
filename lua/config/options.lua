-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local g, o, opt = vim.g, vim.o, vim.opt

g.autoformat = false
g.mapleader = " "
g.maplocalleader = " "
o.title = true
o.swapfile = false

o.showbreak = "↳ " -- character show in front of wrapped lines
-- o.breakindentopt = "shift:-2" -- dedent showbreak
o.linebreak = true -- Wrap long lines at 'breakat' (if 'wrap' is set)

o.formatoptions = "jcqlnt" -- tcqj
-- o.whichwrap = "h,l,<,>,[,],~"
o.numberwidth = 3
o.cursorline = true
o.updatetime = 500

o.incsearch = true -- Show search results while typing
o.infercase = true -- Infer letter cases for a richer built-in keyword completion

o.virtualedit = "block,onemore" -- Allow going past the end of line in visual block mode

opt.sessionoptions =
    { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }
g.python3_host_prog = "python3"
g.python_host_prog = "python"
g.ai_cmp = false
-- g.lazyvim_python_lsp = "basedpyright"
