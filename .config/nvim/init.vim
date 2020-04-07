call plug#begin('~/.vim/plugged')
Plug 'vim-airline/vim-airline'

Plug 'junegunn/fzf.vim'

Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-apathy'

Plug 'jpalardy/vim-slime'
call plug#end()

let $FZF_DEFAULT_COMMAND = 'rg --files' 

" keybinds
map <Space><Space> :GFiles<cr>
map <Space>, :Buffers<cr>

set number
set relativenumber

