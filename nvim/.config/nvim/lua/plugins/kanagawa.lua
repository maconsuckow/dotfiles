return {
	"rebelot/kanagawa.nvim",
	build = ":KanagawaBuild",
	enabled = true,
	lazy = false,
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
				StatusLine = { bg = "none" },
				StatusLineNC = { bg = "none" },

				BlinkCmpMenu = { bg = "none" },

				Pmenu = { fg = colors.theme.ui.shade0, bg = colors.theme.ui.bg_p1 }, -- add `blend = vim.o.pumblend` to enable transparency
				PmenuSel = { fg = "NONE", bg = colors.theme.ui.bg_p2 },
				PmenuSbar = { bg = colors.theme.ui.bg_m1 },
				PmenuThumb = { bg = colors.theme.ui.bg_p2 },
			}
		end,
	},
}
