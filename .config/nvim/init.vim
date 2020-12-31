"Rational {{ General Settings }} "
set path+=**			" searches current directory recursively
set number relativenumber 	" display line numbers
set noswapfile nobackup nowritebackup		" No swap and backupfiles
set hidden			" TextEdit might fail if hidden is not set
syntax enable


" {{ Plugins }} "
call plug#begin('~/.vim/plugged')

" Colors
Plug 'itchyny/lightline.vim'
Plug 'flazz/vim-colorschemes'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-commentary'
call plug#end()

" {{ Navigation }} "
let $FZF_DEFAULT_COMMAND = 'rg --files --no-ignore-vcs --hidden'
nnoremap <C-p> :Files<CR>
nnoremap <C-f> :Rg<CR>
nnoremap <Space><Space> :Buffers<CR>
