-- -------------------------------------
-- Install Lazy
-- -------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local opts = {
	git = { log = { "--since=3 days ago" } },
	ui = { custom_keys = { false } },
	install = { colorscheme = { "tokyonight-moon" } },
	performance = {
		rtp = {
			disabled_plugins = {
				"gzip",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
				"rplugin",
				"matchparen",
				"matchit",
			},
		},
	},
	checker = { enabled = false },
}

vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("lazy").setup("config.plugins",  opts)

-- -------------------------------------
-- Basic configuration
-- -------------------------------------
-- Numbers
vim.wo.number = true
vim.wo.relativenumber = true

-- Keep signcolumn on by default
vim.wo.signcolumn = "yes"

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

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 300

-- Enable break indent
vim.o.breakindent = true

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

keymap.set({ "n", "v" }, "<space>", "<nop>", { silent = true })

-- [[ Quickly go to Vim configuration ]]
keymap.set("n", "<leader>ve", ":edit ${XDG_CONFIG_HOME}/nvim/init.lua<CR>", { desc = "Open Neovim Config" })
keymap.set("n", "<leader>vr", ":luafile %<CR>", { desc = "Reload Lua config file" })

keymap.set("n", "<leader>pd", ":Lex 20<CR>", { desc = "Open project drawer" })

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

-- vim: ts=4 sts=4 sw=4:
