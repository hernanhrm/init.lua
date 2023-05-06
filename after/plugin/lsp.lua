local lsp = require("lsp-zero").preset({})

lsp.nvim_workspace()

local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }

local cmp_mappings = lsp.defaults.cmp_mappings({
    ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
    ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
    ["<Tab>"] = cmp.mapping.confirm({ select = true }),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
    ["<C-Space>"] = cmp.mapping.complete(),
})

lsp.setup_nvim_cmp({
    mapping = cmp_mappings,
})

lsp.ensure_installed({
    "tsserver",
    "eslint",
    "lua_ls",
    "gopls",
    "pyright",
})

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions

vim.keymap.set("n", "<space>e", vim.diagnostic.open_float)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist)

lsp.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }

    vim.keymap.set("n", "gd", function()
        vim.lsp.buf.definition()
    end, opts)

    -- implemented with telescope
    -- vim.keymap.set("n", "gi", function()
    -- 	vim.lsp.buf.implementation()
    -- end, opts)

    vim.keymap.set("n", "K", function()
        vim.lsp.buf.hover()
    end, opts)

    vim.keymap.set("n", "<leader>lws", function()
        vim.lsp.buf.workspace_symbol()
    end, opts)

    -- implemented with telescope
    -- vim.keymap.set("n", "<leader>lds", function()
    -- 	vim.lsp.buf.document_symbol()
    -- end, opts)

    vim.keymap.set("n", "<leader>lof", function()
        vim.diagnostic.open_float()
    end, opts)

    vim.keymap.set("n", "[d", function()
        vim.diagnostic.goto_next()
    end, opts)

    vim.keymap.set("n", "]d", function()
        vim.diagnostic.goto_prev()
    end, opts)

    vim.keymap.set("n", "<leader>lca", function()
        vim.lsp.buf.code_action()
    end, opts)

    vim.keymap.set("n", "<leader>ltd", function()
        vim.lsp.buf.type_definition()
    end, opts)

    -- implemented with telescope
    -- vim.keymap.set("n", "<leader>lr", function()
    --     vim.lsp.buf.references()
    -- end, opts)

    vim.keymap.set("n", "<leader>lrn", function()
        vim.lsp.buf.rename()
    end, opts)

    vim.keymap.set("i", "<C-h>", function()
        vim.lsp.buf.signature_help()
    end, opts)
end)

-- (Optional) Configure lua language server for neovim
require("lspconfig").lua_ls.setup(lsp.nvim_lua_ls())

lsp.setup()
