-- local palette = require("kanagawa.colors").palette
-- local kanagawa_themes = require("kanagawa.themes")
-- local dragon = kanagawa_themes.dragon(palette)
--
local custom_kanagawa = {}
custom_kanagawa.normal = {
	a = { bg = "#8ba4b0", fg = "#0d0c0c" },
	b = { bg = "#252535", fg = "#8ba4b0" },
	c = { bg = "NONE", fg = "#c5c9c5" },
}

custom_kanagawa.insert = {
	a = { bg = "#98BB6C", fg = "#181616" },
	b = { bg = "#252535", fg = "#98BB6C" },
}

custom_kanagawa.command = {
	a = { bg = "#c4746e", fg = "#181616" },
	b = { bg = "#252535", fg = "#c4746e" },
}

custom_kanagawa.visual = {
	a = { bg = "#c4746e", fg = "#181616" },
	b = { bg = "#252535", fg = "#c4746e" },
}

custom_kanagawa.replace = {
	a = { bg = "#b6927b", fg = "#181616" },
	b = { bg = "#181616", fg = "#b6927b" },
}

custom_kanagawa.inactive = {
	a = { bg = "#0d0c0c", fg = "#C8C093" },
	b = { bg = "#0d0c0c", fg = "#C8C093", gui = "bold" },
	c = { bg = "#0d0c0c", fg = "#C8C093" },
}

return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "yavorski/lualine-macro-recording.nvim" },
	opts = {
		options = {
			theme = custom_kanagawa,
			component_separators = { right = "--", left = "--" },
			section_separators = { right = "", left = "" },
			disabled_filetypes = { statusline = { "dashboard", "Neo-tree", "Lazy", "LazyVim" } },
		},
		sections = {
			lualine_a = {
				{ "mode", separator = { left = "", right = "" }, right_padding = 2 },
			},
			lualine_b = {
				-- { "branch" },
				{ "branch", separator = { right = "" } },
				{
					"diff",
					separator = { right = "" },
					symbols = { added = "+", modified = "~", removed = "-" },
				},
				-- {
				--   "diagnostics",
				--   symbols = {
				--     error = icons.diagnostics.Error,
				--     warn = icons.diagnostics.Warn,
				--     info = icons.diagnostics.Info,
				--     hint = icons.diagnostics.Hint,
				--   },
				--   colored = false,
				--   separator = { left = "", right = "" },
				-- },
			},
			lualine_c = {
				LazyVim.lualine.pretty_path({ relative = "root", length = 10 }),
				{ "macro_recording" },
			},
			lualine_x = {
				-- { "searchcount", separator = { left = "" }, right_padding = 2 },
				-- {
				--   function()
				--     return require("noice").api.status.command.get()
				--   end,
				--   cond = function()
				--     return package.loaded["noice"] and require("noice").api.status.command.has()
				--   end,
				--   color = function()
				--     return LazyVim.ui.fg("Statement")
				--   end,
				-- },
				-- LazyVim.lualine.cmp_source("codeium"),
				-- stylua: ignore
				-- {
				--   function() return require("noice").api.status.mode.get() end,
				--   cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
				--   color = function() return LazyVim.ui.fg("Constant") end,
				-- },
				-- stylua: ignore
				-- {
				--   function() return "  " .. require("dap").status() end,
				--   cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
				--   color = function() return LazyVim.ui.fg("Debug") end,
				-- },
				-- {
				--   require("lazy.status").updates,
				--   cond = require("lazy.status").has_updates,
				--   color = function()
				--     return LazyVim.ui.fg("Special")
				--   end,
				-- },
			},
			lualine_y = { { "progress", separator = { left = "" } } },
			lualine_z = {
				{ "location", separator = { left = "" } },
				{ "os.date('%a %b %d %I:%M %p')", separator = { right = "" }, left_padding = 2 },
			},
		},
	},
}
