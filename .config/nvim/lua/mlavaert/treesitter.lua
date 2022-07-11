require'nvim-treesitter.configs'.setup {
        ensure_installed = {"python", "lua", "hcl", "make", "bash", "css", "html", "markdown", "json"},
        highlight = { enable = true, },
        indent = { enable = true, },
        autopairs = { enable = true, }
}
