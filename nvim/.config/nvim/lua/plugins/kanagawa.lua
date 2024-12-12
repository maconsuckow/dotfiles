return {
	"rebelot/kanagawa.nvim",
	enabled = true,
	compile = true,
	lazy = false,
	build = "KanagawaCompile",
	opts = {
		transparent = true,
		commentStyle = { italic = true },
		theme = "dragon",
		colors = {
			theme = {
				all = {
					ui = {
						bg_gutter = "none",
					},
				},
			},
		},
		overrides = function(colors)
			return {
				NormalFloat = { bg = "none" },
				FloatBorder = { bg = "none" },
				FloatTitle = { bg = "none" },
				CursorLineNr = { fg = "none" },
			}
		end,
	},
}
