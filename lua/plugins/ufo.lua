local handler = function(virtText, lnum, endLnum, width, truncate)
    local newVirtText = {}
    local suffix = ("  %d "):format(endLnum - lnum)
    local sufWidth = vim.fn.strdisplaywidth(suffix)
    local targetWidth = width - sufWidth
    local curWidth = 0
    for _, chunk in ipairs(virtText) do
        local chunkText = chunk[1]
        local chunkWidth = vim.fn.strdisplaywidth(chunkText)
        if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
        else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, { chunkText, hlGroup })
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            -- str width returned from truncate() may less than 2nd argument, need padding
            if curWidth + chunkWidth < targetWidth then
                suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
            end
            break
        end
        curWidth = curWidth + chunkWidth
    end
    table.insert(newVirtText, { suffix, "MoreMsg" })
    return newVirtText
end

local ftMap = {
    python = function(bufnr)
        local ufo = require("ufo")
        local function handleFallbackException(err, providerName)
            if type(err) == "string" and err:match("UfoFallbackException") then
                return ufo.getFolds(bufnr, providerName)
            else
                return require("promise").reject(err)
            end
        end
        return ufo.getFolds(bufnr, "lsp")
            :catch(function(err) return handleFallbackException(err, "treesitter") end)
            :catch(function(err) return handleFallbackException(err, "indent") end)
            :thenCall(function(ufo_folds)
                local ok, jupynium = pcall(require, "jupynium")
                if ok then
                    for _, fold in ipairs(jupynium.get_folds()) do
                        table.insert(ufo_folds, fold)
                    end
                end
                return ufo_folds
            end)
    end,
}
return {
    "kevinhwang91/nvim-ufo",
    event = { "BufReadPost" },
    keys = {
        {
            "<leader>zo",
            function() require("ufo").openAllFolds() end,
        },
        {
            "<leader>zc",
            function() require("ufo").closeAllFolds() end,
        },
    },
    dependencies = {
        "kevinhwang91/promise-async",
        {
            "luukvbaal/statuscol.nvim",
            config = function()
                local builtin = require("statuscol.builtin")
                require("statuscol").setup({
                    -- foldfunc = "builtin",
                    -- setopt = true,
                    relculright = true,
                    segments = {
                        { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
                        { text = { "%s" }, click = "v:lua.ScSa" },
                        { text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
                    },
                })
            end,
        },
        { "chrisgrieser/nvim-origami", opts = true },
    },
    opts = {
        enable_get_fold_virt_text = true,
        fold_virt_text_handler = handler,
        open_fold_hl_timeout = 0,
        close_fold_kinds = {},
        preview = {
            win_config = {
                -- border = { "", "─", "", "", "", "─", "", "" },
                winhighlight = "Normal:Normal",
                -- winblend = 0,
            },
        },
        provider_selector = function(bufnr, filetype, buftype) return ftMap[filetype] end,
    },
    config = function(_, opts)
        local ufo = require("ufo")
        vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
        vim.o.foldcolumn = "1" -- '0' is not bad
        vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
        vim.o.foldlevelstart = 99
        vim.o.foldenable = true

        ufo.setup(opts)
    end,
}
