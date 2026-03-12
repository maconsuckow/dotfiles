return {
	"joryeugene/dadbod-grip.nvim",
	version = "*",
	dependencies = {
		{ "tpope/vim-dadbod", lazy = true },
		{ "kristijanhusak/vim-dadbod-completion", ft = { "sql" }, lazy = true },
		{ "tpope/vim-dotenv" },
	},
	keys = {
		{ "<leader>gd", "<cmd>GripStart<cr>", desc = "DB demo" },
		{ "<leader>gb", "<cmd>GripConnect<cr>", desc = "DB connect" },
		{ "<leader>gg", "<cmd>Grip<cr>", desc = "DB grid" },
		{ "<leader>gt", "<cmd>GripTables<cr>", desc = "DB tables" },
		{ "<leader>gq", "<cmd>GripQuery<cr>", desc = "DB query pad" },
		{ "<leader>gs", "<cmd>GripSchema<cr>", desc = "DB schema" },
		{ "<leader>gh", "<cmd>GripHistory<cr>", desc = "DB history" },
	},
	opts = {},
}
