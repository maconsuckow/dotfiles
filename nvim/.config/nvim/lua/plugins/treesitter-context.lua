return {
	"nvim-treesitter/nvim-treesitter-context",
	event = { "BufReadPost", "BufNewFile" },
	opts = {
		max_lines = 3, -- keep the sticky header from taking over small windows
	},
	keys = {
		{
			"<leader>ut",
			function()
				require("treesitter-context").toggle()
			end,
			desc = "Toggle Treesitter Context",
		},
	},
}
