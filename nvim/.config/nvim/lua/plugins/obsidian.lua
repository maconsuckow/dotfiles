return {
	"epwalsh/obsidian.nvim",
	version = "*", -- recommended, use latest release instead of latest commit
	enabled = true,
	lazy = true,
	keys = {
		{ "<leader>ot", "<cmd>ObsidianToday<cr>", "Open Obsidian" },
		{ "<leader>os", "<cmd>ObsidianQuickSwitch<cr>", "Obsidian Quick Switch" },
	},
	ft = "markdown",
	-- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
	-- event = {
	--   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
	--   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
	--   -- refer to `:h file-pattern` for more examples
	--   "BufReadPre path/to/my-vault/*.md",
	--   "BufNewFile path/to/my-vault/*.md",
	-- },
	dependencies = {
		-- Required.
		"nvim-lua/plenary.nvim",

		-- see below for full list of optional dependencies 👇
	},
	opts = {
		workspaces = {
			{
				name = "work",
				path = "~/Documents/Obsidian/Work",
			},
		},

		-- see below for full list of options 👇
	},
}
