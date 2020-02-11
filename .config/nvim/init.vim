call plug#begin('~/.vim/plugged')
Plug 'vim-airline/vim-airline'
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-commentary'
call plug#end()

let $FZF_DEFAULT_COMMAND = 'rg --files' 

" keybinds
map <c-p> :Files<cr>
map <c-j> :Rg<cr>
