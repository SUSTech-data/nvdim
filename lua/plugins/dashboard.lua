return {
    -- { "goolord/alpha-nvim", enabled = false },
    {
        "folke/snacks.nvim",
        dependencies = { { "wolfwfr/vimatrix.nvim" } },
        opts = {
            dashboard = {
                width = 70,
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
                            action = ":lua Snacks.picker.recent()",
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
                            desc = "GHdash",
                            -- action = ":lua Snacks.dashboard.pick('live_grep')",
                            action = ":GHdashToggle",
                        },
                        {
                            icon = " ",
                            key = "s",
                            desc = "Restore Session",
                            action = ":lua require('persisted').load()",
                        },
                        { icon = " ", key = "q", desc = "Quit", action = ":qa" },
                    },
                },
                sections = {
                    -- {
                    --     section = "terminal",
                    --     cmd = "cmatrix",
                    --     enabled = vim.env.TERM ~= "linux",
                    --     height = 5,
                    --     pane = 2,
                    --     padding = 3,
                    -- },

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
                        -- pane = 2,
                        icon = " ",
                        title = "Recent Files",
                        section = "recent_files",
                        indent = 2,
                        padding = 1,
                        action = function(path) vim.cmd(":e " .. path) end,
                    },
                    {
                        -- pane = 2,
                        icon = " ",
                        title = "Projects",
                        section = "projects",
                        indent = 2,
                        padding = 1,
                        action = function(path)
                            -- if vim.env.SSH_TTY ~= nil then
                            vim.cmd(":cd " .. path)
                            return require("persisted").load()
                            -- end
                            -- vim.fn.system({
                            --     "kitty",
                            --     "@",
                            --     "action",
                            --     "combine",
                            --     ":",
                            --     "close_window",
                            --     -- "signal_child",
                            --     -- "SIGKILL",
                            --     ":",
                            --     "launch",
                            --     "--cwd=" .. string.gsub(path, " ", "\\ "),
                            --     "zsh",
                            --     "-c",
                            --     '"direnv exec . nvim +SessionLoad; zsh -l"',
                            -- })
                        end,
                    },
                    -- {
                    --     pane = 2,
                    --     icon = " ",
                    --     title = "Git Status",
                    --     section = "terminal",
                    --     enabled = vim.fn.isdirectory(".git") == 1,
                    --     cmd = "hub status --short --branch --renames",
                    --     height = 5,
                    --     padding = 1,
                    --     ttl = 0,
                    --     indent = 3,
                    -- },
                    { section = "startup" },
                },
            },
        },
        init = function()
            ---@class snacks.dashboard
            local M = require("snacks.dashboard")
            local _orig_open = M.open
            ---@param opts? snacks.dashboard.Opts
            ---@diagnostic disable-next-line: duplicate-set-field
            function M.open(opts)
                local self = _orig_open(opts)
                M.instance = self
                return self
            end
        end,
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
    {
        "wolfwfr/vimatrix.nvim",
        opts = {
            auto_activation = {
                screensaver = {
                    setup_deferral = 0,
                    timeout = 0,
                    ignore_focus = false,
                    block_on_term = true,
                    block_on_cmd_line = true,
                },
                on_filetype = { "snacks_dashboard" },
            },
            droplet = {
                max_size_offset = 5,
                timings = {
                    max_fps = 180,
                    fps_variance = 20,
                    glitch_fps_divider = 8,
                    max_timeout = 200,
                    local_glitch_frame_sharing = false,
                    global_glitch_frame_sharing = true,
                },
                random = {
                    body_to_tail = 50,
                    head_to_glitch = 5,
                    head_to_tail = 50,
                    kill_head = 150,
                    new_head = 30,
                },
            },
            keys = { cancellation = {} },
            window = {
                general = {
                    background = "#000000",
                    blend = 0,
                },
                by_filetype = {
                    snacks_dashboard = {
                        background = "",
                        blend = 100,
                        -- a crude example but it works
                        ignore_cells = function(_, ln, cl)
                            -- print(vim.inspect(Snacks.dashboard.instance))
                            -- -- local width = (vim.api.nvim_win_get_width(0))
                            local db_height = #Snacks.dashboard.instance.lines
                            local size = Snacks.dashboard.instance:size()
                            local db_width = require("snacks").config.dashboard.width
                            return (
                                cl > (size.width - db_width) / 2
                                and cl < (size.width + db_width) / 2
                            )
                                and (ln > (size.height - db_height) / 2 + 5)
                                and ln < (size.height + db_height) / 2 - 5
                        end,
                    },
                },
            },
        },
    },
    {
        "nvzone/floaterm",
        dependencies = "nvzone/volt",
        opts = {
            terminals = {
                { name = "Terminal" },
                -- { name = "lazygit", cmd = "sleep 1 && lazygit" },
            },
            size = { h = 90, w = 100 },
            mappings = {
                term = function(buf)
                    vim.keymap.set(
                        { "t", "n" },
                        "<A-h>",
                        function() require("floaterm.api").switch_wins() end,
                        { buffer = buf }
                    )
                    vim.keymap.set(
                        { "n", "t" },
                        "<A-k>",
                        function() require("floaterm.api").cycle_term_bufs("prev") end,
                        { buffer = buf }
                    )
                    vim.keymap.set(
                        { "n", "t" },
                        "<A-j>",
                        function() require("floaterm.api").cycle_term_bufs("next") end,
                        { buffer = buf }
                    )
                    vim.keymap.set({ "t" }, "<esc>", [[<c-\><c-n>]], { buffer = buf })
                end,
            },
        },
        cmd = "FloatermToggle",
        keys = {
            { "<leader>ft", "<cmd>FloatermToggle<cr>", desc = "Terminal (cwd)" },
            { "<C-/>", "<cmd>FloatermToggle<cr>", mode = { "n", "t" }, desc = "Terminal (cwd)" },
        },
    },
}
