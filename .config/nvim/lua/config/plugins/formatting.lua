return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  keys = {
    {
      -- Customize or remove this keymap to your liking
      "<leader>cf",
      function()
        require("conform").format({ async = true, lsp_fallback = true })
      end,
      desc = "Format",
    },
  },
  -- Everything in opts will be passed to setup()
  opts = {
    -- Define your formatters
    formatters_by_ft = {
      sh = { "shfmt", "shellharden" },
      lua = { "stylua" },
      python = { "ruff_fix", "ruff_format" },
      terraform = { "terraform_fmt" },
      tf = { "terraform_fmt" },
      -- Use the "_" filetype to run formatters on filetypes that don't
      -- have other formatters configured.
      ["_"] = { "trim_whitespace", "trim_newlines" },
    },

    -- Set up format-on-save
    format_on_save = { timeout_ms = 500, lsp_fallback = true },
  },
  init = function()
    -- If you want the formatexpr, here is the place to set it
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
}
