return {
	"lewis6991/gitsigns.nvim",
  enabled = false,
	opts = {
    signcolumn = true,
    auto_attach = true,
    sign_priority = 10,
		current_line_blame = true,
		current_line_blame_opts = {
			virt_text = true,
			virt_text_pos = "right_align",
			delay = 100,
		},
	},
	keys = {
		{ "<leader>ts", "<cmd>Gitsigns toggle_signs<CR>", "Toggle Git Signs" },
		{ "<leader>gs", "<cmd>Gitsigns blame_line<CR>", "Git Blame Line" },
    {
			"<leader>gt",
			function()
				require("gitsigns").toggle_current_line_blame()
			end,
			desc = "Toggle current line blame",
		},

	},
}
