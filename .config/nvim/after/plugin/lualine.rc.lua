local status, lualine = pcall(require, "lualine")
if not status then
	return
end

lualine.setup({
	options = {
		theme = "catppuccin",
	},
	tabline = {
		lualine_a = { "buffers" },
		lualine_c = { "filename" },
	},
})
