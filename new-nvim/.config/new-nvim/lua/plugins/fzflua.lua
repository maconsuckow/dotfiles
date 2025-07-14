return {
	"ibhagwan/fzf-lua",
	-- optional for icon support
	dependencies = { "nvim-tree/nvim-web-devicons" },
	-- or if using mini.icons/mini.nvim
	-- dependencies = { "echasnovski/mini.icons" },
	keys = {
		{ "<leader>b", "<cmd>FzfLua buffers<CR>", "Open Buffers" },
		{ "<leader><space>", "<cmd>FzfLua files<CR>", "Find Files" },
		{ "<leader>/", "<cmd>FzfLua live_grep<CR>", "Live Grep" },
		{ "gd", "<cmd>FzfLua lsp_definitions<CR>", "LSP: [G]oto [D]efinition" },
		{ "gr", "<cmd>FzfLua lsp_references<CR>", "LSP: [G]oto [R]eferences" },
		{ "gI", "<cmd>FzfLua lsp_implementations<CR>", "LSP: [G]oto [I]mplementation" },
		{ "<leader>D", "<cmd>FzfLua lsp_typedefs<CR>", "Type [D]efinition" },
		{ "<leader>ds", "<cmd>FzfLua lsp_document_symbols<CR>", "[D]ocument [S]ymbols" },
		{ "<leader>ws", "<cmd>FzfLua lsp_live_workspace_symbols<CR>", "[W]ocument [S]ymbols" },
    { "<leader>:", "<cmd>FzfLua command_history<CR>", "Command Hisotry" },
		{ "<leader>ca", "<cmd>FzfLua lsp_code_actions<CR>", "[C]ode [A]ctions" },
		{ "<leader>cd", "<cmd>FzfLua lsp_document_diagnostics<CR>", "Line Diagnostics" },

		{ "<leader>gf", "<cmd>FzfLua git_files<CR>", "Git Files" },
		{ "<leader>gs", "<cmd>FzfLua git_status<CR>", "Git Status" },
		{ "<leader>b", "<cmd>FzfLua builtin<CR>", "Fzf buildin" },
	},
	opts = {
    defaults = {
      formatter = "path.filename_first"
    }

  },
}
