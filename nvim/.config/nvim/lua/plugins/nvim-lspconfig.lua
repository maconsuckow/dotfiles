return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile", "BufWritePre" },
	dependencies = {
		"mason.nvim",
		{ "williamboman/mason-lspconfig.nvim", config = function() end },
	},
	config = function()
		vim.diagnostic.config({
			severity_sort = true,
			float = { border = "rounded", source = "if_many" },
			underline = { severity = vim.diagnostic.severity.ERROR },
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = "󰅚 ",
					[vim.diagnostic.severity.WARN] = "󰀪 ",
					[vim.diagnostic.severity.INFO] = "󰋽 ",
					[vim.diagnostic.severity.HINT] = "󰌶 ",
				},
			},
			virtual_text = {
				source = "if_many",
				spacing = 2,
				format = function(diagnostic)
					local diagnostic_message = {
						[vim.diagnostic.severity.ERROR] = diagnostic.message,
						[vim.diagnostic.severity.WARN] = diagnostic.message,
						[vim.diagnostic.severity.INFO] = diagnostic.message,
						[vim.diagnostic.severity.HINT] = diagnostic.message,
					}
					return diagnostic_message[diagnostic.severity]
				end,
			},
		})

		local capabilities = vim.lsp.protocol.make_client_capabilities()

		local servers = {
			bashls = {},
			marksman = {},
			biome = {},
			lua_ls = {},
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
		}

		local ensure_installed = vim.tbl_keys(servers or {})

		require("mason-lspconfig").setup({
			ensure_installed = vim.tbl_deep_extend("force", ensure_installed, {}),
			automatic_installation = false,
			handlers = {
				function(server_name)
					local server = servers[server_name] or {}
					server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
					require("lspconfig")[server_name].setup(server)
				end,
			},
		})
	end,
}
