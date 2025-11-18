return {
	"mikavilpas/yazi.nvim",
	version = "*", -- use the latest stable version
	event = "VeryLazy",
	dependencies = {
		{ "nvim-lua/plenary.nvim", lazy = true },
	},
	keys = {
		{
			"<leader>-",
			mode = { "n", "v" },
			"<cmd>Yazi<cr>",
			desc = "Yazi Current File",
		},
		{
			-- Open in the current working directory
			"<leader>cw",
			"<cmd>Yazi cwd<cr>",
			desc = "Yazi Current Working Directory",
		},
		{
			"<c-up>",
			"<cmd>Yazi toggle<cr>",
			desc = "Yazi Resume Session",
		},
	},
	opts = {
		keymaps = {
			open_file_in_horizontal_split = "<c-_>",
			open_file_in_vertical_split = "<c-|>",
		},
	},
}
