return {
	"rebelot/kanagawa.nvim",
	build = ":KanagawaCompile",
	enabled = true,
	lazy = false,
	opts = {
		compile = true,
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
			local theme = colors.theme
			local makeDiagnosticColor = function(color)
				local c = require("kanagawa.lib.color")
				return { fg = color, bg = c(color):blend(theme.ui.bg, 0.95):to_hex() }
			end

			return {
				DiagnosticVirtualTextHint = makeDiagnosticColor(theme.diag.hint),
				DiagnosticVirtualTextInfo = makeDiagnosticColor(theme.diag.info),
				DiagnosticVirtualTextWarn = makeDiagnosticColor(theme.diag.warning),
				DiagnosticVirtualTextError = makeDiagnosticColor(theme.diag.error),

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
