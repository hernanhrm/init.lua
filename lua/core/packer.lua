local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

return require("packer").startup(function(use)
	use("wbthomason/packer.nvim")

	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.1",
		-- or                            , branch = '0.1.x',
		requires = { { "nvim-lua/plenary.nvim" } },
	})

	-- themes
	use({ "catppuccin/nvim", as = "catppuccin" })
	use("AhmedAbdulrahman/vim-aylin")
	use("lunarvim/horizon.nvim")

	use("nvim-treesitter/nvim-treesitter", { run = ":TSUpdate" })
	use("ThePrimeagen/harpoon")
	use("nvim-treesitter/playground")
	use("mbbill/undotree")
	use("tpope/vim-fugitive")
	use({
		"VonHeikemen/lsp-zero.nvim",
		branch = "v2.x",
		requires = {
			-- LSP Support
			{ "neovim/nvim-lspconfig" }, -- Required
			{
				-- Optional
				"williamboman/mason.nvim",
				run = function()
					pcall(vim.cmd, "MasonUpdate")
				end,
			},
			{ "williamboman/mason-lspconfig.nvim" }, -- Optional

			-- Autocompletion
			{ "hrsh7th/nvim-cmp" }, -- Required
			{ "hrsh7th/cmp-nvim-lsp" }, -- Required
			{ "L3MON4D3/LuaSnip" }, -- Required
		},
	})
	-- Lua
	-- delete to clipboard
	use({
		"folke/trouble.nvim",
		requires = "nvim-tree/nvim-web-devicons",
	})

	use("jose-elias-alvarez/null-ls.nvim")
	use({
		"numToStr/Comment.nvim",
	})

	use("lewis6991/gitsigns.nvim")

	use({
		"nvim-lualine/lualine.nvim",
		requires = { "nvim-tree/nvim-web-devicons", opt = true },
	})
	use({
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	})

	use({
		"akinsho/bufferline.nvim",
		tag = "*",
		config = function()
			require("bufferline").setup({})
		end,
		requires = "nvim-tree/nvim-web-devicons",
	})
	use("marko-cerovac/material.nvim")
	use("folke/tokyonight.nvim")
	use("shaunsingh/moonlight.nvim")
	use("NvChad/nvim-colorizer.lua")

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if packer_bootstrap then
		require("packer").sync()
	end
end)
