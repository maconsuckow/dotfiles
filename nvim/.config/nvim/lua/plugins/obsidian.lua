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
		templates = {
			folder = "Templates",
		},

		disable_frontmatter = true,
	},
	keys = {
		{ "<leader>of", "<cmd>Obsidian follow_link<CR>", "[O]bsidian [F]ollow Link" },
		{ "<leader>it", "<cmd>Obsidian template<CR>", "Obsidian [I]nsert [T]emplate" },
	},
}
