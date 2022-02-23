require('lualine').setup {
    options = {
        theme = 'everforest'
    },
    tabline = {
      lualine_a = {'buffers'},
      lualine_b = {},
      lualine_c = {'filename'},
      lualine_x = {},
      lualine_y = {},
      lualine_z = {}
    }
}
