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

vim.keymap.set('n', '<leader><leader>', builtin.find_files)
vim.keymap.set('n', '<leader>ff', builtin.treesitter)
vim.keymap.set('n', '<leader>fr', builtin.oldfiles)
vim.keymap.set('n', '<leader>,', builtin.buffers )
