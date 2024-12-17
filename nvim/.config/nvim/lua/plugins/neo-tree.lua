return {
	"nvim-neo-tree/neo-tree.nvim",
	opts = {
		window = {
			position = "float",
			width = 80,
		},
		filesystem = {
			filtered_items = {
				hide_dotfiles = false,
				hide_gitignored = false,
				never_show = { ".DS_Store" },
			},
			follow_current_file = { enabled = true },
			hijack_netrw_behavior = "open_default",
		},
	},
}
