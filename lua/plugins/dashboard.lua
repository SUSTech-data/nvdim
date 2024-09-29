return {
    -- { "goolord/alpha-nvim", enabled = false },
    {
        "nvimdev/dashboard-nvim",
        cond = function() return vim.env.KITTY_SCROLLBACK_NVIM == nil and vim.g.vscode == nil end,
        event = "VimEnter",
        opts = {
            theme = "hyper",
            config = {
                week_header = {
                    enable = true,
                    -- concat = header(),
                    concat = "" .. " v" .. tostring(vim.version()),
                },
                shortcut = {
                    {
                        desc = " New files",
                        -- group = "@property",
                        action = "enew",
                        key = "n",
                    },
                    {
                        desc = " Files",
                        -- group = "Label",
                        action = "Telescope oldfiles",
                        key = "f",
                    },
                    {
                        desc = " Apps",
                        group = "DiagnosticHint",
                        action = "Lazy",
                        key = "a",
                    },
                    {
                        desc = " dotfiles",
                        group = "Number",
                        action = "Telescope live_grep cwd=~/.config/nvim",
                        key = "d",
                    },
                },
                packages = { enable = false }, -- show how many plugins neovim loaded
                project = {
                    enable = true,
                    limit = 5,
                    label = "Recent Projects",
                    -- action = project_action,
                    action = function(path)
                        vim.api.nvim_set_current_dir(path)
                        return require("persisted").load()
                    end,
                },
                mru = {
                    limit = 8,
                    label = "Most Recent Files",
                    -- cwd_only = true,
                },
                footer = function()
                    local stats = require("lazy").stats()
                    local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
                    local str = " 󱫤 " .. stats.count .. " plugins in " .. ms .. "ms"
                    return vim.list_extend({ "", str, "" }, require("fortune").get_fortune())
                    -- return { "", str, "" }
                end, -- footer,
            },
            hide = {
                -- tabline = false,
                statusline = false,
            },
        },
        config = function(_, opts)
            local wday = os.date("*t").wday
            local colors =
                { "Keyword", "Constant", "Number", "Type", "String", "Special", "Function" }
            vim.cmd("highlight link DashboardHeader " .. colors[wday])
            require("dashboard").setup(opts)
        end,
        dependencies = { { "nvim-tree/nvim-web-devicons" }, { "rubiin/fortune.nvim" } },
    },
    {
        "rubiin/fortune.nvim",
        version = "*",
        config = function()
            require("fortune").setup({
                max_width = 60,
                content_type = "tips",
            })
        end,
    },
}
