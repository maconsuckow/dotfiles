return {
	"gbprod/yanky.nvim",
	opts = {},
	keys = {
		{
			"<leader>p",
			"<cmd>YankyRingHistory<cr>",
			desc = "Open Ring History",
		},
		{
			"y",
			"<Plug>(YankyYank)",
			desc = "Yank text",
		},
		{
			"p",
			"<Plug>(YankyPutAfter)",
		},
		{
			"P",
			"<Plug>(YankyPutBefore)",
		},
		{
			"gp",
			"<Plug>(YankyGPutAfter)",
		},
		{
			"gP",
			"<Plug>(YankyGPutBefore)",
		},
	},
}
