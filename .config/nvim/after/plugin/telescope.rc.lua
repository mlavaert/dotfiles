local status, telescope = pcall(require, "telescope")
if not status then
	return
end

local builtin = require("telescope.builtin")

telescope.setup({
	tabline = {
		lualine_a = { "buffers" },
		lualine_c = { "filename" },
	},
})

-- Enable Telescope fzf native, if installed
pcall(require("telescope").load_extension, "fzf")

local file_finder = function() -- Find files in Git repository or fallback to current directory
	vim.fn.system('git rev-parse --is-inside-work-tree')
	if vim.v.shell_error == 0 then
		builtin.git_files()
	else
		builtin.find_files()
	end
end

vim.keymap.set("n", "<leader>sp", function()
	builtin.grep_string({ search = vim.fn.input("Grep for > ") })
end)

vim.keymap.set("n", "<leader><space>", file_finder, { desc = "[F]ind [F]iles" })
vim.keymap.set("n", "<leader>fs", builtin.treesitter, { desc = "Find keywords and objects using Treesitter" })
vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "[F]ind [R]ecent files" })
vim.keymap.set("n", "<leader>/", builtin.live_grep, { desc = "[/] Find by using grep" })
vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "[F]ind [D]iagnostics" })
vim.keymap.set("n", "<leader>,", builtin.buffers, { desc = "Find exsting buffers" })
