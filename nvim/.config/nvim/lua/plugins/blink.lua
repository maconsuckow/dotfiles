return {
	{
		"saghen/blink.cmp",
		dependencies = { "Exafunction/codeium.nvim", "saghen/blink.compat" },
		opts = {
			sources = {
				-- default = { "lsp", "codeium", "path", "snippets", "buffer", "dadbod" },
				default = { "lsp", "path", "snippets", "buffer", "dadbod" },
				-- compat = { "codeium" },
				providers = {
					-- codeium = {
					-- 	name = "Codeium",
					-- 	module = "codeium.blink",
					-- 	async = true,
					-- },
					dadbod = {
						name = "Dadbod",
						module = "vim_dadbod_completion.blink",
					},
				},
			},
			signature = {
				enabled = true,
				window = {
					show_documentation = false,
				},
			},
			completion = {
				trigger = {
					show_on_insert_on_trigger_character = false,
				},
				menu = {
					border = "rounded",
					winhighlight = "Normal:BlinkCmpSignatureHelp,FloatBorder:BlinkCmpSignatureHelpBorder",
					auto_show = true,
					scrollbar = false,
				},
				documentation = {
					window = {
						border = "rounded",
					},
				},
			},
		},
	},
}
