return {
	"rose-pine/neovim",
	name = "rose-pine",
	lazy = true,
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
