return {
	"otavioschwanck/fzf-lua-explorer.nvim",
	dependencies = { "ibhagwan/fzf-lua" },
	enabled = false,
	keys = {
		-- { "<leader>.", "<cmd>lua require('fzf-lua-explorer').explorer()<cr>", desc = "Explorer" },
	},
	opts = {
		keybindings = {
			-- go_to_parent = "ctrl-h",
			-- open_vsplit = "ctrl-s",
			-- open_hsplit = "ctrl-b",
		},
	},
}
