Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'

autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!


let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_ctermfg = 240

nnoremap <leader>tf :Goyo<cr>

