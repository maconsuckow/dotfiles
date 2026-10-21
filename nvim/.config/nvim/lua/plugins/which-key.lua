return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		preset = "helix",
		spec = {
			{ "<leader>a", group = "ai/sidekick" },
			{ "<leader>b", group = "buffer" },
			{ "<leader>c", group = "code" },
			{ "<leader>d", group = "debug/db" },
			{ "<leader>f", group = "file/find" },
			{ "<leader>g", group = "git" },
			{ "<leader>gm", group = "gitlab/mr" },
			{ "<leader>h", group = "git hunks", mode = { "n", "v" } },
			{ "<leader>j", group = "jira" },
			{ "<leader>o", group = "obsidian" },
			{ "<leader>q", group = "session" },
			{ "<leader>s", group = "search" },
			{ "<leader>t", group = "test" },
			{ "<leader>u", group = "ui" },
			{ "<leader>w", group = "window" },
			{ "<leader>x", group = "diagnostics/quickfix" },
		},
	},
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "Buffer Local Keymaps (which-key)",
		},
	},
}
