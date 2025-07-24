local custom_kanagawa = {}
custom_kanagawa.normal = {
	a = { bg = "#717C7C", fg = "#0d0c0c" },
	b = { bg = "#252535", fg = "#717C7C" },
	c = { bg = "NONE", fg = "#c5c9c5" },
}

custom_kanagawa.insert = {
	a = { bg = "#87a987", fg = "#181616" },
	b = { bg = "#252535", fg = "#87a987" },
}

custom_kanagawa.command = {
	a = { bg = "#c4746e", fg = "#181616" },
	b = { bg = "#252535", fg = "#c4746e" },
}

custom_kanagawa.visual = {
	a = { bg = "#8992a7", fg = "#181616" },
	b = { bg = "#252535", fg = "#8992a7" },
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
	dependencies = { "nvim-tree/nvim-web-devicons", "yavorski/lualine-macro-recording.nvim" },
	opts = {
		options = {
			theme = custom_kanagawa,
			custom_separators = { right = "--", left = "--" },
			section_separators = { right = "", left = "" },
			disabled_filetypes = { statusline = { "dashboard", "Lazy" } },
			globalstatus = true,
		},
		sections = {
			lualine_a = {
				{ "mode", separator = { left = "", right = "" }, right_padding = 2 },
			},
			lualine_b = {
				{ "branch", separator = { right = "" } },
				{
					"diff",
					separator = { right = "" },
					symbols = {
						added = " ",
						modified = " ",
						removed = " ",
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
				{
					"filename",
					file_status = true, -- Displays file status (readonly status, modified status)
					newfile_status = false, -- Display new file status (new file means no write after created)
					path = 4, -- 0: Just the filename
					-- 1: Relative path
					-- 2: Absolute path
					-- 3: Absolute path, with tilde as the home directory
					-- 4: Filename and parent dir, with tilde as the home directory

					shorting_target = 40, -- Shortens path to leave 40 spaces in the window
					-- for other components. (terrible name, any suggestions?)
					symbols = {
						modified = "[+]", -- Text to show when the file is modified.
						readonly = "[-]", -- Text to show when the file is non-modifiable or readonly.
						unnamed = "[No Name]", -- Text to show for unnamed buffers.
						newfile = "[New]", -- Text to show for newly created file before first write
					},
				},
				{ "macro_recording", "%S" },
			},
			lualine_x = {
				-- 	Snacks.profiler.status(),
				-- 	"searchcount",
				-- 	selectioncount,
				"filetype",
			},
			lualine_y = { { "progress", separator = { left = "" } } },
			lualine_z = {
				{ "location", separator = { left = "", right = "" } },
				-- { "os.date('%a %b %d %I:%M %p')", separator = { right = "" }, left_padding = 2 },
			},
		},
	},
}
