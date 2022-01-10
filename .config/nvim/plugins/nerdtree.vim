Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'

let NERDTreeShowHidden=1
let NERDTreeMinimalUI=1



nnoremap <leader>n g:NERDTree.IsOpen() ? ':NERDTreeClose<CR>' : @% == '' ? ':NerdTree<CR>' : ':NERDTreeFind<CR>'
nnoremap <leader>N :NERDTreeFind<cr>
