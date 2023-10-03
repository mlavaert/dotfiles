return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
    },
  },
  cmd = "Telescope",
  keys = {
    {
      "<leader><space>",
      function()
        local builtin = require("telescope.builtin")
        local opts = {} -- define here if you want to define something
        local is_inside_work_tree = {}

        local cwd = vim.fn.getcwd()
        if is_inside_work_tree[cwd] == nil then
          vim.fn.system("git rev-parse --is-inside-work-tree")
          is_inside_work_tree[cwd] = vim.v.shell_error == 0
        end

        if is_inside_work_tree[cwd] then
          builtin.git_files(opts)
        else
          builtin.find_files(opts)
        end
      end,
      desc = "Find Files",
    },

    { "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
    { "<leader>/", require("telescope.builtin").live_grep, desc = "Grep" },
    { "<leader>,", require("telescope.builtin").buffers, desc = "Buffers" },

    -- find
    { "<leader>fr", require("telescope.builtin").oldfiles, desc = "Find Recent Files" },
    { "<leader>fd", require("telescope.builtin").diagnostics, desc = "Find Diagnostics" },
    { "<leader>fb", require("telescope.builtin").buffers, desc = "Buffers" },

    -- git
    { "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "commits" },
    { "<leader>gs", "<cmd>Telescope git_status<CR>", desc = "status" },

    -- search
    { '<leader>s"', "<cmd>Telescope registers<cr>", desc = "Registers" },
    { "<leader>sa", "<cmd>Telescope autocommands<cr>", desc = "Auto Commands" },
    { "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
    { "<leader>sc", "<cmd>Telescope command_history<cr>", desc = "Command History" },
    { "<leader>sC", "<cmd>Telescope commands<cr>", desc = "Commands" },
    { "<leader>sd", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Document diagnostics" },
    { "<leader>sD", "<cmd>Telescope diagnostics<cr>", desc = "Workspace diagnostics" },
    { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
    { "<leader>sH", "<cmd>Telescope highlights<cr>", desc = "Search Highlight Groups" },
    { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
    { "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
    { "<leader>sm", "<cmd>Telescope marks<cr>", desc = "Jump to Mark" },
    { "<leader>so", "<cmd>Telescope vim_options<cr>", desc = "Options" },
    { "<leader>sR", "<cmd>Telescope resume<cr>", desc = "Resume" },

    -- TODO Include others from LazyVim
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
