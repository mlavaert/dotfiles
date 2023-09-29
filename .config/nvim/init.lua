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
  install = { colorscheme = { "tokyonight-moon" } },
  checker = { enabled = false },
  change_detection = { notify = false },
}

vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("lazy").setup("config.plugins", opts)

-- -------------------------------------
-- Basic configuration
-- -------------------------------------
-- Numbers
vim.wo.number = true
vim.wo.relativenumber = true

-- Keep signcolumn on by default
vim.wo.signcolumn = "yes"

-- Enable the mouse
vim.opt.mouse = "a"

-- Backup, undo and swap
vim.opt.backup = true
vim.opt.backupdir = vim.fn.stdpath("cache") .. "/backupdir"
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("cache") .. "/undodir"
vim.opt.swapfile = false

-- Case insensitive searching unless capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Decrease update time
vim.opt.updatetime = 250
vim.opt.timeout = true
vim.opt.timeoutlen = 300

-- Enable break indent
vim.opt.breakindent = true

vim.opt.clipboard = "unnamedplus"
vim.opt.cmdheight = 1
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
