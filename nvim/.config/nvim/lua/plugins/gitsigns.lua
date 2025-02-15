return {
	"lewis6991/gitsigns.nvim",
	keys = {
		{
			"<leader>gt",
			function()
				require("gitsigns").toggle_current_line_blame()
			end,
			desc = "Toggle current line blame",
		},
	},
	opts = {
		current_line_blame_opts = {
			virt_text = true,
			virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
			delay = 300,
			ignore_whitespace = false,
			virt_text_priority = 100,
			use_focus = true,
		},
	},
}
