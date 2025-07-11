return {
	{
		"saghen/blink.cmp",
		dependencies = { "saghen/blink.compat" },
		opts = {
			sources = {
				default = { "lsp", "buffer", "snippets", "path" },
				per_filetype = {
					sql = { "dadbod" },
				},
				providers = {
					dadbod = {
						name = "Dadbod",
						module = "vim_dadbod_completion.blink",
					},
				},
			},
			-- indent = {
			-- 	enabled = true,
			-- 	-- start with indent guides visible
			-- 	visible = true,
			-- },
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
					draw = {
						treesitter = { "lsp" },
					},
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
