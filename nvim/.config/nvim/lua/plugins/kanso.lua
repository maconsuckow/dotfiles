return {
	"webhooked/kanso.nvim",
	lazy = true,
	config = function()
		require("kanso").setup({
			transparent = true,
		})
	end,
}
