return {
	"stevearc/conform.nvim",
	optional = true,
	opts = {
		formatters_by_ft = {
			html = { "prettier" },
			javascript = { "prettier" },
			javascriptreact = { "prettier" },
			typescript = { "prettier" },
			typescriptreact = { "prettier" },
			yaml = { "prettier" },
			--
			-- javascript = { "biome", "biome-organize-imports" },
			-- javascriptreact = { "biome", "biome-organize-imports" },
			-- typescript = { "biome", "biome-organize-imports" },
			-- typescriptreact = { "biome", "biome-organize-imports" },
		},
		formatters = {
			prettier = {
				semi = false,
				singleQuote = true,
				trailingComma = "es5",
				endOfLine = "auto",
			},
		},
	},
}
