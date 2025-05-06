return {
	"folke/snacks.nvim",
	opts = {
		bigfile = { enabled = true },
		dashboard = {
			enabled = true,
			sections = {
				{ section = "keys", gap = 1, padding = 1 },
				{ title = "Recent Files", section = "recent_files", indent = 2, padding = { 2, 1 } },
				{ section = "startup" },
			},
		},
		explorer = {
			enabled = false,
		},
		indent = { enabled = true },
		input = { enabled = true },
		picker = { enabled = false },
		notifier = { enabled = true },
		quickfile = { enabled = true },
		scope = { enabled = false },
		scroll = { enabled = true },
		word = { enabled = false },
	},
}
