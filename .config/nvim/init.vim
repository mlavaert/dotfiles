call plug#begin('~/.vim/plugged')
Plug 'vim-airline/vim-airline'
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-commentary'
Plug 'jpalardy/vim-slime'
Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins' }
Plug 'deoplete-plugins/deoplete-jedi'
call plug#end()

let $FZF_DEFAULT_COMMAND = 'rg --files' 
let g:deoplete#enable_at_startup = 1

" keybinds
map <c-p> :Files<cr>
map <c-j> :Rg<cr>

set number
set relativenumber

