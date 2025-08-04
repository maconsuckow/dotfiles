return {
	"stevearc/conform.nvim",
	keys = {
		{
			"<leader>fc",
			function()
				require("conform").format({ async = true, lsp_format = "never" })
			end,
			mode = "",
			desc = "[F]ormat [C]ode",
		},
	},
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			-- python = { "isort", "black" },
			-- rust = { "rustfmt" },
			-- javascript = { "prettierd", "prettier", "biome", "biome-organize-imports" },
			-- javascriptreact = { "prettierd", "prettier", "biome", "biome-organize-imports" },
			-- typescript = { "prettierd", "prettier", "biome", "biome-organize-imports" },
			-- typescriptreact = { "prettierd", "prettier", "biome", "biome-organize-imports" },

			-- javascript = { "biome", "biome-organize-imports" },
			-- javascriptreact = { "biome", "biome-organize-imports" },
			-- typescript = { "biome", "biome-organize-imports" },
			-- typescriptreact = { "biome", "biome-organize-imports" },

			javascript = { "prettierd", "prettier" },
			javascriptreact = { "prettierd", "prettier" },
			typescript = { "prettierd", "prettier" },
			typescriptreact = { "prettierd", "prettier" },
		},
		format_on_save = {
			-- These options will be passed to conform.format()
			timeout_ms = 500,
			lsp_format = "fallback",
		},
	},
}
