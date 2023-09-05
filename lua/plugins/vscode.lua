local vscodes = {
    "nvim-treesitter/nvim-treesitter",
    "sustech-data/wildfire.nvim",
    "nvim-treesitter/nvim-treesitter",
    "mizlan/iswap.nvim",
    "JoosepAlviste/nvim-ts-context-commentstring",
    "folke/flash.nvim",
    "mfussenegger/nvim-treehopper",
    "sustech-data/wildfire.nvim",
    "mizlan/iswap.nvim",
    "JoosepAlviste/nvim-ts-context-commentstring",
    "numToStr/Comment.nvim",
    "kiyoon/jupynium.nvim",
    -- "catppuccin/nvim",
}
local L = {}
for _, key in ipairs(vscodes) do
    L[#L + 1] = { key, vscode = true }
end

-- vim.list_extend(L, enables)

return L

