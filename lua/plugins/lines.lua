local fg = require("lazyvim.util").ui.fg

local colors = {
    [""] = fg("Special"),
    ["Normal"] = fg("Special"),
    ["Warning"] = fg("DiagnosticError"),
    ["InProgress"] = fg("DiagnosticWarn"),
}
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
                        require("noice").api.status.message.get_hl,
                        cond = require("noice").api.status.message.has,
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
                            if not package.loaded["copilot"] then return end
                            local status = require("copilot.api").status.data
                            return colors[status.status] or colors[""]
                        end,
                    },
                    {
                        function()
                            local icon = "󰙯 "
                            return icon
                        end,
                        color = fg("Special"),
                        cond = function()
                            local ok, presence = pcall(require, "presence")
                            return ok and presence.is_connected
                        end,
                    },
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
                        color = fg("Special"),
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
}
