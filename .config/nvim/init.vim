" General settings
let mapleader = "," 

set hidden 	" Allows you to change buffers even if the current one has unsaved changes
set smartindent " Intuitive indentatio of new lines when creating them
set noswapfile nobackup nowritebackup 
set undodir=${XDG_CACHE_HOME}/nvim/undodir
set undofile

set number relativenumber 	" display line numbers
set scrolloff=8
set clipboard=unnamed

-" {{ Plugins }} "
if ! filereadable(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim"'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim
	autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.config/nvim/plugged')
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-sleuth'
  Plug 'tpope/vim-commentary'
  Plug 'justinmk/vim-sneak'

  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'

  Plug 'neoclide/coc.nvim', {'branch':'release'}

  Plug 'junegunn/goyo.vim'
  Plug 'junegunn/limelight.vim'

  Plug 'plasticboy/vim-markdown'

  Plug 'itchyny/lightline.vim'
  Plug 'ryanoasis/vim-devicons'
call plug#end()

" Focus mode
  let g:limelight_conceal_ctermfg = 'gray' 
  let g:limelight_conceal_ctermfg = 240
  autocmd! User GoyoEnter Limelight
  autocmd! User GoyoLeave Limelight!  
  map <leader>tf :Goyo<CR>

" FZF
  let g:fzf_buffers_jump = 1
  nmap <C-P> :Files<CR>
  nmap <leader><leader> :GFiles<CR>

" Completion
runtime coc.vim

