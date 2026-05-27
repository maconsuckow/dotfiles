return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		"yavorski/lualine-macro-recording.nvim",
	},
	opts = {
		options = {
			-- Switch to 'auto' to match gruvbox-material automatically
			theme = "auto",
			component_separators = { left = "│", right = "│" },
			section_separators = { left = "", right = "" },
			disabled_filetypes = { statusline = { "dashboard", "Lazy", "alpha" } },
			globalstatus = true,
		},
		sections = {
			lualine_a = {
				{ "mode", separator = { left = "" }, right_padding = 2 },
			},
			lualine_b = {
				{ "branch", icon = "󰊢" },
				{
					"diff",
					symbols = { added = " ", modified = " ", removed = " " },
				},
			},
			lualine_c = {
				{
					"filename",
					file_status = true,
					path = 1, -- Relative path
					symbols = { modified = " ●", readonly = " 󰌾", unnamed = "[No Name]", newfile = " 󰝒" },
				},
				{
					"macro_recording",
					fmt = function(res)
						return res ~= "" and "󰑋 " .. res or ""
					end,
				},
			},
			lualine_x = {
				{
					"diagnostics",
					sources = { "nvim_diagnostic" },
					symbols = { error = " ", warn = " ", info = " ", hint = "󰌵 " },
				},
				{ "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
			},
			lualine_y = {
				{
					function()
						local msg = "No Active LSP"
						local buf_ft = vim.api.nvim_get_option_value("filetype", { buf = 0 })
						local clients = vim.lsp.get_clients({ bufnr = 0 })
						if next(clients) == nil then
							return msg
						end
						for _, client in ipairs(clients) do
							local filetypes = client.config.filetypes
							if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
								return client.name
							end
						end
						return msg
					end,
					icon = "󰄭 LSP:",
				},
			},
			lualine_z = {
				{ "location", separator = { right = "" }, left_padding = 2 },
			},
		},
	},
}
