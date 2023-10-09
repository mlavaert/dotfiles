return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    { "williamboman/mason.nvim", cmd = "Mason", config = true },
    { "folke/neodev.nvim", config = true },
    "williamboman/mason-lspconfig.nvim",
    "b0o/schemastore.nvim",
  },
  config = function()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
    -- Use an on_attach function to only map the following keys
    -- after the language server attaches to the current buffer
    local on_attach = function(_, bufnr)
      --Enable completion triggered by <c-x><c-o>
      --local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
      --buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

      local k = function(keys, func, desc)
        vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc, noremap = true, silent = true })
      end

      k("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")
      k("K", vim.lsp.buf.hover, "Hover Documentation")
      k("gd", vim.lsp.buf.definition, "Goto Definition")
      k("gr", vim.lsp.buf.references, "References")
      k("gD", vim.lsp.buf.declaration, "Goto Declaration")
      k("gT", vim.lsp.buf.type_definition, "Goto Type Definition")
      k("gi", vim.lsp.buf.implementation, "Goto Implementation")
      k("<leader>cr", vim.lsp.buf.rename, "Rename")
      k("<leader>cl", vim.lsp.codelens.run, "Code Lens")
      k("<leader>ca", vim.lsp.buf.code_action, "Code Action")
      k("<leader>cA", vim.lsp.buf.source_action, "Source Action")
    end

    local servers = {
      pyright = {},
      cmake = {},
      awk_ls = {},
      bashls = {},
      dockerls = {},
      terraformls = {},
      yamlls = {
        yaml = {
          schemaStore = {
            enable = false,
            url = "",
          },
          schemas = require("schemastore").yaml.schemas(),
        },
      },
      jsonls = {
        json = {
          schemas = require("schemastore").json.schemas(),
          validate = { enable = true },
        },
      },
    }

    local mason_lspconfig = require("mason-lspconfig")

    mason_lspconfig.setup({
      ensure_installed = vim.tbl_keys(servers),
    })

    mason_lspconfig.setup_handlers({
      function(server)
        require("lspconfig")[server].setup({
          on_attach = on_attach,
          capabilities = capabilities,
          settings = servers[server],
        })
      end,
    })
  end,
}
