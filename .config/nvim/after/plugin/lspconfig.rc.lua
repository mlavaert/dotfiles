local opts = { noremap = true, silent = true }
vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts)

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(_, bufnr)
	--Enable completion triggered by <c-x><c-o>
	--local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
	--buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

	local k = function(keys, func, desc)
		if desc then
			desc = "LSP: " .. desc
		end
		vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc, noremap = true, silent = true })
	end

	k("C-k", vim.lsp.buf.signature_help, "Signature Documentation")
	k("K", vim.lsp.buf.hover, "Hover Documentation")
	k("gd", vim.lsp.buf.definition, "[G]o [D]efinition")
	k("gr", vim.lsp.buf.references, "[G]o [R]eferences")
	k("gD", vim.lsp.buf.declaration, "[G]o [D]eclaration")
	k("gT", vim.lsp.buf.type_definition, "[G]o [T]ype Definition")
	k("gi", vim.lsp.buf.implementation, "[G]o [I]mplementation")
	k("<leader>cf", vim.lsp.buf.format, "[C]ode [F]ormat")
	k("<leader>cr", vim.lsp.buf.rename, "[C]ode [R]ename")
	k("<leader>cl", vim.lsp.codelens.run, "[C]ode [L]ens Run")
	k("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
end

require("neodev").setup()
require("mason").setup()

local servers = {
	pyright = {},
	ruff_lsp = {},
	awk_ls = {},
	bashls = {},
	dockerls = {},
	terraformls = {},
	yamlls = {},
	lua_ls = {
		Lua = {
			workspace = { checkThirdParty = false },
			telemetry = { enable = false },
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
