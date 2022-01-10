Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'kyazdani42/nvim-web-devicons'

nnoremap <leader>ff <cmd>Telescope git_files<cr>
nnoremap <leader>fr <cmd>Telescope oldfiles<cr>
nnoremap <leader>fb <cmd>Telescope file_browser<cr>
nnoremap <leader><leader> <cmd>Telescope git_files<cr>
nnoremap <leader>, <cmd>Telescope buffers<cr>
nnoremap <leader>r <cmd>Telescope live_grep<cr>

