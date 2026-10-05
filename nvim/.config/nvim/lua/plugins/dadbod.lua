return {
	"kristijanhusak/vim-dadbod-ui",
	enabled = true,
	dependencies = {
		{ "tpope/vim-dadbod", lazy = true },
		{ "kristijanhusak/vim-dadbod-completion", ft = { "sql" }, lazy = true },
		{ "tpope/vim-dotenv" },
	},
	cmd = {
		"DBUI",
		"DBUIToggle",
		"DBUIAddConnection",
		"DBUIFindBuffer",
	},
	init = function()
		-- Your DBUI configuration
		vim.g.db_ui_use_nerd_fonts = 1
		vim.g.db_ui_hide_schemas = {
			"pg_toast",
			"pg_catalog",
			"pglogical",
			"information_schema",
		}
    vim.g.db_ui_use_postgres_views = 1 -- Show Postgres views & materialized views
    vim.g.db_ui_show_help = 0          -- Optional: hide help text to save space
    vim.g.db_ui_win_width = 40         -- Optional: set custom sidebar width

		-- Connections live in lua/local/dbs.lua (gitignored, contains credentials)
		local ok, dbs = pcall(require, "local.dbs")
		if ok then
			vim.g.dbs = dbs
		end
	end,
	keys = {
		{ "<leader>dd", "<cmd>DBUIToggle<cr>", desc = "Dadbod UI Toggle" },
	},
}
