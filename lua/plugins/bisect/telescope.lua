local Util = require("lazyvim.util")
return {
    {
        "nvim-telescope/telescope.nvim",
        keys = {
            { "<leader>fw", Util.pick("live_grep"), desc = "Grep (root dir)" },
            { "<leader>fs", Util.pick("grep_string"), desc = "Grep (root dir)" },
            { "<leader>/", false },
            { "<leader>sw", false },
        },
        dependencies = {
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
            { "nvim-telescope/telescope-file-browser.nvim" },
            { "LukasPietzschmann/telescope-tabs", config = true },
            { "danielfalk/smart-open.nvim", dependencies = { "kkharji/sqlite.lua" } },
            { "tsakirist/telescope-lazy.nvim" },
            { "debugloop/telescope-undo.nvim" },
            { "jvgrootveld/telescope-zoxide" },
            { "nvim-telescope/telescope-symbols.nvim" },
        },
        opts = function()
            -- local icons = require("lazyvim.config").icons
            local opts = {
                defaults = {
                    vimgrep_arguments = {
                        "rg",
                        "--no-heading",
                        "--with-filename",
                        "--line-number",
                        "--column",
                        "--smart-case",
                    },
                    initial_mode = "insert",
                    prompt_prefix = "  ",
                    -- selection_caret = icons.ui.ChevronRight,
                    scroll_strategy = "limit",
                    results_title = false,
                    layout_strategy = "horizontal",
                    path_display = { "absolute" },
                    selection_strategy = "reset",
                    sorting_strategy = "ascending",
                    color_devicons = true,
                    file_ignore_patterns = {
                        ".git/",
                        ".cache",
                        "build/",
                        "%.class",
                        "%.pdf",
                        "%.mkv",
                        "%.mp4",
                        "%.zip",
                    },
                    layout_config = {
                        horizontal = {
                            prompt_position = "top",
                            preview_width = 0.55,
                            results_width = 0.8,
                        },
                        vertical = {
                            mirror = false,
                        },
                        width = 0.85,
                        height = 0.92,
                        preview_cutoff = 120,
                    },
                    file_previewer = require("telescope.previewers").vim_buffer_cat.new,
                    grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
                    qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
                    file_sorter = require("telescope.sorters").get_fuzzy_file,
                    generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
                    mappings = {
                        n = {
                            ["<c-d>"] = require("telescope.actions").delete_buffer,
                            ["<C-j>"] = require("telescope.actions").move_selection_next,
                            ["<C-k>"] = require("telescope.actions").move_selection_previous,
                            ["<C-l>"] = false,
                        }, -- n
                        i = {
                            ["<c-d>"] = require("telescope.actions").delete_buffer,
                            ["<C-j>"] = require("telescope.actions").move_selection_next,
                            ["<C-k>"] = require("telescope.actions").move_selection_previous,
                            ["<C-l>"] = false,
                        }, -- i
                    }, -- mappings
                },
                pickers = {
                    keymaps = {
                        theme = "dropdown",
                    },
                },
                extensions = {
                    fzf = {
                        fuzzy = false,
                        override_generic_sorter = true,
                        override_file_sorter = true,
                        case_mode = "smart_case",
                    },
                    undo = {
                        side_by_side = true,
                        mappings = {
                            i = {
                                ["<cr>"] = function() require("telescope-undo.actions").restore() end,
                            },
                        },
                    },
                },
            }
            return opts
        end,
        config = function(_, opts)
            local telescope = require("telescope")
            telescope.setup(opts)
            telescope.load_extension("fzf")
            telescope.load_extension("file_browser")
            telescope.load_extension("smart_open")
            telescope.load_extension("lazy")
            if Util.has("persisted.nvim") then require("telescope").load_extension("persisted") end
            if Util.has("project.nvim") then require("telescope").load_extension("projects") end
        end,
    },
}
