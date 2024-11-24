return {
    -- { "goolord/alpha-nvim", enabled = false },
    {
        "folke/snacks.nvim",
        opts = {
            dashboard = {
                -- width = 100,
                autokeys = "etovxqpdygfblzhckisuran",
                preset = {
                    keys = {
                        {
                            icon = " ",
                            key = "n",
                            desc = "New File",
                            action = ":ene | startinsert",
                        },
                        {
                            icon = " ",
                            key = "f",
                            desc = "Recent Files",
                            action = ":lua Snacks.dashboard.pick('oldfiles')",
                        },
                        {
                            icon = " ",
                            key = "o",
                            desc = "Oil",
                            action = ":e .",
                        },
                        {
                            icon = "󰒲 ",
                            key = "a",
                            desc = "Lazy",
                            action = ":Lazy",
                            enabled = package.loaded.lazy ~= nil,
                        },
                        {
                            icon = " ",
                            key = "d",
                            desc = "Config",
                            action = ":lua Snacks.dashboard.pick('live_grep', {cwd = vim.fn.stdpath('config')})",
                        },
                        {
                            icon = " ",
                            key = "g",
                            desc = "Find Text",
                            action = ":lua Snacks.dashboard.pick('live_grep')",
                        },
                        {
                            icon = " ",
                            key = "s",
                            desc = "Restore Session",
                            action = ":Telescope persisted",
                        },
                        { icon = " ", key = "q", desc = "Quit", action = ":qa" },
                    },
                },
                sections = {
                    {
                        section = "terminal",
                        cmd = "cmatrix",
                        height = 5,
                        pane = 2,
                        padding = 3,
                    },

                    { section = "header" },
                    -- {
                    --     pane = 2,
                    --     section = "terminal",
                    --     cmd = "colorscript -e square",
                    --     height = 5,
                    --     padding = 1,
                    -- },
                    { section = "keys", padding = 4 },
                    {
                        pane = 2,
                        icon = " ",
                        title = "Recent Files",
                        section = "recent_files",
                        indent = 2,
                        padding = 1,
                        action = function(path) vim.cmd(":e " .. path) end,
                    },
                    {
                        pane = 2,
                        icon = " ",
                        title = "Projects",
                        section = "projects",
                        indent = 2,
                        padding = 1,
                        action = function(path)
                            vim.fn.system({
                                "kitty",
                                "@",
                                "action",
                                "combine",
                                ":",
                                "close_window",
                                -- "signal_child",
                                -- "SIGKILL",
                                ":",
                                "launch",
                                "--cwd=" .. path,
                                "zsh",
                                "-c",
                                -- '"cd ' .. path .. '&& nvim +SessionLoad; zsh -l"',
                                '"direnv exec . nvim +SessionLoad; zsh -l"',
                            })
                        end,
                    },
                    {
                        pane = 2,
                        icon = " ",
                        title = "Git Status",
                        section = "terminal",
                        enabled = vim.fn.isdirectory(".git") == 1,
                        cmd = "hub status --short --branch --renames",
                        height = 5,
                        padding = 1,
                        ttl = 0,
                        indent = 3,
                    },
                    { section = "startup" },
                },
            },
        },
    },
    {
        "nvimdev/dashboard-nvim",
        enabled = false,
        cond = function() return vim.env.KITTY_SCROLLBACK_NVIM == nil and vim.g.vscode == nil end,
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
                    -- local stats = require("lazy").stats()
                    -- local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
                    -- local str = " 󱫤 " .. stats.count .. " plugins in " .. ms .. "ms"
                    -- return vim.list_extend({ "", str, "" }, require("fortune").get_fortune())
                    -- return { "", str, "" }
                    --
                    local stats = require("lazy").stats()
                    local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
                    return {
                        "⚡ Neovim loaded "
                            .. stats.loaded
                            .. "/"
                            .. stats.count
                            .. " plugins in "
                            .. ms
                            .. "ms",
                    }
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
