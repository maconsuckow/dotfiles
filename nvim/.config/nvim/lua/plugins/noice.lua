return {
	"folke/noice.nvim",
	opts = {
		hover = {
			enabled = false,
		},
		signatrue = {
			enabled = false,
		},
		messages = {
			enabled = false,
		},
		views = {
			notify = {
				replace = true,
			},
		},
		lsp = {
			progress = {
				enabled = true,
				format = "lsp_progress",
				format_done = "lsp_progress_done",
				view = "notify",
			},
			-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
			override = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				["vim.lsp.util.stylize_markdown"] = true,
				["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
			},
		},
		routes = {
			{
				filter = {
					event = "msg_show",
					kind = "search_count",
				},
				opts = { skip = true },
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
