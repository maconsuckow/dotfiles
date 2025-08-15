return {
	"obsidian-nvim/obsidian.nvim",
	version = "*", -- recommended, use latest release instead of latest commit
	lazy = true,
	ft = "markdown",
	opts = {
		legacy_commands = false,
		workspaces = {
			{
				name = "personal",
				path = "~/Documents/Personal",
			},
		},

		-- see below for full list of options 👇
	},
}
