return {
  {
    "folke/tokyonight.nvim",
    opts = { style = "storm" },
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("tokyonight")
    end,
  },
  { "aktersnurra/no-clown-fiesta.nvim" },
  { "shaunsingh/nord.nvim" },
}
