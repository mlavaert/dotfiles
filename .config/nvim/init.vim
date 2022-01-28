"--------------------------------------------------------------------------
" General settings
"--------------------------------------------------------------------------
set expandtab
set termguicolors
set hidden
set signcolumn=yes:2
set number
set relativenumber
set undofile
set undodir=${XDG_CACHE_HOME}/nvim/undodir
set title
set ignorecase
set smartcase
set wildmode=longest:full,full
set nowrap
set list
set listchars=tab:▸\ ,trail:·
set mouse=a
set scrolloff=8
set sidescrolloff=8
set nojoinspaces
set splitright
set clipboard=unnamedplus
set exrc
set backup
set backupdir=${XDG_CACHE_HOME}/nvim/backupdir
set colorcolumn=80
set updatetime=300
set redrawtime=10000

"--------------------------------------------------------------------------
" Key maps
"--------------------------------------------------------------------------
let mapleader = "\<space>"

nnoremap <leader>ve :edit   ${XDG_CONFIG_HOME}/nvim/init.vim<cr>
nnoremap <leader>vr :source ${XDG_CONFIG_HOME}/nvim/init.vim<cr>

nnoremap <leader>bs :write<cr>
nnoremap <leader>bk :bdelete<cr>

" Allow gf to open non-existing files
map gf :edit <cfile><cr>

"--------------------------------------------------------------------------
" Plugins
"--------------------------------------------------------------------------
if ! filereadable(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim"'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim
	autocmd VimEnter * PlugInstall --sync
endif

call plug#begin('~/.config/nvim/plugged')

source $XDG_CONFIG_HOME/nvim/plugins/airline.vim
source $XDG_CONFIG_HOME/nvim/plugins/auto-pairs.vim
source $XDG_CONFIG_HOME/nvim/plugins/coc.vim
source $XDG_CONFIG_HOME/nvim/plugins/onedark.vim
source $XDG_CONFIG_HOME/nvim/plugins/telescope.vim
source $XDG_CONFIG_HOME/nvim/plugins/treesitter.vim
source $XDG_CONFIG_HOME/nvim/plugins/vim-commentary.vim
source $XDG_CONFIG_HOME/nvim/plugins/vim-eunuch.vim
source $XDG_CONFIG_HOME/nvim/plugins/vim-repeat.vim
source $XDG_CONFIG_HOME/nvim/plugins/vim-surround.vim
source $XDG_CONFIG_HOME/nvim/plugins/vim-sneak.vim

call plug#end()
doautocmd User PlugLoaded
