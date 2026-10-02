return {
	"kylechui/nvim-surround",
	version = "*",
	event = "VeryLazy",
	init = function()
		-- default "S" clashes with flash.nvim's treesitter search in visual mode,
		-- so disable it here and rebind it below (as of nvim-surround v4, `opts.keymaps`
		-- no longer does anything -- see `:h nvim-surround.migrating.v3_to_v4`)
		vim.g.nvim_surround_no_visual_mappings = true
	end,
	config = function()
		require("nvim-surround").setup()
		vim.keymap.set("x", "gs", "<Plug>(nvim-surround-visual)", {
			desc = "Add a surrounding pair around a visual selection",
			silent = true,
		})
	end,
}
