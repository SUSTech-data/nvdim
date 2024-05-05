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

require("lazy").setup({
    pin = true,
    spec = {
        {
            "LazyVim/LazyVim",
            import = "lazyvim.plugins",
            opts = {
                defaults = {
                    keymaps = false,
                },
            },
        },
        { import = "plugins" },
    },
    defaults = {
        lazy = true, -- every plugin is lazy-loaded by default
        version = false, -- always use the latest git commit
        -- version = "*", -- try installing the latest stable version for plugins that support semver
    },
    checker = { enabled = true, frequency = 3600 * 6 }, -- automatically check for plugin updates
    change_detection = { enabled = true, notify = false },
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
        patterns = jit.os:find("Windows") and {}
            or { "sustech-data", "fecet", "jupynium", "lualine-so-fancy", "zotcite", "catppuccin" },
    },
})

-- vim.api.nvim_command("colorscheme " .. "catppuccin")
