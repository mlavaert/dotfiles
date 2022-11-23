vim.cmd('autocmd!')

-- Numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- vim.opt.shiftwidth = 4
-- vim.opt.tabstop = 4
-- vim.opt.softtabstop = 4
-- vim.opt.expandtab = true

-- Backup, undo and swap
vim.opt.backup    = true
vim.opt.backupdir = vim.fn.stdpath("cache") .. '/backupdir'
vim.opt.undofile  = true
vim.opt.undodir   = vim.fn.stdpath("cache") .. '/undodir'
vim.opt.swapfile  = false

-- Other options
vim.opt.backup = true
vim.opt.clipboard = "unnamedplus"
vim.opt.cmdheight = 1
vim.opt.colorcolumn = "80"
vim.opt.completeopt = 'menu,menuone,noselect'
vim.opt.expandtab = true
vim.opt.ignorecase = true
vim.opt.inccommand = 'split'
vim.opt.list = true
vim.opt.listchars = { tab = '▸ ', trail = '·' }
vim.opt.path:append { '**' } -- find files recursively
vim.opt.redrawtime    = 1000
vim.opt.scrolloff     = 8
vim.opt.shell         = 'zsh'
vim.opt.sidescrolloff = 8
vim.opt.signcolumn    = "yes"
vim.opt.undofile      = true
vim.opt.updatetime    = 50
vim.opt.wrap          = false

vim.cmd.colorscheme "catppuccin"
