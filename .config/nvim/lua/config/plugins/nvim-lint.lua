return {
  "mfussenegger/nvim-lint",
  event = { "VeryLazy", "BufReadPost", "BufNewFile", "BufWritePre" },
  config = function()
    require("lint").linters_by_ft = {
      dockerfile = { "hadolint" },
      markdown = { "markdownlint" },
      python = { "ruff", "vulture" },
      sh = { "shellcheck" },
      sql = { "sqlfluff" },
      terraform = { "terraform_validate" },
      tf = { "terraform_validate" },
    }

    vim.api.nvim_create_autocmd({ "BufWritePost" }, {
      callback = function()
        require("lint").try_lint()
      end,
    })
  end,
}
