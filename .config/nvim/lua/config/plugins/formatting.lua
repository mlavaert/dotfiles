return {
  "mhartington/formatter.nvim",
  opts = {
    filetype = {
      lua = require("formatter.filetypes.lua").stylua,
      python = require("formatter.filetypes.python").black,
      sh = require("formatter.filetypes.sh").shfmt,
      sql = function()
        local util = require("formatter.util")
        return {
          exe = "sqlfluff",
          args = {
            "format",
            util.escape_path(util.get_current_buffer_file_path()),
          },
        }
      end,
      terraform = require("formatter.filetypes.terraform").terraformfmt,
      yaml = require("formatter.filetypes.yaml").yamlfmt,
      ["*"] = require("formatter.filetypes.any").remove_trailing_whitespace,
    },
  },
  keys = {
    { "<leader>cf", ":Format<CR>", desc = "[C]ode [F]ormat" },
  },
}
