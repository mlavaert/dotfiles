Plug 'navarasu/onedark.nvim'

augroup OneDarkOverrides
    autocmd!
    autocmd User PlugLoaded ++nested colorscheme onedark
augroup end
