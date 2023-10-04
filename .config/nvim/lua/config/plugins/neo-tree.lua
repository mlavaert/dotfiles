return {
  "nvim-neo-tree/neo-tree.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  cmd = "Neotree",
  keys = {
    {
      "<leader>fe",
      function()
        require("neo-tree.command").execute({ toggle = true })
      end,
      desc = "File Explorer",
    },
  },
  deactivate = function()
    vim.cmd([[Neotree close]])
  end,
  opts = {
    filesystem = {
      follow_current_file = { enabled = true },
    },
  },
}
