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

		frontmatter = { enabled = true },
	},
	keys = {
		{ "<leader>of", "<cmd>Obsidian follow_link vsplit<CR>", "[O]bsidian [F]ollow Link" },
		{ "<leader>ot", "<cmd>Obsidian template<CR>", "[O]bsidian Insert [T]emplate" },
		{ "<leader>oc", "<cmd>Obsidian template<CR>", "[O]bsidian Template [C]heckbox" },
	},
}
