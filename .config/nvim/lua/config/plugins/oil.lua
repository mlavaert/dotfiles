return {
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    { "-", "<cmd>Oil<cr>", desc = "Oil" },
  },
  config = true,
  opts = {
    view_options = { show_hidden = true },
  },
}
