"--------------------------------------------------------------------------
" General settings
"--------------------------------------------------------------------------
set completeopt=menu,menuone,noselect
set expandtab
set termguicolors
set hidden
set signcolumn=yes
set number
set relativenumber
set undofile
set undodir=${XDG_CACHE_HOME}/nvim/undodir
set ignorecase
set smartcase
set wildmode=longest:full,full
set nowrap
set list
set listchars=tab:▸\ ,trail:·
set mouse=a
set scrolloff=8
set sidescrolloff=8
set shiftwidth=4
set tabstop=4
set splitright                  " force horizontal splits to go below current
set splitbelow                  " force vertical splits to go right of current
set clipboard=unnamedplus
set backup
set backupdir=${XDG_CACHE_HOME}/nvim/backupdir
set colorcolumn=80
set updatetime=300
set redrawtime=10000
set cmdheight=2
set shortmess+=c
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
" LSP
Plug 'neovim/nvim-lspconfig'           "enable lsp
Plug 'williamboman/nvim-lsp-installer' "simple language server installer

" cmp
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

Plug 'onsails/lspkind-nvim'
Plug 'sbdchd/neoformat'

" snippets
Plug 'L3MON4D3/LuaSnip'
Plug 'rafamadriz/friendly-snippets'

" Telescope
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-file-browser.nvim'
Plug 'kyazdani42/nvim-web-devicons'

" Treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'nvim-treesitter/playground'

" Lualine
Plug 'nvim-lualine/lualine.nvim'

" Git
Plug 'tpope/vim-fugitive'

Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'justinmk/vim-sneak'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'

Plug 'gruvbox-community/gruvbox'

call plug#end()

lua << EOF
require('mlavaert.cmp')
require('mlavaert.lsp')
require('mlavaert.telescope')
require('mlavaert.treesitter')
require('mlavaert.lualine')
EOF


"--------------------------------------------------------------------------
" Key maps
"--------------------------------------------------------------------------
let mapleader = "\<space>"

nnoremap <leader>e  :Lex 30<cr>
nnoremap <leader>ve :edit   ${XDG_CONFIG_HOME}/nvim/init.vim<cr>
nnoremap <leader>vr :source ${XDG_CONFIG_HOME}/nvim/init.vim<cr>

" stay in visual mode
vnoremap < <gv 
vnoremap > >gv

" keeping it centered
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z

nnoremap <leader>bs :write<cr>
nnoremap <leader>bk :bdelete<cr>

nnoremap <leader>sp :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep for > ") })<CR>
nnoremap <leader>ff :lua require('telescope.builtin').git_files()<CR>
nnoremap <leader><leader> :lua require('telescope.builtin').git_files()<CR>
nnoremap <leader>fF :lua require('telescope.builtin').find_files()<CR>
nnoremap <leader>fr :lua require('telescope.builtin').oldfiles()<CR>
nnoremap <leader>vh :lua require('telescope.builtin').help_tags()<CR>
nnoremap <leader>, :lua require('telescope.builtin').buffers()<CR>
nnoremap <leader>. :lua require('telescope').extensions.file_browser.file_browser({ cwd = require('telescope.utils').buffer_dir() })<CR>

"--------------------------------------------------------------------------
" Visual
"--------------------------------------------------------------------------
colorscheme gruvbox


"--------------------------------------------------------------------------
" Configuration
"--------------------------------------------------------------------------

function! s:goyo_enter()
    set noshowmode
    set noshowcmd
    set wrap
    set linebreak
    set scrolloff=999
    Limelight
endfunction

function! s:goyo_leave()
    set showmode
    set showcmd
    set scrolloff=8
    set nowrap
    Limelight!
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()
