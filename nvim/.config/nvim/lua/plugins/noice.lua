return {
	"folke/noice.nvim",
	opts = {
		views = {
			notify = {
				replace = true,
			},
		},
		lsp = {
			hover = {
				enabled = false,
			},
			signature = {
				enabled = false,
			},
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
			-- vim-dadbod echoes this on every query; with cmdheight=0 it caused a hit-enter prompt
			{
				filter = {
					event = "msg_show",
					find = "^DB: Running query",
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
