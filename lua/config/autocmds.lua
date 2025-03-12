-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Plain terminal
-- vim.api.nvim_create_autocmd("TermOpen", {
--   pattern = "term://*",
--   command = [[setlocal listchars= nonumber norelativenumber | startinsert]],
-- })

-- vim.api.nvim_create_autocmd("TermClose", {
--   callback = function()
--     if vim.v.event.status == 0 then
--       if vim.bo.filetype ~= "floaterm" then vim.api.nvim_buf_delete(0, {}) end
--       -- vim.cmd("ToggleTerm")
--     end
--   end,
-- })

-- show cursor line only in active window, i.e reticle.nvim
vim.api.nvim_create_autocmd({ "InsertLeave", "WinEnter" }, {
    callback = function()
        local ok, cl = pcall(vim.api.nvim_win_get_var, 0, "auto-cursorline")
        if ok and cl then
            vim.wo.cursorline = true
            vim.api.nvim_win_del_var(0, "auto-cursorline")
        end
    end,
})
vim.api.nvim_create_autocmd({ "InsertEnter", "WinLeave" }, {
    callback = function()
        local cl = vim.wo.cursorline
        if cl then
            vim.api.nvim_win_set_var(0, "auto-cursorline", cl)
            vim.wo.cursorline = false
        end
    end,
})

vim.filetype.add({
    extension = {
        conf = "conf",
        -- env = "dotenv",
        tiltfile = "tiltfile",
        Tiltfile = "tiltfile",
    },
    filename = {
        -- [".env"] = "dotenv",
        ["tsconfig.json"] = "jsonc",
        [".yamlfmt"] = "yaml",
        [".rsync_exclude"] = "gitignore",
        ["JUSTFILE"] = "just",
        [".condarc"] = "yaml",
        ["pixi.lock"] = "yaml",
        [".eslintrc.json"] = "jsonc",
    },
    pattern = {
        ["tsconfig*.json"] = "jsonc",
        [".*/%.vscode/.*%.json"] = "jsonc",
        [".*/vscode/.*%.json"] = "jsonc",
        [".*/.config/Code/User/.*%.json"] = "jsonc",
    },
    -- pattern = {
    --     ["%.env%.[%w_.-]+"] = "dotenv",
    -- },
})
