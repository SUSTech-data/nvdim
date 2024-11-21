local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  -- bootstrap lazy.nvim
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)
vim.keymap.set(
    { "n", "v", "o" },
    "K",
    "<C-u>",
    { desc = "Join line with smart whitespace removal" }
)
vim.api.nvim_create_autocmd("User", {
    pattern = "VeryLazy",
    callback = function()
        local function _trigger()
            vim.o.wrap = true
            vim.api.nvim_exec_autocmds("User", { pattern = "IceLoad" })
        end
        if vim.tbl_contains({ "dashboard", "snacks_dashboard" }, vim.bo.filetype) then
            vim.api.nvim_create_autocmd("BufRead", { once = true, callback = _trigger })
        else
            _trigger()
        end
    end,
})

-- vim.api.nvim_create_autocmd({ "UIEnter", "ColorScheme" }, {
--     callback = function()
--         local normal = vim.api.nvim_get_hl(0, { name = "Normal" })
--         if not normal.bg then return end
--         io.write(string.format("\027]11;#%06x\027\\", normal.bg))
--     end,
-- })
--
-- vim.api.nvim_create_autocmd("UILeave", {
--     callback = function() io.write("\027]111\027\\") end,
-- })
require("lazy").setup({
    -- pin = true,
    local_spec = true,
    spec = {
        {
            "LazyVim/LazyVim",
            import = "lazyvim.plugins",
            opts = {
                -- defaults = {
                --     keymaps = false,
                -- },
            },
        },
        { import = "plugins" },
    },
    defaults = {
        lazy = true, -- every plugin is lazy-loaded by default
        version = false, -- always use the latest git commit
        -- version = "*", -- try installing the latest stable version for plugins that support semver
    },
    checker = { enabled = false, frequency = 3600 * 6 }, -- automatically check for plugin updates
    change_detection = { enabled = true, notify = false },
    rocks = {
        hererocks = true,
    },
    performance = {
        rtp = {
            disabled_plugins = {
                "gzip",
                "matchit",
                "matchparen",
                "netrwPlugin",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
            },
        },
    },
    dev = {
        path = "~/codes/nvim-plugins",
        fallback = true,
        patterns = jit.os:find("Windows") and {} or {
            "sustech-data",
            "fecet",
            "jupynium",
            "lualine-so-fancy",
            "zotcite",
            "catppuccin",
            "neopyter",
        },
    },
})

-- vim.api.nvim_command("colorscheme " .. "catppuccin")
