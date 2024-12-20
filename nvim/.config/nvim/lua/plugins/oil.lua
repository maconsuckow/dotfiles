return {
	{
		"stevearc/oil.nvim",
		dependencies = { { "echasnovski/mini.icons", opts = {} } },
		opts = {
			default_file_explorer = true,
			view_options = {
				show_hidden = true,
			},
			keymaps = {
				["q"] = { "actions.close", mode = "n" },
				["h"] = { "actions.parent", mode = "n" },
				["l"] = { "actions.select" },
			},
			float = {
				padding = 5,
			},
		},
		keys = {
			{
				"<leader>e",
				"<cmd>Oil --float<cr>",
				desc = "Open parent directory",
			},
		},
		-- config = function(opts)
		-- 	require("oil").setup(opts)
		-- vim.api.nvim_create_autocmd("User", {
		-- 	pattern = "OilEnter",
		-- 	callback = vim.schedule_wrap(function(args)
		-- 		local oil = require("oil")
		-- 		if vim.api.nvim_get_current_buf() == args.data.buf and oil.get_cursor_entry() then
		-- 			oil.open_preview()
		-- 		end
		-- 	end),
		-- })
		-- end,
	},
}
