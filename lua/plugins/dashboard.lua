local function header_hl_today()
    local wday = os.date("*t").wday
    local colors = { "Keyword", "Constant", "Number", "Type", "String", "Special", "Function" }
    return colors[wday]
end
vim.cmd("highlight link DashboardHeader " .. header_hl_today())

local function header()
    local str = "" .. " v" .. tostring(vim.version())
    return str
end

local function footer()
    local stats = require("lazy").stats()
    local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
    local str = "   " .. stats.count .. " plugins in " .. ms .. "ms"
    return vim.list_extend({ "", str, "" }, require("fortune").fortune(true))
end
local function project_action(path)
    -- return require("telescope.builtin").find_files({ cwd = path })
    vim.api.nvim_set_current_dir(path)
    return require("persisted").load()
end

local opts = {
    theme = "hyper",
    config = {
        week_header = {
            enable = true,
            concat = header(),
        },
        shortcut = {
            {
                desc = " New files",
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
            action = project_action,
        },
        mru = { limit = 8, label = "Most Recent Files" },
        footer = footer, -- footer,
    },
    hide = {
        -- tabline = false,
        statusline = false,
    },
}

return {
    { "goolord/alpha-nvim", enabled = false },
    {
        "glepnir/dashboard-nvim",
        event = "VimEnter",
        config = function() require("dashboard").setup(opts) end,
        dependencies = { { "nvim-tree/nvim-web-devicons" }, { "fecet/fortune.nvim" } },
    },
}
