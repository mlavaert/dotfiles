local status, packer = pcall(require, "packer")
if not status then
	print("Packer is not installed")
	return
end

vim.cmd([[packadd packer.nvim]])

packer.startup(function(use)
	use("wbthomason/packer.nvim")

	-- Visual
	use({ "catppuccin/nvim", as = "catppuccin" })
	use("hoob3rt/lualine.nvim") -- statusline
	use("kyazdani42/nvim-web-devicons") -- icons for files in telescope
	use("lewis6991/gitsigns.nvim") -- git change indicators

	-- Lsp configuration
	use({
		"neovim/nvim-lspconfig",
		requires = {
			-- Auto-install LSP-servers
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			-- Useful status updates for LSP
			"j-hui/fidget.nvim",
			-- Extra LSP injections
			"jose-elias-alvarez/null-ls.nvim",
			-- Schemas for Yamlls
			"b0o/schemastore.nvim"
		},
	})

	-- Completion
	use({
		"hrsh7th/nvim-cmp",
		requires = {
			"L3MON4D3/LuaSnip",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"onsails/lspkind-nvim", -- icons for LSP completion
		},
	})

	-- Telescope
	use({
		"nvim-telescope/telescope.nvim",
		requires = {
			"nvim-lua/popup.nvim",
			"nvim-lua/plenary.nvim",
		},
	})
	-- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make", cond = vim.fn.executable("make") == 1 })

	-- Treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			require("nvim-treesitter.install").update({ with_sync = true })
		end,
	})
	use({ "nvim-treesitter/nvim-treesitter-textobjects", after = "nvim-treesitter" })

	-- Tim Pope
	use("tpope/vim-surround")
	use("tpope/vim-vinegar")
	use("tpope/vim-commentary")
	use("tpope/vim-fugitive")
	use("tpope/vim-rhubarb")
	use("tpope/vim-sleuth")
end)

-- vim: ts=2:
