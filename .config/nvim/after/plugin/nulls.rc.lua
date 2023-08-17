local null_ls = require("null-ls")

null_ls.setup({
	sources = {
		null_ls.builtins.code_actions.gitsigns,
		null_ls.builtins.code_actions.shellcheck,
		null_ls.builtins.formatting.black,
		null_ls.builtins.formatting.shfmt,
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.yamlfmt,
	},
})

-- vim: ts=4 sts=4 sw=4:
