Plug 'joshdick/onedark.vim'

let g:onedark_terminal_italics = 1

augroup DraculaOverrides
    autocmd!
    autocmd User PlugLoaded ++nested colorscheme onedark
augroup end
