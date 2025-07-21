return {
	"folke/noice.nvim",
	opts = {
		hover = {
			enabled = false,
		},
		signatrue = {
			enabled = false,
		},
		lsp = {
			progress = {
				enabled = true,
				view = "notify",
				timeout = 5000,
				opts = {
					size = "small",
				},
			},
			-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
			override = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				["vim.lsp.util.stylize_markdown"] = true,
				["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
			},
		},
		presets = {
			bottom_search = false,
			command_palette = true,
			long_message_to_split = true,
			inc_rename = true,
			lsp_doc_border = true,
		},
	},
}
