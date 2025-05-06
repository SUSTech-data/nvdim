if not vim.g.neovide then return {} end

-- local font = "Iosevka Nerd Font"
-- local font = "VictorMono Nerd Font"
-- local font = "JetBrainsMono Nerd Font"
-- local font = "Comic mono"
-- local font = "MonaspiceXe NFM"
-- local fontsize = tonumber(os.getenv("GDK_SCALE") or 1)
--     * tonumber(os.getenv("GDK_DPI_SCALE") or 1)
--     * 20
-- vim.api.nvim_set_option_value("guifont", font .. ":h" .. fontsize, {})
vim.g.neovide_refresh_rate = 1000
vim.g.neovide_cursor_vfx_mode = "railgun"
vim.g.neovide_profiler = true
vim.g.neovide_window_blurred = true
vim.g.neovide_opacity = 1
vim.g.neovide_scroll_animation_far_lines = 1
vim.g.neovide_hide_mouse_when_typing = true
vim.g.neovide_underline_stroke_scale = 1.0
vim.g.neovide_theme = "auto"
vim.g.neovide_confirm_quit = false


vim.api.nvim_create_autocmd("User", {
    pattern = "LazyVimKeymaps",
    callback = function()
        -- vim.keymap.set("n", "<C-V>", '"+P') -- Paste normal mode
        -- vim.keymap.set("v", "<C-V>", '"+P') -- Paste visual mode
        -- vim.keymap.set("c", "<C-V>", "<C-R>+") -- Paste command mode
        -- vim.keymap.set("i", "<C-V>", '<ESC>l"+Pli') -- Paste insert mode
        -- vim.keymap.set({ "n", "v", "x", "s", "o", "i", "l", "t", "c" }, "<C-j>", "<Down>") -- Paste normal mode
        -- vim.keymap.set({ "n", "v", "x", "s", "o", "i", "l", "t", "c" }, "<C-k>", "<Up>") -- Paste normal mode
        -- vim.keymap.set({ "n", "v", "x", "s", "o", "i", "l", "t", "c" }, "<C-h>", "<Left>") -- Paste normal mode
        -- vim.keymap.set({ "n", "v", "x", "s", "o", "i", "l", "t", "c" }, "<C-l>", "<Right>") -- Paste normal mode
        vim.keymap.set("n", "<C-S-v>", '"+P') -- Paste normal mode
        vim.keymap.set("v", "<C-S-v>", '"+P') -- Paste visual mode
        vim.keymap.set("c", "<C-S-v>", "<C-R>+") -- Paste command mode
        vim.keymap.set("i", "<C-S-v>", '<ESC>l"+Pli') -- Paste insert mode
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
    end,
})

return {
    -- {
    --     "andweeb/presence.nvim",
    --     config = true,
    --     event = "VeryLazy",
    --     opts = {
    --         blacklist = { "*.txt", ".txt" },
    --         enable_line_number = true,
    --     },
    --     -- keys = {
    --     --     {
    --     --         "<leader>uD",
    --     --         function() require("presence"):update() end,
    --     --         desc = "Update presence",
    --     --     },
    --     -- },
    -- },
}
