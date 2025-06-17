local function get_venv(variable)
    local venv = os.getenv(variable)
    if venv ~= nil and string.find(venv, "/") then
        local orig_venv = venv
        for w in orig_venv:gmatch("([^/]+)") do
            venv = w
        end
        venv = string.format("%s", venv)
    end
    return venv
end

local function is_wide_term(width)
    width = width or 150
    return vim.o.columns > width
end

return {
    {
        "nvim-lualine/lualine.nvim",
        -- enabled = false,
        event = function(event) return "User IceLoad" end,
        dependencies = { "meuter/lualine-so-fancy.nvim" },
        opts = {
            options = {
                component_separators = "", --        
                section_separators = { left = "", right = "" },
                disabled_filetypes = {
                    "dashboard",
                    "NeoTree",
                    "Outline",
                    "TelescopePrompt",
                    "Mundo",
                    "MundoDiff",
                    "snacks_dashboard",
                },
                -- always_divide_middle = false,
            },
            sections = {
                lualine_a = {
                    {
                        "mode",
                        icon = "",
                        fmt = function(str) return str:sub(1, 1) end,
                        separator = { left = "", right = "" },
                        padding = 0,
                    },
                    { "fancy_branch", color = { gui = "italic" }, cond = is_wide_term },
                },
                lualine_b = {
                    {
                        function() return " " .. vim.fn.fnamemodify(vim.fn.getcwd(), ":t") end,
                        -- "fancy_cwd",
                        -- substitute_home = true,
                        color = { gui = "bold" },
                    },
                },
                lualine_c = {
                    { "fancy_filetype", icon_only = false, separator = "" },
                    -- {
                    --     "filename",
                    --     path = 1,
                    --     symbols = { modified = "●", readonly = "", unnamed = "" },
                    --     separator = false,
                    --     padding = 0,
                    -- },
                    {
                        "fancy_lsp_servers",
                        split = ",",
                        separator = "",
                    },
                    { function() return "%=" end, separator = "" },
                    {
                        function() require("noice").api.status.message.get_hl() end,
                        cond = function() require("noice").api.status.message.has() end,
                    },
                },
                lualine_x = {
                    {
                        function() return require("noice").api.status.command.get() end,
                        cond = function()
                            return package.loaded["noice"]
                                and require("noice").api.status.command.has()
                        end,
                        -- color = fg("Statement"),
                    },
                    { "fancy_macro" },
                    { "fancy_searchcount" },
                    {
                        function()
                            local icon = " "
                            local status = require("copilot.api").status.data
                            return icon .. (status.message or "")
                        end,
                        cond = function()
                            local ok, clients =
                                pcall(vim.lsp.get_clients, { name = "copilot", bufnr = 0 })
                            return ok and #clients > 0
                        end,
                        color = function()
                            -- local fg = Snacks.util.color

                            local colors = {
                                [""] = { fg = Snacks.util.color("Special") },
                                ["Normal"] = { fg = Snacks.util.color("Special") },
                                ["Warning"] = { fg = Snacks.util.color("DiagnosticError") },
                                ["InProgress"] = { fg = Snacks.util.color("DiagnosticWarn") },
                            }
                            if not package.loaded["copilot"] then return end
                            local status = require("copilot.api").status.data
                            return colors[status.status] or colors[""]
                        end,
                    },
                    -- {
                    --     function()
                    --         local icon = "󰙯 "
                    --         return icon
                    --     end,
                    --     color = fg("Special"),
                    --     cond = function()
                    --         local ok, presence = pcall(require, "cord")
                    --         return ok and presence.is_connected()
                    --     end,
                    -- },
                    -- {
                    --     function()
                    --         local icon = require("lazyvim.config").icons.kinds.Copilot
                    --         local status = require("copilot.api").status.data
                    --         return icon .. (status.message or "")
                    --     end,
                    --     cond = function()
                    --         local ok, clients =
                    --             pcall(vim.lsp.get_clients, { name = "copilot", bufnr = 0 })
                    --         return ok and #clients > 0
                    --     end,
                    -- },
                    {
                        require("lazy.status").updates,
                        cond = require("lazy.status").has_updates,
                        color = function() return { fg = Snacks.util.color("Special") } end,
                    },
                },
                lualine_y = {
                    {
                        function()
                            return " " .. vim.api.nvim_get_option_value("tabstop", { buf = 0 })
                        end,
                        cond = is_wide_term,
                    },
                    { -- python env
                        function()
                            local venv = get_venv("CONDA_DEFAULT_ENV")
                                or get_venv("VIRTUAL_ENV")
                                or "System"
                            return "🐍 " .. venv
                        end,
                        -- cond = function() return vim.bo.filetype == "python" end,
                    },
                    -- { --window
                    --   function() return " " .. vim.api.nvim_win_get_number(0) end,
                    --   cond = function() return true end,
                    -- },
                    { --terminal
                        function() return " " .. vim.o.channel end,
                        cond = function() return vim.o.buftype == "terminal" end,
                    },
                },
                lualine_z = {
                    { "hostname", icon = "", padding = 1, separator = false },
                    { "progress", separator = " · " },
                    {
                        "location",
                        padding = { left = 0, right = 1 },
                        separator = { right = "" },
                    },
                },
            },
            extensions = { "neo-tree", "lazy", "quickfix", "nvim-tree" },
        },
    },
    {
        "b0o/incline.nvim",
        -- enabled=false,
        -- branch = "main",
        event = "BufReadPost",
        opts = {
            highlight = {
                groups = {
                    InclineNormal = "CursorLine",
                    InclineNormalNC = "CursorLine",
                },
            },
            window = { zindex = 40, margin = { horizontal = 0, vertical = 0 } },
            hide = { cursorline = true },
            -- ignore = { buftypes = function(bufnr, buftype) return false end },
            render = function(props)
                if vim.bo[props.buf].buftype == "terminal" then
                    return {
                        { " " .. vim.bo[props.buf].channel .. " ", group = "DevIconTerminal" },
                        { " " .. vim.api.nvim_win_get_number(props.win), group = "Special" },
                    }
                end

                local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
                local ft_icon, ft_color = require("nvim-web-devicons").get_icon_color(filename)
                local modified = vim.api.nvim_get_option_value("modified", { buf = 0 })
                        and "bold,italic"
                    or "bold"

                local function get_git_diff()
                    local icons = require("lazyvim.config").icons.git
                    icons["changed"] = icons.modified
                    local signs = vim.b[props.buf].gitsigns_status_dict
                    local labels = {}
                    if signs == nil then return labels end
                    for name, icon in pairs(icons) do
                        if tonumber(signs[name]) and signs[name] > 0 then
                            table.insert(
                                labels,
                                { icon .. signs[name] .. " ", group = "Diff" .. name }
                            )
                        end
                    end
                    if #labels > 0 then table.insert(labels, { "┊ " }) end
                    return labels
                end
                local function get_diagnostic_label()
                    local icons = require("lazyvim.config").icons.diagnostics
                    local label = {}

                    for severity, icon in pairs(icons) do
                        local n = #vim.diagnostic.get(
                            props.buf,
                            { severity = vim.diagnostic.severity[string.upper(severity)] }
                        )
                        if n > 0 then
                            table.insert(
                                label,
                                { icon .. n .. " ", group = "DiagnosticSign" .. severity }
                            )
                        end
                    end
                    if #label > 0 then table.insert(label, { "┊ " }) end
                    return label
                end

                local ft_icon = ft_icon == nil and "" or ft_icon

                local buffer = {
                    { get_diagnostic_label() },
                    { get_git_diff() },
                    { ft_icon .. " ", guifg = ft_color, guibg = "none" },
                    { filename .. " ", gui = modified },
                    { " " .. vim.api.nvim_win_get_number(props.win), group = "Special" },
                }
                return buffer
            end,
        },
    },
    {
        "nvim-lualine/lualine.nvim",
        opts = function(_, opts)
            ---@type table<string, {updated:number, total:number, enabled: boolean, status:string[]}>
            local mutagen = {}

            local function mutagen_status()
                local cwd = vim.uv.cwd() or "."
                mutagen[cwd] = mutagen[cwd]
                    or {
                        updated = 0,
                        total = 0,
                        enabled = vim.fs.find("mutagen.yml", { path = cwd, upward = true })[1]
                            ~= nil,
                        status = {},
                    }
                local now = vim.uv.now() -- timestamp in milliseconds
                local refresh = mutagen[cwd].updated + 2000 < now
                if #mutagen[cwd].status > 0 then refresh = mutagen[cwd].updated + 1000 < now end
                if mutagen[cwd].enabled and refresh then
                    ---@type {name:string, status:string, idle:boolean}[]
                    local sessions = {}
                    local lines = vim.fn.systemlist("mutagen project list")
                    local status = {}
                    local name = nil
                    for _, line in ipairs(lines) do
                        local n = line:match("^Name: (.*)")
                        if n then name = n end
                        local s = line:match("^Status: (.*)")
                        if s then
                            table.insert(sessions, {
                                name = name,
                                status = s,
                                idle = s == "Watching for changes",
                            })
                        end
                    end
                    for _, session in ipairs(sessions) do
                        if not session.idle then
                            table.insert(status, session.name .. ": " .. session.status)
                        end
                    end
                    mutagen[cwd].updated = now
                    mutagen[cwd].total = #sessions
                    mutagen[cwd].status = status
                    -- if #sessions == 0 then
                    --     vim.notify(
                    --         "Mutagen is not running",
                    --         vim.log.levels.ERROR,
                    --         { title = "Mutagen" }
                    --     )
                    -- end
                end
                return mutagen[cwd]
            end

            local error_color = { fg = Snacks.util.color("DiagnosticError") }
            local ok_color = { fg = Snacks.util.color("DiagnosticInfo") }
            table.insert(opts.sections.lualine_x, {
                cond = function() return mutagen_status().enabled end,
                color = function()
                    return (mutagen_status().total == 0 or mutagen_status().status[1])
                            and error_color
                        or ok_color
                end,
                function()
                    local s = mutagen_status()
                    local msg = s.total
                    if #s.status > 0 then msg = msg .. " | " .. table.concat(s.status, " | ") end
                    return (s.total == 0 and "󰋘 " or "󰋙 ") .. msg
                end,
            })
        end,
    },
}
