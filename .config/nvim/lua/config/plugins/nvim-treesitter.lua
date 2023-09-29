return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPost", "BufNewFile" },
  build = ":TSUpdate",
  opts = {
    ensure_installed = {
      "bash",
      "hcl",
      "json",
      "make",
      "markdown",
      "python",
      "scala",
      "sql",
      "terraform",
    },
    highlight = { enable = true },
    indent = { enable = true, disable = { "python" } },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<c-space>",
        node_incremental = "<c-space>",
        scope_incremental = "<c-s>",
        node_decremental = "<c-backspace>",
      },
    },
  },
}
