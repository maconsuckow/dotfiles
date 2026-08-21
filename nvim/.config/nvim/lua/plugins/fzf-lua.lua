return {
	"ibhagwan/fzf-lua",
	cmd = { "FzfLua" },
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("fzf-lua").setup({
			-- You can add custom configuration here
			winopts = {
				height = 0.85,
				width = 0.80,
				row = 0.35,
				col = 0.50,
				border = "rounded",
				preview = {
					layout = "vertical",
				},
			},
		})
	end,
	keys = {
		{ "<leader>zc", "<cmd>FzfLua colorschemes<cr>", desc = "FzfLua Colorschemes" },
	},
}
