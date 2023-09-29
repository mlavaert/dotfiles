return {
  -- Highlight TODO comments
  {
    "folke/todo-comments.nvim",
    event = "VeryLazy",
    dependencies = "nvim-lua/plenary.nvim",
    config = true,
  },
  { "stevearc/dressing.nvim", config = true },
  { "tpope/vim-fugitive", cmd = "Git" },
  { "lewis6991/gitsigns.nvim", event = "VeryLazy", config = true },
  { "numToStr/Comment.nvim", event = "VeryLazy", config = true },

  "tpope/vim-vinegar",
  "tpope/vim-sleuth",
}
