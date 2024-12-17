return {
	"neovim/nvim-lspconfig",
	opts = {
		diagnostics = {
			float = {
				border = {
					{ "󱐋", "WarningMsg" },
					{ "─", "Comment" },
					{ "╮", "Comment" },
					{ "│", "Comment" },
					{ "╯", "Comment" },
					{ "─", "Comment" },
					{ "╰", "Comment" },
					{ "│", "Comment" },
				},
			},
		},
		servers = {
			vtsls = {
				settings = {
					javascript = {
						preferences = {
							importModuleSpecifier = "relative",
						},
					},
					typescript = {
						inlayHints = {
							enumMemberValues = { enabled = false },
							functionLikeReturnTypes = { enabled = false },
							parameterNames = { enabled = true },
							parameterTypes = { enabled = false },
							propertyDeclarationTypes = { enabled = false },
							variableTypes = { enabled = false },
						},
						preferences = {
							importModuleSpecifier = "relative",
						},
					},
				},
			},
		},
	},
}
