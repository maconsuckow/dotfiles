return {
	"Exafunction/windsurf.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"hrsh7th/nvim-cmp",
			opts = {
				window = {
					completion = {
						border = nil,
						winhighlight = nil,
					},
					documentation = {
						border = nil,
						winhighlight = nil,
					},
				},
			},
		},
	},
	config = function()
		require("codeium").setup({
			virtual_text = {
				enabled = true,
			},
			default_filetype_enabled = true,
			filetypes = {
				html = true,
				typescript = true,
				javascript = true,
				css = true,
				json = true,
			},
		})
	end,
}
