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
		setup = {
			default = "blink",
		},

		keymap = { preset = "default" },

		appearance = {
			nerd_font_variant = "mono",
			kind_icons = {
				Keyword = " ",
				Function = " ",
				Variable = " ",
				Snippet = " ",
				Codeium = " ",
				codeium = " ",
				Windsurf = " ",
				windsurf = " ",
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
			default = { "lsp", "path", "snippets", "buffer", "codeium" },
			per_filetype = {
				sql = { "dadbod" },
			},
			compat = { "codeium" },
			providers = {
				dadbod = {
					name = "Dadbod",
					module = "vim_dadbod_completion.blink",
				},
				codeium = {
					kind = "Codeium",
					name = "Codeium",
					module = "codeium.blink",
					async = true,
				},
			},
		},

		fuzzy = { implementation = "prefer_rust_with_warning" },
	},
	opts_extend = { "sources.default" },
}
