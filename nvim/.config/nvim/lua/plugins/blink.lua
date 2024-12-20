return {
	"saghen/blink.cmp",
	opts = {
		appearance = {
			nerd_font_variant = "mono",
		},
		sources = {
			completion = {
				enabled_providers = { "lsp", "path", "snippets", "buffer", "Codeium" },
			},
		},
		completion = {
			trigger = {
				show_on_insert_on_trigger_character = false,
			},
			menu = {
				border = {
					{ "󱐋", "WarningMsg" },
					{ "─", "Comment" },
					{ "╮", "Comment" },
					{ "│", "Comment" },
					{ "╯", "Comment" },
					{ "─", "Comment" },
					{ "╰", "Comment" },
					{ "│", "Comment" },
				},
				scrollbar = false,
				winblend = 0,
			},
			documentation = {
				window = {
					border = {
						{ "󰙎", "DiagnosticHint" },
						{ "─", "Comment" },
						{ "╮", "Comment" },
						{ "│", "Comment" },
						{ "╯", "Comment" },
						{ "─", "Comment" },
						{ "╰", "Comment" },
						{ "│", "Comment" },
					},
				},
				scrollbar = false,
				winblend = 0,
				ghost_text = {
					enable = true,
				},
			},
			signatrue = {
				enabled = true,
			},
		},
	},
}
