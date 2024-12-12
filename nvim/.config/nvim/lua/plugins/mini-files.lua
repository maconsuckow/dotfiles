return {
	"echasnovski/mini.files",
	enabled = false,
	opts = {
		windows = { width_preview = 75 },
		options = { use_as_default_explorer = true },
	},
	keys = {
		-- {
		-- 	"<leader>-",
		-- 	function()
		-- 		require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
		-- 	end,
		-- 	desc = "Open mini.files (Directory of Current File)",
		-- },
	},
}
