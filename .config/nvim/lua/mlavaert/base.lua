vim.cmd('autocmd!')

-- File encoding
vim.scriptencoding = 'utf-8'
vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'

-- Numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Other options
vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = "80"
vim.opt.ai = true -- Auto indent
vim.opt.autoindent = true
vim.opt.backspace = 'start,eol,indent'
vim.opt.backup = false
vim.opt.breakindent = true
vim.opt.cmdheight = 1
vim.opt.completeopt = 'menu,menuone,noselect'
vim.opt.expandtab = true
vim.opt.hidden = true
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.inccommand = 'split'
vim.opt.laststatus = 2
vim.opt.path:append { '**' } -- find files recursively
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.shell = 'zsh'
vim.opt.shiftwidth = 4
vim.opt.showcmd = true
vim.opt.si = true -- Smart indent
vim.opt.smarttab = true
vim.opt.tabstop = 4
vim.opt.title = true
vim.opt.wrap = false
vim.opt.clipboard = "unnamed"
vim.opt.updatetime=50
vim.opt.redrawtime=1000

vim.cmd [[colorscheme tokyonight]]
