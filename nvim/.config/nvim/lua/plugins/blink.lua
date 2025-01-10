return {
	{
		"saghen/blink.cmp",
		dependencies = { "codeium.nvim", "saghen/blink.compat" },
		opts = {
			appearance = {
				nerd_font_variant = "mono",
			},
			sources = {
				default = { "lsp", "codeium", "path", "snippets", "buffer", "dadbod" },
				compat = { "codeium" },
				providers = {
					-- codecompanion = {
					-- 	name = "CodeCompanion",
					-- 	module = "codecompanion.providers.completion.blink",
					-- },
					codeium = {
						kind = "Codeium",
						score_offset = 100,
						async = true,
					},
					dadbod = {
						name = "Dadbod",
						module = "vim_dadbod_completion.blink",
					},
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
					auto_show = true,
					scrollbar = false,
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
				},
			},
		},
	},
}
