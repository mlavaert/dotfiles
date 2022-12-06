local keymap = vim.keymap

vim.g.mapleader = ' '

keymap.set('n', '<leader>cf', ":Neoformat<CR>", { desc = "Format the file using Neoformat" })

keymap.set('n', '<leader>ve', ":edit ${XDG_CONFIG_HOME}/nvim/init.lua<CR>", { desc = "Open Neovim Config" })
keymap.set('n', '<leader>vr', ":luafile %<CR>", { desc = "Reload Lua config file" })

keymap.set('n', '<leader>pd', ":Lex 25<CR>", { desc = "Open project drawer" })

-- Buffers
keymap.set('n', ']b', ":bnext<CR>", { desc = "Next buffer" })
keymap.set('n', '[b', ":bprev<CR>", { desc = "Previous buffer" })
keymap.set('n', '<leader>bk', ":bdelete!<CR>", { desc = "Kill current buffer" })

-- Better vertical navigation
keymap.set('n', '<C-d>', '<C-d>zz')
keymap.set('n', '<C-u>', '<C-u>zz')
