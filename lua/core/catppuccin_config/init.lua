local theme = require("core.catppuccin_config.theme")

vim.cmd("hi clear")

vim.o.background = "dark"
if vim.fn.exists("syntax_on") then
	vim.cmd("syntax reset")
end

vim.o.termguicolors = true
vim.g.colors_name = "catppuccin"

theme.set_highlights()
