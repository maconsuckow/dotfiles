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

local function selectioncount()
	local mode = vim.fn.mode(true)
	local line_start, col_start = vim.fn.line("v"), vim.fn.col("v")
	local line_end, col_end = vim.fn.line("."), vim.fn.col(".")
	if mode:match("") then
		return string.format(
			"%d rows x %d cols",
			math.abs(line_start - line_end) + 1,
			math.abs(col_start - col_end) + 1
		)
	elseif mode:match("V") or line_start ~= line_end then
		return string.format("rows: %d", math.abs(line_start - line_end) + 1)
	elseif mode:match("v") then
		return string.format("cols: %d", math.abs(col_start - col_end) + 1)
	else
		return ""
	end
end

return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		{ "yavorski/lualine-macro-recording.nvim" },
	},
	opts = function()
		local icons = LazyVim.config.icons

		return {
			extensions = { "nvim-tree", "lazy", "mason", "neo-tree", "fugitive" },
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
						symbols = {
							added = icons.git.added,
							modified = icons.git.modified,
							removed = icons.git.removed,
						},
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
					{ "macro_recording", "%S" },
				},
				lualine_x = {
					Snacks.profiler.status(),
					"searchcount",
					selectioncount,
					"filetype",
				},
				lualine_y = { { "progress", separator = { left = "" } } },
				lualine_z = {
					{ "location", separator = { left = "", right = "" } },
					-- { "os.date('%a %b %d %I:%M %p')", separator = { right = "" }, left_padding = 2 },
				},
			},
		}
	end,
}
