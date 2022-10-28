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

vim.keymap.set('n', '<leader><leader>', function() builtin.find_files() end)
vim.keymap.set('n', '<leader>ff', function() builtin.treesitter() end)
vim.keymap.set('n', '<leader>fr', function() builtin.oldfiles() end)
vim.keymap.set('n', '<leader>,', function() builtin.buffers() end)
