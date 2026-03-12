return {
	"olimorris/codecompanion.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	config = function()
		require("codecompanion").setup({
			adapters = {
				ollama = function()
					return require("codecompanion.adapters").extend("ollama", {
						env = {
							url = "http://localhost:11434",
						},
						schema = { model = { default = "glm-4.7-flash" } },
					})
				end,
			},
			strategies = {
				chat = { adapter = "ollama" },
				inline = {
					adapter = "ollama",
					keymaps = {
						accept_change = {
							modes = { n = "ga" },
							description = "Accept the change",
						},
					},
				},
				agent = {
					adapter = "ollama",
				},
			},
		})
	end,
	keys = {
		{ "<C-a>", "<cmd>CodeCompanionActions<cr>", mode = { "n", "v" }, desc = "CodeCompanion Actions" },
		{ "<leader>a", "<cmd>CodeCompanionChat Toggle<cr>", mode = { "n", "v" }, desc = "CodeCompanion Chat" },
		{ "ga", "<cmd>CodeCompanionChat Add<cr>", mode = "v", desc = "CodeCompanion Add to Chat" },
	},
}
