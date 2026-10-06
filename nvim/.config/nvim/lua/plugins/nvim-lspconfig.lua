return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile", "BufWritePre" },
	dependencies = {
		"mason.nvim",
		{ "williamboman/mason-lspconfig.nvim", config = function() end },
		{ "b0o/SchemaStore.nvim", lazy = true, version = false },
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
		capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)

		local servers = {
			bashls = {},
			marksman = {},
			biome = {},
			lua_ls = {},
			typos_lsp = {},
			-- Non-empty settings: an empty table is sent as a JSON array, which harper rejects
			harper_ls = {
				settings = {
					["harper-ls"] = { diagnosticSeverity = "hint" },
				},
			},
			-- Run on any SQL buffer (DBUI queries live outside projects) using one global config
			postgres_lsp = {
				cmd = {
					"postgres-language-server",
					"lsp-proxy",
					"--config-path=" .. vim.fn.stdpath("config") .. "/postgres-language-server.jsonc",
				},
				workspace_required = false,
			},
			-- Biome formats JSON; jsonls only validates/completes against SchemaStore
			jsonls = {
				init_options = { provideFormatter = false },
				settings = {
					json = {
						schemas = require("schemastore").json.schemas(),
						validate = { enable = true },
					},
				},
			},
			yamlls = {
				settings = {
					yaml = {
						-- Use SchemaStore.nvim's catalog instead of yamlls' built-in download
						schemaStore = { enable = false, url = "" },
						schemas = require("schemastore").yaml.schemas(),
						-- GitLab CI `!reference [job, script]` tags
						customTags = { "!reference sequence" },
						format = { enable = false },
					},
				},
			},
			-- Only start in projects that depend on tailwindcss (the default falls back to any .git root)
			tailwindcss = {
				root_dir = function(bufnr, on_dir)
					local root = vim.fs.root(bufnr, function(name, path)
						if name:match("^tailwind%.config%.") then
							return true
						end
						if name ~= "package.json" then
							return false
						end
						local file = io.open(vim.fs.joinpath(path, name))
						if not file then
							return false
						end
						local content = file:read("*a")
						file:close()
						return content:find('"tailwindcss"', 1, true) ~= nil
					end)
					if root then
						on_dir(root)
					end
				end,
			},
			vtsls = {
				settings = {
					vtsls = {
						autoUseWorkspaceTsdk = true,
					},
					javascript = {
						preferences = {
							importModuleSpecifier = "relative",
							importModuleSpecifierEnding = "minimal",
							autoImportFileExcludePatterns = { "**/index.ts", "**/index.tsx" },
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
							importModuleSpecifierEnding = "minimal",
							autoImportFileExcludePatterns = { "**/index.ts", "**/index.tsx" },
						},
					},
				},
			},
		}

		-- mason-lspconfig v2 ignores `handlers` and enables servers via vim.lsp.enable(),
		-- so per-server settings must be registered with vim.lsp.config() first
		vim.lsp.config("*", { capabilities = capabilities })
		for server_name, server in pairs(servers) do
			if next(server) then
				vim.lsp.config(server_name, server)
			end
		end

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("lsp_inlay_hints", { clear = true }),
			callback = function(args)
				local client = vim.lsp.get_client_by_id(args.data.client_id)
				if client and client:supports_method("textDocument/inlayHint") then
					vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
				end
			end,
		})
		vim.keymap.set("n", "<leader>uh", function()
			vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = 0 }), { bufnr = 0 })
		end, { desc = "Toggle Inlay Hints" })

		require("mason-lspconfig").setup({
			ensure_installed = vim.tbl_keys(servers),
		})
	end,
}
