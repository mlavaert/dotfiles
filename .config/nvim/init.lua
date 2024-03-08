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
  change_detection = { notify = false },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "netrwPlugin",
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
}

-- NOTE: Map leaders before loading plugins
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

-- [[ Buffers ]]
keymap.set("n", "H", ":bnext<cr>", { desc = "Next buffer" })
keymap.set("n", "L", ":bprev<cr>", { desc = "Previous buffer" })
keymap.set("n", "<leader>bd", ":bdelete<CR>", { desc = "Delete Buffer" })
keymap.set("n", "<leader>bD", ":bdelete!<CR>", { desc = "Delete Buffer (Force)" })
keymap.set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- [[ Diagnostics ]] --
keymap.set("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>")
keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>", { desc = "Jump to previous diagnostic" })
keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>", { desc = "Jump to next diagnostic" })

vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous Diagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next Diagnostic message" })
vim.keymap.set("n", "<leader>xe", vim.diagnostic.open_float, { desc = "Show diagnostic Error messages" })
vim.keymap.set("n", "<leader>xq", vim.diagnostic.setloclist, { desc = "Open diagnostic Quickfix list" })

-- [[ Better vertical navigation ]]
keymap.set("n", "<C-d>", "<C-d>zz")
keymap.set("n", "<C-u>", "<C-u>zz")

-- Move to window using the <ctrl> hjkl keys
keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to left window", remap = true })
keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to lower window", remap = true })
keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to upper window", remap = true })
keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to right window", remap = true })

-- better indenting
keymap.set("v", "<", "<gv")
keymap.set("v", ">", ">gv")

keymap.set("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })

-- quit
keymap.set("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit all" })

-- [[ Highlight on Yank ]]
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = "*",
})
