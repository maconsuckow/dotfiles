return {
	"ibhagwan/fzf-lua",
	-- optional for icon support
	dependencies = { "nvim-tree/nvim-web-devicons" },
	-- or if using mini.icons/mini.nvim
	-- dependencies = { "echasnovski/mini.icons" },
	keys = {
		{ "<leader>e", "<cmd>FzfLua files<CR>", "Find Files" },
		{ "<leader><leader>", "<cmd>FzfLua buffers<CR>", "Open Buffers" },
		{ "<leader>/", "<cmd>FzfLua live_grep<CR>", "Live Grep" },
		{ "<leader>gs", "<cmd>FzfLua git_status<CR>", "Git Status" },
		{ "<leader>b", "<cmd>FzfLua builtin<CR>", "Fzf buildin" },
	},
	opts = {},
}
