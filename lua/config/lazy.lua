local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  -- bootstrap lazy.nvim
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

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
        -- { import = "lazyvim.plugins.extras.coding.copilot" },
        -- { import = "lazyvim.plugins.extras.dap" },
        -- { import = "lazyvim.plugins.extras.editor.mini-files" },
        { import = "lazyvim.plugins.extras.lang.clangd" },
        { import = "lazyvim.plugins.extras.lang.cmake" },
        -- { import = "lazyvim.plugins.extras.lang.json" },
        -- { import = "lazyvim.plugins.extras.lang.python-semshi" },
        { import = "lazyvim.plugins.extras.lang.python" },
        -- { import = "lazyvim.plugins.extras.lang.python-pylance" },
        { import = "lazyvim.plugins.extras.formatting.black" },
        -- { import = "lazyvim.plugins.extras.lang.tex" },
        { import = "lazyvim.plugins.extras.lang.rust" },
        { import = "lazyvim.plugins.extras.lang.yaml" },
        -- { import = "lazyvim.plugins.extras.ui.edgy" },
        -- { import = "lazyvim.plugins.extras.ui.mini-animate" },
        -- { import = "lazyvim.plugins.extras.util.mini-hipatterns" },
        { import = "lazyvim.plugins.extras.vscode" },
        -- { import = "lazyvim.plugins.extras.editor.wildfire" },
        -- { import = "lazyvim.plugins.extras.editor.rainbow-delimiters" },
        -- { import = "lazyvim.plugins.extras.ui.dropbar" },
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
        patterns = jit.os:find("Windows") and {} or { "sustech-data", "fecet", "jupynium", "lualine-so-fancy" },
    },
})

-- vim.api.nvim_command("colorscheme " .. "catppuccin")
