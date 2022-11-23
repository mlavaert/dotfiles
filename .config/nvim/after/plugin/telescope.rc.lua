local status, telescope = pcall(require, "telescope")
if (not status) then return end

local builtin = require("telescope.builtin")

telescope.setup {
    tabline = {
        lualine_a = { "buffers" },
        lualine_c = { 'filename' }
    }
}

vim.keymap.set('n', '<leader>sp', function()
    builtin.grep_string({ search = vim.fn.input("Grep for > ") })
end
)

vim.keymap.set('n', '<leader>.', builtin.find_files, { desc = "Find files in current directory" })
vim.keymap.set('n', '<leader>ff', builtin.git_files, { desc = "Find files in current Git project" })
vim.keymap.set('n', '<leader>fs', builtin.treesitter, { desc = "Find keywords and objects using Treesitter" })
vim.keymap.set('n', '<leader>fr', builtin.oldfiles, { desc = "Find recent files" })
vim.keymap.set('n', '<leader>,', builtin.buffers, { desc = "Find buffer" })
