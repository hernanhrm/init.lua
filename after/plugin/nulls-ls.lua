local null_ls = require("null-ls")
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup({
	debug = true,
	sources = {
		null_ls.builtins.formatting.prettier,
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.diagnostics.eslint,
		null_ls.builtins.completion.spell,

		-- golang
		null_ls.builtins.formatting.gofmt,
		null_ls.builtins.formatting.goimports,
		null_ls.builtins.formatting.goimports_reviser,

		-- python
		null_ls.builtins.diagnostics.ruff,
		null_ls.builtins.formatting.black,
		null_ls.builtins.formatting.isort,

		-- sql
		null_ls.builtins.formatting.sqlformat,

		--refactoring go, js, lua, python and ts
		null_ls.builtins.code_actions.refactoring,

		-- git
		null_ls.builtins.code_actions.gitsigns,
	},
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					-- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
					vim.lsp.buf.format()
				end,
			})
		end
	end,
})
