return {
  "stevearc/oil.nvim",
  keys = {
    { "-", "<cmd>Oil<cr>", desc = "Oil" },
  },
  config = true,
  opts = {
    view_options = {
      natural_order = true,
      show_hidden = true,
      skip_confirm_for_simple_edits = true,
      is_always_hidden = function(name, _)
        return name == ".." or name == ".git"
      end,
    },
  },
}
