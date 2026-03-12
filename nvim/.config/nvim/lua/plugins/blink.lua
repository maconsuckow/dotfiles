return {
	"saghen/blink.cmp",
	dependencies = {
		"rafamadriz/friendly-snippets",
		"saghen/blink.nvim",
		"saghen/blink.compat",
		"hrsh7th/nvim-cmp",
	},
	version = "1.*",
	opts = {
		appearance = {
			nerd_font_variant = "mono",
			kind_icons = {
				Keyword = " ",
				Function = " ",
				Variable = " ",
				codecompanion = "",
				CodeCompanion = "",
			},
		},
		completion = {
			accept = {
				auto_brackets = {
					enabled = true,
				},
			},
			menu = {
				border = "rounded",
				winhighlight = "Normal:BlinkCmpSignatureHelp,FloatBorder:BlinkCmpSignatureHelpBorder",
				auto_show = true,
				scrollbar = false,
				draw = {
					treesitter = { "lsp" },
				},
			},
			documentation = {
				auto_show = true,
				window = {
					border = "rounded",
					winhighlight = "Normal:BlinkCmpSignatureHelp,FloatBorder:BlinkCmpSignatureHelpBorder",
				},
			},
			ghost_text = {
				enabled = vim.g.ai_cmp,
			},
		},
		sources = {
			default = { "codecompanion", "lsp", "path", "snippets", "buffer", "codecompanion" },
			per_filetype = {
				sql = { "lsp", "path", "snippets", "buffer", "dadbod" },
			},
			providers = {
				codecompanion = {
					name = "CodeCompanion",
					module = "codecompanion.providers.completion.blink",
					score_offset = 100,
				},
				dadbod = {
					name = "Dadbod",
					module = "vim_dadbod_completion.blink",
				},
			},
		},

		fuzzy = { implementation = "prefer_rust_with_warning" },
	},
	opts_extend = { "sources.default" },
}
