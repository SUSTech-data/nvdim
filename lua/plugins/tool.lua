return {
    {
        "subnut/nvim-ghost.nvim",
        cmd = "GhostTextStart",
        init = function() vim.g.nvim_ghost_autostart = 0 end,
    },
    {
        "ibhagwan/smartyank.nvim",
        -- event = "BufReadPost",
        enabled = false,
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
        -- event = "Syntax",
        cmd = "Oil",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            -- Oil will take over directory buffers (e.g. `vim .` or `:e src/`
            default_file_explorer = true,
            use_default_keymaps = true,
            view_options = {
                show_hidden = true,
            },
        },
        init = function(p)
            if vim.fn.argc() == 1 then
                local argv = tostring(vim.fn.argv(0))
                local stat = vim.loop.fs_stat(argv)

                local remote_dir_args = vim.startswith(argv, "ssh")
                    or vim.startswith(argv, "sftp")
                    or vim.startswith(argv, "scp")

                if stat and stat.type == "directory" or remote_dir_args then
                    require("lazy").load({ plugins = { p.name } })
                end
            end
            if not require("lazy.core.config").plugins[p.name]._.loaded then
                vim.api.nvim_create_autocmd("BufNew", {
                    callback = function()
                        if vim.fn.isdirectory(vim.fn.expand("<afile>")) == 1 then
                            require("lazy").load({ plugins = { "oil.nvim" } })
                            return true
                        end
                    end,
                })
            end
        end,
    },
    {
        "keaising/im-select.nvim",
        config = true,
        event = { "InsertEnter" },
    },
    {
        "glacambre/firenvim",
        cond = not vim.g.started_by_firenvim,
        config = true,
        build = function() vim.fn["firenvim#install"](0) end,
    },
    {
        "nvim-lua/plenary.nvim",
        keys = {
            {
                "<leader>pb",
                function() require("plenary.profile").start("profile.log", { flame = true }) end,
                desc = "Begin profiling",
            },
            {
                "<leader>pe",
                function() require("plenary.profile").stop() end,
                desc = "End profiling",
            },
        },
    },
}
