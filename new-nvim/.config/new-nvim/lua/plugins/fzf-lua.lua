return {
	"ibhagwan/fzf-lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	keys = {
		{ "<leader>fb", "<cmd>FzfLua buffers<CR>", "Open Buffers" },
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
	},
	config = function()
		require("fzf-lua").setup({
			winopts = {
				preview = {
					horizontal = "right:50%",
				},
			},
			defaults = {
				formatter = "path.filename_first",
			},
			grep = {
				winopts = {
					width = 0.9,
					preview = {
						horizontal = "right:30%",
					},
				},
			},
			-- files = {
			-- 	previewer = "bat",
			-- 	git_icons = true,
			-- },
		})
		require("fzf-lua").register_ui_select()
	end,
}
