require('telescope').setup {
        defaults = {
                prompt_prefix = " ",
                selection_caret = " ",
                path_display = { "smart" },
        }
}

require('telescope').load_extension "file_browser"
