if not vim.g.vscode then
    return {
        {
            "fecet/vicode",
            build = "pixi run pnpm run package && code-insiders --install-extension vicode.vsix",
            cmd = { "ShareEditStart", "VicodeStart" },
            keys = {
                { "<leader>ov", ":VicodeStart<CR>" },
                {
                    "<leader>aa",

                    function() require("vicode").call("vscode-augment.focusAugmentPanel") end,
                    mode = { "n", "v", "o" },
                },
                {
                    "<C-CR>",
                    function() require("vicode").call("jupyter.runcurrentcell") end,
                    mode = { "n", "v", "o" },
                },
            },
            dependencies = {
                { "vim-denops/denops.vim", setup = true },
            },
        },
    }
end

local g, o, opt = vim.g, vim.o, vim.opt
o.cmdheight = 10
local map = LazyVim.safe_keymap_set
local vscodes = {
    "nvim-treesitter/nvim-treesitter",
    "sustech-data/wildfire.nvim",
    "nvim-treesitter/nvim-treesitter",
    "mizlan/iswap.nvim",
    "JoosepAlviste/nvim-ts-context-commentstring",
    "folke/flash.nvim",
    "mfussenegger/nvim-treehopper",
    "mizlan/iswap.nvim",
    "JoosepAlviste/nvim-ts-context-commentstring",
    "smoka7/hop.nvim",
    "keaising/im-select.nvim",
}
local L = {}
for _, key in ipairs(vscodes) do
    L[#L + 1] = { key, vscode = true }
end
vim.api.nvim_create_autocmd("User", {
    pattern = "LazyVimKeymapsDefaults",
    callback = function()
        vim.keymap.set("n", "<leader>ff", "<cmd>Find<cr>")
        vim.keymap.set(
            "n",
            "<leader>fw",
            [[<cmd>lua require('vscode').action('workbench.action.findInFiles')<cr>]]
        )
        vim.keymap.set(
            "n",
            "<leader>ss",
            [[<cmd>lua require('vscode').action('workbench.action.gotoSymbol')<cr>]]
        )

        vim.keymap.del("n", "<c-/>")
        vim.keymap.del("n", "<c-_>")
        vim.keymap.del("n", "<leader>gg")
        vim.keymap.del("n", "<leader>gG")
        vim.keymap.del("n", "<leader>ft")
        vim.keymap.del("n", "gf")
        map(
            "n",
            "<c-/>",
            function() require("vscode").action("workbench.action.terminal.toggleTerminal") end,
            { desc = "Open terminal" }
        )

        map("n", "gy", function() require("vscode").call("editor.action.goToTypeDefinition") end)
        map(
            "n",
            "gr",
            function() require("vscode").call("editor.action.referenceSearch.trigger") end
        )
        map("n", "go", function() require("vscode").call("breadcrumbs.focusAndSelect") end)
        map("n", "<leader>rn", function() require("vscode").call("editor.action.rename") end)
        map(
            { "x" },
            "<leader>fm",
            function() require("vscode").call("editor.action.formatSelection") end
        )
        map(
            { "n" },
            "<leader>fm",
            function() require("vscode").call("editor.action.formatDocument") end
        )

        -- Remap folding keys
        map(
            "n",
            "zM",
            '<Cmd>call VSCodeNotify("editor.foldAll")<CR>',
            { noremap = true, silent = true }
        )
        map(
            "n",
            "<leader>zc",
            '<Cmd>call VSCodeNotify("editor.foldAll")<CR>',
            { noremap = true, silent = true }
        )
        map(
            "n",
            "zR",
            '<Cmd>call VSCodeNotify("editor.unfoldAll")<CR>',
            { noremap = true, silent = true }
        )
        map(
            "n",
            "<leader>zo",
            '<Cmd>call VSCodeNotify("editor.unfoldAll")<CR>',
            { noremap = true, silent = true }
        )
        map(
            "n",
            "zc",
            '<Cmd>call VSCodeNotify("editor.fold")<CR>',
            { noremap = true, silent = true }
        )
        map(
            "n",
            "zC",
            '<Cmd>call VSCodeNotify("editor.foldRecursively")<CR>',
            { noremap = true, silent = true }
        )
        map(
            "n",
            "zo",
            '<Cmd>call VSCodeNotify("editor.unfold")<CR>',
            { noremap = true, silent = true }
        )
        map(
            "n",
            "zO",
            '<Cmd>call VSCodeNotify("editor.unfoldRecursively")<CR>',
            { noremap = true, silent = true }
        )
        map(
            "n",
            "za",
            '<Cmd>call VSCodeNotify("editor.toggleFold")<CR>',
            { noremap = true, silent = true }
        )
        map("n", "h", function()
            local col = vim.api.nvim_win_get_cursor(0)[2]
            local textBeforeCursor = vim.api.nvim_get_current_line():sub(1, col)
            local onIndentOrFirstNonBlank = textBeforeCursor:match("^%s*$")
            if onIndentOrFirstNonBlank then
                require("vscode").call("editor.fold")
            else
                require("vscode").call(
                    "cursorMove",
                    { args = { to = "left", by = "wrappedLine", value = 1 } }
                )
            end
        end)
        map("n", "l", function()
            local isOnFold = require("vscode").eval([[
  const editor = vscode.window.activeTextEditor;
  if (!editor) {
    return false;
  }

  const document = editor.document;
  const cursorPosition = editor.selection.active;
  const nextLine = cursorPosition.line + 1;

  // 如果当前已经在最后一行，则返回 true（没有下一行，不认为处于折叠状态）
  if (nextLine >= document.lineCount) {
    return false;
  }

  // 检查下一行是否位于任一可见区域中
  const isVisible = editor.visibleRanges.some(range => {
    return nextLine >= range.start.line && nextLine <= range.end.line;
  });

  return ! isVisible;
            ]])
            if isOnFold then
                require("vscode").call("editor.unfold")
            else
                require("vscode").call(
                    "cursorMove",
                    { args = { to = "right", by = "wrappedLine", value = 1 } }
                )
            end
        end)
    end,
})

return L
