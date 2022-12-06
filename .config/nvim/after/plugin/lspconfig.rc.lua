local status, lspconfig = pcall(require, "lspconfig")
if (not status) then return end

local k = vim.keymap.set
local opts = { noremap = true, silent = true }

k('n', '[d', vim.diagnostic.goto_next, opts)
k('n', ']d', vim.diagnostic.goto_prev, opts)
k('n', '<leader>e', ':Telescope diagnostics<cr>', opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(_, bufnr)
        --Enable completion triggered by <c-x><c-o>
        --local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
        --buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
        vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

        -- Mappings.
        local bopts = { noremap = true, silent = true, buffer = bufnr }

        k('i', 'C-k', vim.lsp.buf.signature_help, bopts)
        k('n', 'K', vim.lsp.buf.hover, bopts)
        k('n', 'gd', vim.lsp.buf.definition, bopts)
        k('n', 'gr', vim.lsp.buf.references, bopts)
        k('n', 'gD', vim.lsp.buf.declaration, bopts)
        k('n', 'gT', vim.lsp.buf.type_definition, bopts)
        k('n', 'gi', vim.lsp.buf.implementation, bopts)
        k('n', '<leader>cf', vim.lsp.buf.format, bopts)
        k('n', '<leader>cr', vim.lsp.buf.rename, bopts)
        k('n', '<leader>cl', vim.lsp.codelens.run, bopts)
        k('n', '<leader>ca', vim.lsp.buf.code_action, bopts)
end

lspconfig["pyright"].setup { on_attach = on_attach }
lspconfig["awk_ls"].setup { on_attach = on_attach }
lspconfig["bashls"].setup { on_attach = on_attach }
lspconfig["terraformls"].setup { on_attach = on_attach }
lspconfig["sumneko_lua"].setup {
        on_attach = on_attach,
        settings = {
                Lua = {
                        diagnostics = { globals = { 'vim', 'require' } },
                        workspace = {
                                -- Make the server aware of Neovim runtime files
                                library = vim.api.nvim_get_runtime_file("", true),
                                checkThirdParty = false
                        },
                        telemetry = { enable = false }
                },
        },
}
