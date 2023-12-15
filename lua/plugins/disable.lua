local disables = {
    -- "folke/noice.nvim",
    -- "nvim-pack/nvim-spectre",
    "nvim-neo-tree/neo-tree.nvim",
    -- "folke/flash.nvim",
    -- "folke/trouble.nvim",
    "SmiteshP/nvim-navic",
    -- "folke/tokyonight.nvim",
    "echasnovski/mini.comment",
    "linux-cultist/venv-selector.nvim",
    "echasnovski/mini.surround",
    "rafamadriz/friendly-snippets",
    -- "echasnovski/mini.indentscope",
    -- "echasnovski/mini.bufremove",
    "lewis6991/gitsigns.nvim",
    "nvim-treesitter/nvim-treesitter-context",
    "lukas-reineke/indent-blankline.nvim",
}
local enables = { "IllustratedMan-code/telescope-conda.nvim" }
local L = {}
for _, key in ipairs(disables) do
    L[#L + 1] = { key, enabled = false }
end

vim.list_extend(L, enables)

return L
