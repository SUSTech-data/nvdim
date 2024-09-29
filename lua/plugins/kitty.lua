return {
    {
        "mikesmithgh/kitty-scrollback.nvim",
        cmd = { "KittyScrollbackGenerateKittens", "KittyScrollbackCheckHealth" },
        event = { "User KittyScrollbackLaunch" },
        -- version = '*', -- latest stable version, may have breaking changes if major version changed
        -- version = '^4.0.0', -- pin major version, include fixes and features that do not have breaking changes
        -- config = true,
        opts = {
            {
                paste_window = {
                    winopts_overrides = function(winopts)
                        winopts.border = {
                            "╭",
                            "─",
                            "╮",
                            "│",
                            "┤",
                            "─",
                            "├",
                            "│",
                        }
                        return winopts
                    end,
                    footer_winopts_overrides = function(winopts)
                        winopts.border = {
                            "│",
                            " ",
                            "│",
                            "│",
                            "╯",
                            "─",
                            "╰",
                            "│",
                        }
                        return winopts
                    end,
                },
            },
        },
    },
    {
        "fladson/vim-kitty",
        ft = "kitty",
    },
    -- {
    --     "willothy/flatten.nvim",
    --     config = true,
    --     lazy = false,
    --     priority = 1001,
    --     opts = function()
    --         return {
    --             window = {
    --                 open = "current",
    --             },
    --             -- nest_if_no_args = true,
    --             -- one_per = {
    --             --     kitty = false,
    --             -- },
    --         }
    --     end,
    -- },
}
