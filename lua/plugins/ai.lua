local prompts = {
    -- 与代码相关的提示
    Explain = "请解释以下代码的工作原理。",
    Review = "请检查以下代码，并提供改进建议。",
    Tests = "请解释所选代码的工作原理，然后为其生成单元测试。",
    Refactor = "请重构以下代码，以提高其清晰度和可读性。",
    FixCode = "请修复以下代码，使其按预期工作。",
    FixError = "请解释以下文本中的错误，并提供解决方案。",
    BetterNamings = "请为以下变量和函数提供更好的名称。",
    Documentation = "请为以下代码提供文档。",
    SwaggerApiDocs = "请使用Swagger为以下API提供文档。",
    SwaggerJsDocs = "请使用Swagger为以下API编写JSDoc。",
    -- 与文本相关的提示
    Summarize = "请总结以下文本。",
    Spelling = "请纠正以下文本中的任何语法和拼写错误。",
    Wording = "请改善以下文本的语法和措辞。",
    Concise = "请重写以下文本，使其更简洁。",
}


return {
    -- {
    --     "sourcegraph/sg.nvim",
    --     event = "BufRead",
    --     dependencies = { "nvim-lua/plenary.nvim" },
    --     build = "nvim -l build/init.lua",
    -- },
    -- {
    --     "jcdickinson/codeium.nvim",
    --     enabled=false,
    --     event = "BufRead",
    --     dependencies = {
    --         "nvim-lua/plenary.nvim",
    --         "hrsh7th/nvim-cmp",
    --     },
    --     config = function() require("codeium").setup({}) end,
    -- },
    {
        "zbirenbaum/copilot.lua",
        event = "InsertEnter",
        cmd = "Copilot",
        opts = {
            suggestion = {
                enabled = true,
                auto_trigger = true,
                keymap = {
                    accept = "<M-i>",
                    accept_word = "<M-w>",
                    accept_line = "<M-l>",
                },
            },
            panel = { enabled = true, auto_refresh = true },
            filetypes = {
                markdown = true,
                help = true,
            },
        },
    },
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        branch = "canary", -- Use the canary branch if you want to test the latest features but it might be unstable
        dependencies = {
            { "nvim-telescope/telescope.nvim" }, -- Use telescope for help actions
            { "nvim-lua/plenary.nvim" },
        },
        opts = {
            question_header = "## User ",
            answer_header = "## Copilot ",
            error_header = "## Error ",
            separator = " ", -- Separator to use in chat
            prompts = prompts,
            auto_follow_cursor = false, -- Don't follow the cursor after getting response
            show_help = false, -- Show help in virtual text, set to true if that's 1st time using Copilot Chat
            mappings = {
                -- Use tab for completion
                complete = {
                    detail = "Use @<Tab> or /<Tab> for options.",
                    insert = "<Tab>",
                },
                -- Close the chat
                close = {
                    normal = "q",
                    insert = "<C-c>",
                },
                -- Reset the chat buffer
                reset = {
                    normal = "<C-l>",
                    insert = "<C-l>",
                },
                -- Submit the prompt to Copilot
                submit_prompt = {
                    normal = "<CR>",
                    insert = "<C-CR>",
                },
                -- Accept the diff
                accept_diff = {
                    normal = "<C-y>",
                    insert = "<C-y>",
                },
                -- Yank the diff in the response to register
                yank_diff = {
                    normal = "gmy",
                },
                -- Show the diff
                show_diff = {
                    normal = "gmd",
                },
                -- Show the prompt
                show_system_prompt = {
                    normal = "gmp",
                },
                -- Show the user selection
                show_user_selection = {
                    normal = "gms",
                },
            },
        },
        config = function(_, opts)
            local chat = require("CopilotChat")
            local select = require("CopilotChat.select")
            -- Use unnamed register for the selection
            opts.selection = select.unnamed

            -- Override the git prompts message
            opts.prompts.Commit = {
                prompt = "Write commit message for the change with commitizen convention",
                selection = select.gitdiff,
            }
            opts.prompts.CommitStaged = {
                prompt = "Write commit message for the change with commitizen convention",
                selection = function(source) return select.gitdiff(source, true) end,
            }

            chat.setup(opts)

            vim.api.nvim_create_user_command(
                "CopilotChatVisual",
                function(args) chat.ask(args.args, { selection = select.visual }) end,
                { nargs = "*", range = true }
            )

            -- Inline chat with Copilot
            vim.api.nvim_create_user_command(
                "CopilotChatInline",
                function(args)
                    chat.ask(args.args, {
                        selection = select.visual,
                        window = {
                            layout = "float",
                            relative = "cursor",
                            width = 1,
                            height = 0.4,
                            row = 1,
                        },
                    })
                end,
                { nargs = "*", range = true }
            )

            -- Restore CopilotChatBuffer
            vim.api.nvim_create_user_command(
                "CopilotChatBuffer",
                function(args) chat.ask(args.args, { selection = select.buffer }) end,
                { nargs = "*", range = true }
            )

            -- Custom buffer for CopilotChat
            vim.api.nvim_create_autocmd("BufEnter", {
                pattern = "copilot-*",
                callback = function()
                    vim.opt_local.relativenumber = true
                    vim.opt_local.number = true

                    -- Get current filetype and set it to markdown if the current filetype is copilot-chat
                    local ft = vim.bo.filetype
                    if ft == "copilot-chat" then vim.bo.filetype = "markdown" end
                end,
            })

            -- Add which-key mappings
            local wk = require("which-key")
            wk.register({
                g = {
                    m = {
                        name = "+Copilot Chat",
                        d = "Show diff",
                        p = "System prompt",
                        s = "Show selection",
                        y = "Yank diff",
                    },
                },
            })
        end,
        -- event = "VeryLazy",
        keys = {
            -- Show help actions with telescope
            {
                "<leader>ah",
                function()
                    local actions = require("CopilotChat.actions")
                    require("CopilotChat.integrations.telescope").pick(actions.help_actions())
                end,
                desc = "CopilotChat - Help actions",
            },
            -- Show prompts actions with telescope
            {
                "<leader>ap",
                function()
                    local actions = require("CopilotChat.actions")
                    require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
                end,
                desc = "CopilotChat - Prompt actions",
            },
            {
                "<leader>ap",
                ":lua require('CopilotChat.integrations.telescope').pick(require('CopilotChat.actions').prompt_actions({selection = require('CopilotChat.select').visual}))<CR>",
                mode = "x",
                desc = "CopilotChat - Prompt actions",
            },
            -- Code related commands
            { "<leader>ae", "<cmd>CopilotChatExplain<cr>", desc = "CopilotChat - Explain code" },
            { "<leader>at", "<cmd>CopilotChatTests<cr>", desc = "CopilotChat - Generate tests" },
            { "<leader>ar", "<cmd>CopilotChatReview<cr>", desc = "CopilotChat - Review code" },
            { "<leader>aR", "<cmd>CopilotChatRefactor<cr>", desc = "CopilotChat - Refactor code" },
            {
                "<leader>an",
                "<cmd>CopilotChatBetterNamings<cr>",
                desc = "CopilotChat - Better Naming",
            },
            -- Chat with Copilot in visual mode
            {
                "<leader>av",
                ":CopilotChatVisual",
                mode = "x",
                desc = "CopilotChat - Open in vertical split",
            },
            {
                "<leader>ax",
                ":CopilotChatInline<cr>",
                mode = "x",
                desc = "CopilotChat - Inline chat",
            },
            -- Custom input for CopilotChat
            {
                "<leader>ai",
                function()
                    local input = vim.fn.input("Ask Copilot: ")
                    if input ~= "" then vim.cmd("CopilotChat " .. input) end
                end,
                desc = "CopilotChat - Ask input",
            },
            -- Generate commit message based on the git diff
            {
                "<leader>am",
                "<cmd>CopilotChatCommit<cr>",
                desc = "CopilotChat - Generate commit message for all changes",
            },
            {
                "<leader>aM",
                "<cmd>CopilotChatCommitStaged<cr>",
                desc = "CopilotChat - Generate commit message for staged changes",
            },
            -- Quick chat with Copilot
            {
                "<leader>aq",
                function()
                    local input = vim.fn.input("Quick Chat: ")
                    if input ~= "" then vim.cmd("CopilotChatBuffer " .. input) end
                end,
                desc = "CopilotChat - Quick chat",
            },
            -- Debug
            { "<leader>ad", "<cmd>CopilotChatDebugInfo<cr>", desc = "CopilotChat - Debug Info" },
            -- Fix the issue with diagnostic
            {
                "<leader>af",
                "<cmd>CopilotChatFixDiagnostic<cr>",
                desc = "CopilotChat - Fix Diagnostic",
            },
            -- Clear buffer and chat history
            {
                "<leader>al",
                "<cmd>CopilotChatReset<cr>",
                desc = "CopilotChat - Clear buffer and chat history",
            },
            -- Toggle Copilot Chat Vsplit
            { "<leader>av", "<cmd>CopilotChatToggle<cr>", desc = "CopilotChat - Toggle" },
        },
    },
    { "zbirenbaum/copilot-cmp", enabled = false },
}
