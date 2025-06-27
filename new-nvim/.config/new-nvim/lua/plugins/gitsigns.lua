return {
	"lewis6991/gitsigns.nvim",
	opts = {
		current_line_blame = true,
		current_line_blame_opts = {
			virt_text = true,
			virt_text_pos = "right_align",
			delay = 100,
		},
	},
	keys = {
		{ "<leader>gs", "<cmd>Gitsigns blame_line<CR>", "Git Blame Line" },
	},
}
