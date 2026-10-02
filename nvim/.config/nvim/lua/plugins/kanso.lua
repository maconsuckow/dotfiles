return {
	"webhooked/kanso.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("kanso").setup({
			transparent = true,
		})
	end,
}
