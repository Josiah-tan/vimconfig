require("tailwind-tools").setup(
	{
		document_color = {
			enabled = true,
			kind = "inline",
			inline_symbol = "◼︎ ", -- Example of a simpler symbol
			debounce = 200,
		},
		conceal = {
			enabled = false,
			min_length = nil,
			symbol = "◼︎ ", -- Example of a simpler symbol
			highlight = {
				fg = "#38BDF8",
			},
		},
		custom_filetypes = {}
	}
)
