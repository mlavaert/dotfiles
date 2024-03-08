return {
  "folke/todo-comments.nvim",
  cmd = { "TodoTrouble", "TodoTelescope" },
  event = { "BufReadPost", "BufNewFile" },
  dependencies = "nvim-lua/plenary.nvim",
  config = true,
  keys = {
    { "<leader>sT", "<cmd>TodoTelescope<cr>", desc = "Todo" },
    { "<leader>s", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme" },
  },
}
