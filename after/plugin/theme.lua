function SetTheme(color)
	color = color or "catppuccin"
	vim.cmd.colorscheme(color)
end

SetTheme()

