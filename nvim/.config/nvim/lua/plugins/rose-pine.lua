return {
	"rose-pine/neovim",
	name = "rose-pine",
	lazy = false,
	priority = 1000,
	config = function()
		require("rose-pine").setup({
			variant = "moon",
			dark_variant = "moon",
			styles = {
				transparency = true,
			},
		})
	end,
}
