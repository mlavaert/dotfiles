local status, nvim_lsp = pcall(require, "lspconfig")
if (not status) then return end

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    --Enable completion triggered by <c-x><c-o>
    --local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
    --buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    local opts = { noremap = true, silent = true, buffer = true }

    vim.keymap.set('i', 'C-k', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gT', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<leader>f', vim.lsp.buf.format, opts)
    vim.keymap.set('n', '<leader>cr', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<leader>cl', vim.lsp.codelens.run, opts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)

    vim.keymap.set('n', '<leader>dj', vim.diagnostic.goto_next, opts)
    vim.keymap.set('n', '<leader>dk', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', '<leader>df', '<cmd>Telescope diagnostics<cr>', opts)
end

-- Set up completion using nvim_cmp with LSP source
local capabilities = require('cmp_nvim_lsp').default_capabilities()

nvim_lsp.pyright.setup {
    on_attach = on_attach,
    capabilities = capabilities
}

nvim_lsp.bashls.setup {
    on_attach = on_attach,
    capabilities = capabilities
}

nvim_lsp.terraformls.setup {
    on_attach = on_attach,
    capabilities = capabilities
}

nvim_lsp.sumneko_lua.setup {
    capabilities = capabilities,
    on_attach = function(client, bufnr)
        on_attach(client, bufnr)
    end,
    settings = {
        Lua = {
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { 'vim' },
            },

            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false
            },
        },
    },
}


-- Scala configuration is a bit more complicated.
local metals = require("metals")
local metals_conf = metals.bare_config()

metals_conf.settings = {
    showImplicitArguments = true,
}

metals_conf.on_atach = function(client, bufnr)
    on_attach(client, bufnr)
    metals.setup_dap()
end

-- Autocmd that will actually be in charging of starting the whole thing
local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
    -- NOTE: You may or may not want java included here. You will need it if you
    -- want basic Java support but it may also conflict if you are using
    -- something like nvim-jdtls which also works on a java filetype autocmd.
    pattern = { "scala", "sbt" },
    callback = function()
        metals.initialize_or_attach(metals_conf)
    end,
    group = nvim_metals_group,
})
