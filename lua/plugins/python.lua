if vim.g.vscode then return {} end

local file_pattern = { "*.ju.*" }
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
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "python" },
    callback = function() require("swenv.api").auto_venv() end,
})
local tool = "jupynium"
-- local tool="neopyter"

local jupyter_callback = function()
    local Hydra = require("hydra")
    local buf_id = vim.api.nvim_get_current_buf()
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
                "<cmd>JupyniumStartSync 2<CR>y<CR>",
                -- "<cmd>Neopyter sync current<CR>y<CR>",
                { exit = true },
                desc = "start sync",
            },
            {
                "rk",
                "<cmd>JupyniumKernelRestart<CR>",
                { exit = true },
                desc = "restart",
            },
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
        "<cmd>JupyniumExecuteSelectedCells<CR>",
        -- ":Neopyter run current<CR>",
        { buffer = buf_id }
    )
    vim.keymap.set(
        { "i", "n", "x" },
        "<C-CR>",
        "<cmd>JupyniumExecuteSelectedCells<CR>",
        -- ":Neopyter run current<CR>",
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
            venvs_path = vim.fn.expand("~/.conda/envs"),
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
        "kiyoon/jupynium.nvim",
        cond = tool == "jupynium",
        event = { "BufRead *.ju.*" },
        opts = {
            python_host = "/opt/mambaforge/bin/python",
            default_notebook_URL = "localhost:8888",
            firefox_profiles_ini_path = "~/.mozilla/firefox/profiles.ini",
            firefox_profile_name = nil,
            auto_start_server = {
                enable = false,
                file_pattern = file_pattern,
            },
            auto_attach_to_server = {
                enable = true,
                file_pattern = file_pattern,
            },
            auto_start_sync = {
                enable = false,
                file_pattern = file_pattern,
            },
            auto_download_ipynb = false,
            autoscroll = {
                enable = true,
                mode = "always", -- "always" or "invisible"
                cell = {
                    top_margin_percent = 20,
                },
            },

            scroll = {
                page = { step = 0.5 },
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
        config = function(_, opts)
            require("jupynium").setup(opts)
            vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
                pattern = "*.ju.*",
                callback = jupyter_callback,
            })
        end,
    },
    {
        "sustech-data/neopyter",
        cond = tool == "neopyter",
        opts = {
            file_pattern = { "*.ju.*" },
        },
        ft = "python",
        config = function(_, opts)
            require("neopyter").setup(opts)
            vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
                pattern = "*.ju.*",
                callback = jupyter_callback,
            })
        end,
    },
    {
        "benlubas/molten-nvim",
        -- version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
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
