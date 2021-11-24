Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'


function! s:goyo_enter()
  set wrap
  set linebreak
  Limelight
endfunction

function! s:goyo_leave()
  set nowrap
  Limelight!
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

nnoremap <leader>tf :Goyo<cr>
