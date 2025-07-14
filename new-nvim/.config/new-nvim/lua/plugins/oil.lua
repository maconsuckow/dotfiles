return {
	"stevearc/oil.nvim",
  enabled = false,
	opts = {
		default_file_explorer = true,
		columns = { "icon", "size" },
		view_options = {
			show_hidden = true,
		},
		keymaps = {
			["q"] = { "actions.close", mode = "n" },
			["h"] = { "actions.parent", mode = "n" },
			["l"] = { "actions.select" },
		},
		float = {
			padding = 5,
		},
		skip_confirm_for_simple_edits = true,
		watch_for_changes = true,
	},
	keys = {
		{
			"<leader>,",
			"<cmd>Oil --float<cr>",
			desc = "Open parent directory",
		},
	},
}
