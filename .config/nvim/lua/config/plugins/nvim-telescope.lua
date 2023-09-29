return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
    },
  },
  keys = {
    {
      "<leader>sp",
      function()
        require("telescope.builtin").grep_string({ search = vim.fn.input("Grep for > ") })
      end,
      desc = "[S]earch [P]roject",
    },
    {
      "<leader><space>",
      function()
        require("telescope.builtin").find_files()
      end,
      desc = "[F]ind [F]iles",
    },
    { "<leader>fr", require("telescope.builtin").oldfiles, desc = "[F]ind [R]ecent files" },
    { "<leader>/", require("telescope.builtin").live_grep, desc = "[/] Find by using grep" },
    { "<leader>fd", require("telescope.builtin").diagnostics, desc = "[F]ind [D]iagnostics" },
    { "<leader>,", require("telescope.builtin").buffers, desc = "Find exsting buffers" },
  },
  config = function()
    local telescope = require("telescope")

    telescope.setup({
      defaults = {
        mappings = {
          i = {
            ["<C-u>"] = false,
            ["<C-d>"] = false,
          },
        },
      },
    })
    telescope.load_extension("fzf")
  end,
}
