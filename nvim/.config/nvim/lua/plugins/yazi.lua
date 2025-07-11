return {
	"mikavilpas/yazi.nvim",
	event = "VeryLazy",
	enabled = false,
	keys = {
		-- {
		-- 	"<leader>-",
		-- 	"<cmd>Yazi<cr>",
		-- 	desc = "Open yazi at the current file",
		-- },
		{
			"<leader>fm",
			"<cmd>Yazi<cr>",
			desc = "Open yazi at the current file",
		},
		{
			"<leader>cw",
			"<cmd>Yazi cwd<cr>",
			desc = "Open the file manager in nvim's working directory",
		},
	},
	-- opts = {
	-- 	open_for_directories = true,
	-- 	keymaps = {
	-- 		show_help = "<f1>",
	-- 		open_file_in_vertical_split = "<c-v>",
	-- 		open_file_in_horizontal_split = "<c-x>",
	-- 		open_file_in_tab = "<c-t>",
	-- 		grep_in_directory = "<c-s>",
	-- 		replace_in_directory = "<c-g>",
	-- 		cycle_open_buffers = "<tab>",
	-- 		copy_relative_path_to_selected_files = "<c-y>",
	-- 		send_to_quickfix_list = "<c-q>",
	-- 		change_working_directory = "<c-\\>",
	-- 	},
	-- 	show_hidden = true,
	-- 	show_symlink = true,
	-- 	integrations = {
	-- 		grep_in_selected_files = "fzf-lua",
	-- 		grep_in_directory = "fzf-lua",
	-- 	},
	-- },
}
