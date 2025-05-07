return {
	"stevearc/oil.nvim",
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
