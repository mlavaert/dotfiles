" General settings
let mapleader = "," 

set encoding=utf-8
set number relativenumber 	" display line numbers
set noswapfile nobackup nowritebackup		" No swap and backupfiles
set hidden			" TextEdit might fail if hidden is not set
set scrolloff=8
set cmdheight=2 " Give more space for displaying messages.
set updatetime=300
set shortmess+=c " Don't pass messages to |ins-completion-menu|.
set signcolumn=yes
set clipboard=unnamed

" {{ Plugins }} "
if ! filereadable(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim"'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim
	autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.config/nvim/plugged')
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-commentary'

Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'itchyny/lightline.vim'

Plug 'vimwiki/vimwiki'
Plug 'plasticboy/vim-markdown'
call plug#end()

" Focus mode
  let g:limelight_conceal_ctermfg = 'gray' 
  let g:limelight_conceal_ctermfg = 240
  autocmd! User GoyoEnter Limelight
  autocmd! User GoyoLeave Limelight!  
  map <leader>tf :Goyo<CR>

" Vim wiki
  let g:vimwiki_list = [{'path': '~/vimwiki', 'syntax': 'markdown', 'ext': '.md'}]
  let g:vimwiki_markdown_link_ext = 1
