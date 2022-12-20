local null_ls = require("null-ls")

null_ls.setup({
	sources = {
		-- Formatting
		null_ls.builtins.formatting.black,
		null_ls.builtins.formatting.usort,
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.shfmt,
		null_ls.builtins.formatting.yamlfmt,

		null_ls.builtins.diagnostics.write_good,

		-- Code Actions
		null_ls.builtins.code_actions.gitsigns,
		null_ls.builtins.code_actions.shellcheck,
	},
})
