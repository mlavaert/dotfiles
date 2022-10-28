local keymap = vim.keymap

vim.g.mapleader = ' '

keymap.set('n', '<leader>ve', ":edit ${XDG_CONFIG_HOME}/nvim/init.lua<CR>")
keymap.set('n', '<leader>vr', ":source ${XDG_CONFIG_HOME}/nvim/init.lua<CR>")

keymap.set('n', '<leader>pd', ":Lex 25<CR>")

-- Buffers
keymap.set('n', ']b', ":bnext<CR>")
keymap.set('n', ']b', ":bprev<CR>")
