Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'nvim-treesitter/playground'

function TreesitterSetup()

lua << EOF
require'nvim-treesitter.configs'.setup {
	ensure_installed = {"python", "typescript", "bash", "json", "hcl", "go"},
	highlight = {
		enable = true,
	},
	indent = {
		enable = true,
	},
}
EOF
endfunction


augroup TreesitterSetup
  autocmd!
  autocmd User PlugLoaded call TreesitterSetup()
augroup end

