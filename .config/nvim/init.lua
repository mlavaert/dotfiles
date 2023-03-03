-- -------------------------------------
-- Install packer
-- -------------------------------------
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	is_bootstrap = true
	vim.fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
	vim.cmd([[packadd packer.nvim]])
end

vim.cmd([[packadd packer.nvim]])

require("packer").startup(function(use)
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
			-- Additional Lua configuration, makes Nvim configuration amazing
			"folke/neodev.nvim",
		},
	})

	-- Completion
	use({
		"hrsh7th/nvim-cmp",
		requires = {
			"L3MON4D3/LuaSnip",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
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

	if is_bootstrap then
		require("packer").sync()
	end
end)

-- Automatically source and re-compile packer whenever you save this init.lua
local packer_group = vim.api.nvim_create_augroup("Packer", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
	command = "source <afile> | silent! LspStop | silent! LspStart | PackerCompile",
	group = packer_group,
	pattern = vim.fn.expand("$MYVIMRC"),
})

vim.cmd("autocmd!")


-- -------------------------------------
-- Basic configuration
-- -------------------------------------
-- Numbers
vim.wo.number = true
vim.wo.relativenumber = true

-- Enable the mouse
vim.o.mouse = "a"

-- Backup, undo and swap
vim.opt.backup = true
vim.opt.backupdir = vim.fn.stdpath("cache") .. "/backupdir"
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("cache") .. "/undodir"
vim.opt.swapfile = false

-- Case insensitive searching unless capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Decrease the updatetime
vim.opt.updatetime = 250
vim.opt.signcolumn = "yes"

vim.opt.clipboard = "unnamedplus"
vim.opt.cmdheight = 1
vim.opt.colorcolumn = "80"
vim.opt.completeopt = "menu,menuone,noselect"
vim.opt.expandtab = true
vim.opt.inccommand = "split"
vim.opt.list = true
vim.opt.listchars = { tab = "▸ ", trail = "·" }
vim.opt.path:append({ "**" }) -- find files recursively
vim.opt.scrolloff = 8
vim.opt.shell = "bash"
vim.opt.sidescrolloff = 8
vim.opt.wrap = false

-- -------------------------------------
-- Keymaps
-- -------------------------------------
local keymap = vim.keymap

vim.g.mapleader = " "
vim.g.maplocalleader = " "

keymap.set({ "n", "v" }, "<space>", "<nop>", { silent = true })

-- [[ Quickly go to Vim configuration ]]
keymap.set("n", "<leader>ve", ":edit ${XDG_CONFIG_HOME}/nvim/init.lua<CR>", { desc = "Open Neovim Config" })
keymap.set("n", "<leader>vr", ":luafile %<CR>", { desc = "Reload Lua config file" })

keymap.set("n", "<leader>pd", ":Lex 25<CR>", { desc = "Open project drawer" })

-- [[ Buffers ]]
keymap.set("n", "]b", ":bnext<CR>", { desc = "Next buffer" })
keymap.set("n", "[b", ":bprev<CR>", { desc = "Previous buffer" })
keymap.set("n", "<leader>bk", ":bdelete!<CR>", { desc = "Kill current buffer" })

-- [[ Better vertical navigation ]]
keymap.set("n", "<C-d>", "<C-d>zz")
keymap.set("n", "<C-u>", "<C-u>zz")

-- [[ Highlight on Yank ]]
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})

-- -------------------------------------
-- Improve Terraform handling
-- -------------------------------------
vim.cmd([[silent! autocmd! filetypedetect BufRead,BufNewFile *.tf]])
vim.cmd([[autocmd BufRead,BufNewFile *.hcl set filetype=hcl]])
vim.cmd([[autocmd BufRead,BufNewFile .terraformrc,terraform.rc set filetype=hcl]])
vim.cmd([[autocmd BufRead,BufNewFile *.tf,*.tfvars set filetype=terraform]])
vim.cmd([[autocmd BufRead,BufNewFile *.tfstate,*.tfstate.backup set filetype=json]])

vim.cmd.colorscheme("catppuccin")
-- vim: ts=2:
