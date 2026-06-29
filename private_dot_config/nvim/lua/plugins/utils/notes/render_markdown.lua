require("render-markdown").setup({
	render_modes = { "n", "c", "t" },
	file_types = { "markdown" },

	anti_conceal = {
		enabled = false,
	},

	completions = { lsp = { enabled = true } },
})
