require('telescope').setup {
        defaults = {
                prompt_prefix = " ",
                selection_caret = " ",
                path_display = { "smart" },
        }
}

require('telescope').load_extension "file_browser"

local M = {}
M.project_files = function()
    local opts = {}
    local ok   = pcall(require("telescope.builtin").git_files, opts)
    if not ok then require("telescope.builtin").find_files(opts) end
end
return M
