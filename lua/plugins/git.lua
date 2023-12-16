return {
    -- { "tpope/vim-fugitive", cmd = "G" }, -- Git commands in nvim
    -- 'tpope/vim-rhubarb' -- Fugitive-companion to interact with github
    {
        "sindrets/diffview.nvim",
        event = "BufEnter",
        keys = {
            { "<leader>gh", "<Cmd>DiffviewFileHistory %<CR>", desc = "file history" },
            { "<leader>gH", "<Cmd>DiffviewFileHistory <CR>", desc = "Commit history" },
            { "<leader>gv", "<Cmd>DiffviewOpen<CR>", desc = "Diff View" },
        },
    },
    {
        "lewis6991/gitsigns.nvim",
        opts = function()
            return {
                signs = {
                    add = { text = "┃" },
                    change = { text = "┃" },
                    delete = { text = "" },
                    topdelete = { text = "" },
                    changedelete = { text = "┃" },
                    untracked = { text = "┆" },
                },
                current_line_blame = true,
                current_line_blame_opts = { delay = 300, virtual_text_pos = "eol" },
                on_attach = function(bufnr)
                    local gs = package.loaded.gitsigns
                    -- Text object
                    vim.keymap.set(
                        { "o", "x" },
                        "ih",
                        ":<C-U>Gitsigns select_hunk<CR>",
                        { desc = "git hunk", buffer = bufnr }
                    )

                    -- Navigation
                    local next_hunk = function()
                        if vim.wo.diff then return "]c" end
                        vim.schedule(function() gs.next_hunk() end)
                        return "<Ignore>"
                    end

                    local prev_hunk = function()
                        if vim.wo.diff then return "[c" end
                        vim.schedule(function() gs.prev_hunk() end)
                        return "<Ignore>"
                    end

                    require("which-key").register({
                        ["]c"] = { next_hunk, "change", expr = true },
                        ["[c"] = { prev_hunk, "change", expr = true },
                        ["<leader>g"] = {
                            s = { gs.stage_hunk, "stage" },
                            r = { gs.reset_hunk, "reset" },
                            u = { gs.undo_stage_hunk, "undo" },
                            p = { gs.preview_hunk, "preview" },
                            S = { gs.stage_buffer, "stage buffer" },
                            R = { gs.reset_buffer, "reset buffer" },
                            b = {
                                function() gs.blame_line({ full = false }) end,
                                "blame message",
                            },
                            B = {
                                function() gs.blame_line({ full = true }) end,
                                "blame full",
                            },
                            d = { gs.diffthis, "diff with index" },
                            D = {
                                function() gs.diffthis("~") end,
                                "diff with last commit",
                            },
                        },
                        ["<leader>gt"] = {
                            name = "toggle",
                            b = { gs.toggle_current_line_blame, "blame" },
                            d = { gs.toggle_deleted, "deleted" },
                        },
                        ["<leader>gf"] = {
                            name = "find",
                            s = { "<cmd>Telescope git_status<cr>", "Open changed file" },
                            b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
                            c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
                        },
                    }, { buffer = bufnr })
                end,
            }
        end,
    },
}
