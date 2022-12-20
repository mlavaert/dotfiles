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
