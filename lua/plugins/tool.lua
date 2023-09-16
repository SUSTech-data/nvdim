return {
    {
        "subnut/nvim-ghost.nvim",
        cmd = "GhostTextStart",
        init = function() vim.g.nvim_ghost_autostart = 0 end,
    },
    {
        "ibhagwan/smartyank.nvim",
        event = "BufReadPost",
        opts = {
            highlight = {
                enabled = false, -- highlight yanked text
                higroup = "IncSearch", -- highlight group of yanked text
                timeout = 2000, -- timeout for clearing the highlight
            },
            clipboard = {
                enabled = true,
            },
            tmux = {
                enabled = true,
                -- remove `-w` to disable copy to host client's clipboard
                cmd = { "tmux", "set-buffer", "-w" },
            },
            osc52 = {
                enabled = true,
                ssh_only = true, -- false to OSC52 yank also in local sessions
                silent = false, -- true to disable the "n chars copied" echo
                echo_hl = "Directory", -- highlight group of the OSC52 echo message
            },
        },
    },
    {
        "stevearc/oil.nvim",
        event = "Syntax",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            -- Id is automatically added at the beginning, and name at the end
            -- See :help oil-columns
            columns = {
                "icon",
                -- "permissions",
                -- "size",
                -- "mtime",
            },
            -- Buffer-local options to use for oil buffers
            buf_options = {
                buflisted = false,
                bufhidden = "hide",
            },
            -- Window-local options to use for oil buffers
            win_options = {
                wrap = false,
                signcolumn = "no",
                cursorcolumn = false,
                foldcolumn = "0",
                spell = false,
                list = false,
                conceallevel = 3,
                concealcursor = "n",
            },
            -- Oil will take over directory buffers (e.g. `vim .` or `:e src/`
            default_file_explorer = true,
            -- Restore window options to previous values when leaving an oil buffer
            restore_win_options = true,
            -- Skip the confirmation popup for simple operations
            skip_confirm_for_simple_edits = false,
            -- Deleted files will be removed with the trash_command (below).
            delete_to_trash = false,
            -- Change this to customize the command used when deleting to trash
            trash_command = "trash-put",
            -- Selecting a new/moved/renamed file or directory will prompt you to save changes first
            prompt_save_on_select_new_entry = true,
            -- Keymaps in oil buffer. Can be any value that `vim.keymap.set` accepts OR a table of keymap
            -- options with a `callback` (e.g. { callback = function() ... end, desc = "", nowait = true })
            -- Additionally, if it is a string that matches "actions.<name>",
            -- it will use the mapping at require("oil.actions").<name>
            -- Set to `false` to remove a keymap
            -- See :help oil-actions for a list of all available actions
            keymaps = {
                ["g?"] = "actions.show_help",
                ["<CR>"] = "actions.select",
                ["<C-v>"] = "actions.select_vsplit",
                ["<C-x>"] = "actions.select_split",
                ["<C-t>"] = "actions.select_tab",
                ["<C-p>"] = "actions.preview",
                ["<C-c>"] = "actions.close",
                -- ["<C-l>"] = "actions.refresh",
                ["-"] = "actions.parent",
                ["_"] = "actions.open_cwd",
                ["`"] = "actions.cd",
                ["~"] = "actions.tcd",
                ["g."] = "actions.toggle_hidden",
            },
            -- Set to false to disable all of the above keymaps
            use_default_keymaps = false,
            view_options = {
                -- Show files and directories that start with "."
                show_hidden = false,
                -- This function defines what is considered a "hidden" file
                is_hidden_file = function(name, bufnr) return vim.startswith(name, ".") end,
                -- This function defines what will never be shown, even when `show_hidden` is set
                is_always_hidden = function(name, bufnr) return false end,
            },
            -- Configuration for the floating window in oil.open_float
            float = {
                -- Padding around the floating window
                padding = 2,
                max_width = 0,
                max_height = 0,
                border = "rounded",
                win_options = {
                    winblend = 10,
                },
            },
            -- Configuration for the actions floating preview window
            preview = {
                -- Width dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
                -- min_width and max_width can be a single value or a list of mixed integer/float types.
                -- max_width = {100, 0.8} means "the lesser of 100 columns or 80% of total"
                max_width = 0.9,
                -- min_width = {40, 0.4} means "the greater of 40 columns or 40% of total"
                min_width = { 40, 0.4 },
                -- optionally define an integer/float for the exact width of the preview window
                width = nil,
                -- Height dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
                -- min_height and max_height can be a single value or a list of mixed integer/float types.
                -- max_height = {80, 0.9} means "the lesser of 80 columns or 90% of total"
                max_height = 0.9,
                -- min_height = {5, 0.1} means "the greater of 5 columns or 10% of total"
                min_height = { 5, 0.1 },
                -- optionally define an integer/float for the exact height of the preview window
                height = nil,
                border = "rounded",
                win_options = {
                    winblend = 0,
                },
            },
            -- Configuration for the floating progress window
            progress = {
                max_width = 0.9,
                min_width = { 40, 0.4 },
                width = nil,
                max_height = { 10, 0.9 },
                min_height = { 5, 0.1 },
                height = nil,
                border = "rounded",
                minimized_border = "none",
                win_options = {
                    winblend = 0,
                },
            },
        },
    },
    {
        "niuiic/code-shot.nvim",
        dependencies = { "niuiic/core.nvim" },
        config = true,
        keys = {
            {
                "<leader>ps",
                function() require("code-shot").shot() end,
                desc = "PrintScr",
                mode = { "n", "v" },
            },
        },
    },
    {
        "keaising/im-select.nvim",
        config = true,
        event = { "InsertEnter" },
    },
    {
        "glacambre/firenvim",
        lazy = not vim.g.started_by_firenvim,
        config = true,
        build = function() vim.fn["firenvim#install"](0) end,
    },
    {
        "nvim-lua/plenary.nvim",
        keys = {
            {
                "<leader>hpb",
                function() require("plenary.profile").start("profile.log", { flame = true }) end,
                desc = "Begin profiling",
            },
            {
                "<leader>hpe",
                function() require("plenary.profile").stop() end,
                desc = "End profiling",
            },
        },
    },
}
