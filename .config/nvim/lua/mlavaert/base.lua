vim.cmd("autocmd!")

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

vim.cmd.colorscheme("catppuccin")
