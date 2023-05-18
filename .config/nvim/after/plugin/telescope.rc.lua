local status, telescope = pcall(require, "telescope")
if not status then
	return
end

local builtin = require("telescope.builtin")

telescope.setup({
	defaults = {
		mappings = {
			i = {
				["<C-u>"] = false,
				["<C-d>"] = false,
			},
		},
	},
})

-- Enable Telescope fzf native, if installed
pcall(require("telescope").load_extension, "fzf")

vim.keymap.set("n", "<leader>sp", function()
	builtin.grep_string({ search = vim.fn.input("Grep for > ") })
end)

vim.keymap.set("n", "<leader><space>", builtin.find_files, { desc = "[F]ind [F]iles" })
vim.keymap.set("n", "<leader>fs", builtin.treesitter, { desc = "Find keywords and objects using Treesitter" })
vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "[F]ind [R]ecent files" })
vim.keymap.set("n", "<leader>/", builtin.live_grep, { desc = "[/] Find by using grep" })
vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "[F]ind [D]iagnostics" })
vim.keymap.set("n", "<leader>,", builtin.buffers, { desc = "Find exsting buffers" })

-- vim: ts=4 sts=4 sw=4:
