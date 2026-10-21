return {
	"catppuccin/nvim",
	name = "catppuccin",
	lazy = true,
	config = function()
		require("catppuccin").setup({
			flavour = "mocha",
			transparent_background = true,
			float = {
				transparent = true,
				solid = false,
			},
			auto_integrations = true,
		})
	end,
}
