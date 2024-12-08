---@diagnostic disable: param-type-mismatch
if vim.g.vscode then return {} end

-- if vim.g.swenv == nil then vim.g.swenv = "dl" end
local file_pattern = { "*.ju.*", "*_jnb.*" }
local insert_cell = function(above)
    local cells = require("jupynium.cells")
    local current_separator_row = cells.current_cell_separator()
    if current_separator_row == nil then return end
    local start_row = current_separator_row
    local next_row = cells.next_cell_separator()
    local end_row = next_row and next_row or vim.api.nvim_buf_line_count(0)
    -- print(start_row, end_row)
    local row = above and start_row or end_row
    vim.api.nvim_buf_set_lines(0, row - 1, row - 1, false, { "# %%", "" })
    vim.api.nvim_win_set_cursor(0, { row + 1, 0 })
end

-- vim.api.nvim_create_autocmd("FileType", {
--     pattern = { "python" },
--     callback = function()
--         if vim.g.vscode then return end
--
--         if vim.env.CONDA_PREFIX == nil then
--             if vim.g.VirtualEnvironment then
--                 require("swenv.api").set_venv(vim.g.VirtualEnvironment)
--             else
--                 require("swenv.api").set_venv("base")
--                 -- require("swenv.api").auto_venv()
--             end
--         end
--     end,
-- })

-- local tool = "jupynium"
local tool = "neopyter"
local use_jupynium = tool == "jupynium"

local jupyter_callback = function(buf_id)
    local Hydra = require("hydra")
    -- local buf_id = vim.api.nvim_get_current_buf()
    Hydra({
        name = "Jupyter",
        -- mode = "n",
        body = "<leader>j",
        config = {
            hint = { type = "window" },
            invoke_on_body = true,
            timeout = 500,
        },
        timeout = 500,
        heads = {
            {
                "ss",
                "<cmd>JupyniumStartSync 2<CR>y<CR>" and use_jupynium
                    or "<cmd>Neopyter sync current<CR>y<CR>",
                { exit = true },
                desc = "start sync",
            },
            {
                "rk",
                "<cmd>JupyniumKernelRestart<CR>" and use_jupynium
                    or "<cmd>Neopyter kernel restart<CR>",
                { exit = true },
                desc = "restart",
            },
            -- {
            --     "r",
            --     "<space>X",
            --     "<cmd>Neopyter execute notebook:run-all-above<cr>",
            --     "run all above cell",
            -- },
            {
                "k",
                "<cmd>lua require'jupynium.textobj'.goto_previous_cell_separator()<cr>",
                { desc = "prev" },
            },
            {
                "j",
                "<cmd>lua require'jupynium.textobj'.goto_next_cell_separator()<cr>",
                { desc = "next" },
            },
            { "o", function() insert_cell(false) end, { exit = true } },
            { "O", function() insert_cell(true) end, { exit = true } },
            {
                "v",
                "<cmd>lua require'jupynium.textobj'.select_cell(false, false)<cr>",
                -- { exit = true },
            },
            { "<CR>", "<cmd>JupyniumExecuteSelectedCells<CR>", { exit = true } },
        },
    })
    -- vim.keymap.set(
    --     { "n", "x" },
    --     "<leader>jss>",
    --     "<cmd>JupyniumExecuteSelectedCells<CR>",
    --     { buffer = buf_id }
    -- )
    vim.keymap.set(
        { "n", "x" },
        "<leader><CR>",
        "<cmd>JupyniumExecuteSelectedCells<CR>" and use_jupynium or "<cmd>Neopyter run current<CR>",
        { buffer = buf_id }
    )
    vim.keymap.set(
        { "i", "n", "x" },
        "<C-CR>",
        "<cmd>JupyniumExecuteSelectedCells<CR>" and use_jupynium or "<cmd>Neopyter run current<CR>",
        { buffer = buf_id }
    )
    -- vim.keymap.set(
    --     { "n" },
    --     "gj",
    --     "<cmd>JupyniumKernelHover<cr>",
    --     { buffer = buf_id, desc = "Jupynium hover (inspect a variable)" }
    -- )
    vim.keymap.set(
        { "n", "x", "o" },
        "<C-b>",
        "<cmd>lua require'jupynium.textobj'.goto_previous_cell_separator()<cr>",
        { buffer = buf_id }
    )
    vim.keymap.set(
        { "n", "x", "o" },
        "<C-f>",
        "<cmd>lua require'jupynium.textobj'.goto_next_cell_separator()<cr>",
        { buffer = buf_id }
    )
    -- vim.keymap.set(
    --     { "n", "x", "o" },
    --     "<leader>jo",
    --     function() insert_cell(false) end,
    --     { buffer = buf_id }
    -- )
    -- vim.keymap.set(
    --     { "n", "x", "o" },
    --     "<leader>jO",
    --     function() insert_cell(true) end,
    --     { buffer = buf_id }
    -- )
    vim.keymap.set(
        { "x", "o" },
        "aj",
        "<cmd>lua require'jupynium.textobj'.select_cell(true, false)<cr>",
        { buffer = buf_id }
    )
    vim.keymap.set(
        { "x", "o" },
        "ij",
        "<cmd>lua require'jupynium.textobj'.select_cell(false, false)<cr>",
        { buffer = buf_id }
    )
    vim.keymap.set(
        { "x", "o" },
        "aJ",
        "<cmd>lua require'jupynium.textobj'.select_cell(true, true)<cr>",
        { buffer = buf_id }
    )
    vim.keymap.set(
        { "x", "o" },
        "iJ",
        "<cmd>lua require'jupynium.textobj'.select_cell(false, true)<cr>",
        { buffer = buf_id }
    )
end

return {
    -- {
    --     "telescope.nvim",
    --     opts = {
    --         conda = { anaconda_path = "~/.conda" },
    --     },
    --     dependencies = {
    --         {
    --             "IllustratedMan-code/telescope-conda.nvim",
    --             optional = true,
    --             keys = {
    --                 {
    --                     "<leader>cv",
    --                     function() require("telescope").extensions.conda.conda({}) end,
    --                     desc = "Select CondaEnv",
    --                 },
    --             },
    --         },
    --     },
    -- },
    {
        "AckslD/swenv.nvim",
        opts = {
            get_venvs = function(venvs_path) return require("swenv.api").get_venvs(venvs_path) end,
            -- Path passed to `get_venvs`.
            venvs_path = vim.fn.expand((vim.env.MICROMAMBA_ROOT_PREFI or "~/.conda") .. "/envs"),
            -- Something to do after setting an environment, for example call vim.cmd.LspRestart
            post_set_venv = nil,
        },
        keys = {
            {
                "<leader>cv",
                function() require("swenv.api").pick_venv() end,
                desc = "Select CondaEnv",
            },
        },
    },
    {
        "sustech-data/neopyter",
        cond = tool == "neopyter",
        dependencies = {
            "AbaoFromCUG/websocket.nvim",
            {
                "kiyoon/jupynium.nvim",
                opts = {
                    jupynium_file_pattern = file_pattern,
                    python_host = (vim.env.MICROMAMBA_ROOT_PREFI or "~/.conda") .. "/bin/python",
                    default_notebook_URL = "localhost:8888",
                    firefox_profiles_ini_path = "~/.mozilla/firefox/profiles.ini",
                    firefox_profile_name = nil,
                    auto_start_server = {
                        enable = false,
                        file_pattern = file_pattern,
                    },
                    auto_attach_to_server = {
                        enable = false,
                        file_pattern = file_pattern,
                    },
                    auto_start_sync = {
                        enable = false,
                        file_pattern = file_pattern,
                    },
                    auto_download_ipynb = false,
                    autoscroll = {
                        enable = false,
                        mode = "always", -- "always" or "invisible"
                        cell = {
                            top_margin_percent = 20,
                        },
                    },

                    use_default_keybindings = false,
                    textobjects = {
                        use_default_keybindings = false,
                    },
                    shortsighted = false,
                    auto_close_tab = false,
                },
            },
        },
        opts = {
            filename_mapper = function(ju_path)
                local ipynb_path = ju_path:gsub("%.ju%.%w+", ".ipynb")
                return ipynb_path
            end,

            -- remote_address = "0.0.0.0:9001",
            auto_attach = true,
            -- auto_connect = true,
            on_attach = jupyter_callback,
            file_pattern = file_pattern,
            highlight = { enable = false },
            jupyter = { scroll = {
                align = "start",
            } },
            parser = {
                trim_whitespace = true,
            },
        },
        ft = "python",
    },
    {
        "benlubas/molten-nvim",
        enabled = false,
        dependencies = { "3rd/image.nvim" },
        event = { "BufRead *.ju.*" },
        build = ":UpdateRemotePlugins",
        init = function()
            -- these are examples, not defaults. Please see the readme
            vim.g.molten_image_provider = "image.nvim"
            vim.g.molten_output_win_max_height = 20
        end,
    },
}
