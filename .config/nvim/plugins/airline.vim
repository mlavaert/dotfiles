Plug 'nvim-lualine/lualine.nvim'

function LualineSetup()
lua << EOF
require('lualine').setup {
        tabline = {
          lualine_a = {'buffers'},
          lualine_b = {},
          lualine_c = {'filename'},
          lualine_x = {},
          lualine_y = {},
          lualine_z = {}
        }
}
EOF
endfunction

augroup LualineSetup
  autocmd!
  autocmd User PlugLoaded call LualineSetup()
augroup end
