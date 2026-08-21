return {
	"hat0uma/csvview.nvim",
	---@module "csvview"
	---@type csvview.Options
	opts = {
		parser = { comments = { "#", "//" } },
		keymaps = {
			-- These must be tables, not strings
			textobject_field_inner = { "ic", mode = { "o", "x" } },
			textobject_field_outer = { "ac", mode = { "o", "x" } },
			jump_next_field_end = { "<Tab>", mode = { "n", "v" } },
			jump_prev_field_end = { "<S-Tab>", mode = { "n", "v" } },
		},

		view = {
			sticky_header = {
				enabled = true,
				separator = "-",
			},
		},
	},
	cmd = { "CsvViewEnable", "CsvViewDisable", "CsvViewToggle" },
}
