return {
	"NvChad/nvim-colorizer.lua",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		filetypes = { "*" },
		options = {
			parsers = {
				css = true,
				css_fn = true,
				names = { enable = true },
				hex = { default = true, rrggbbaa = true, aarrggbb = true, hash_aarrggbb = true },
				rgb = { enable = true },
				hsl = { enable = true },
				tailwind = { enable = true },
			},
			display = {
				mode = "virtualtext",
				virtualtext = {
					char = "■",
					position = "eol",
				},
			},
		},
	},
	config = function(_, opts)
		require("colorizer").setup(opts)
	end,
}
