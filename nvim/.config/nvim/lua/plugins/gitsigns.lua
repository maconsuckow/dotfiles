return {
	"lewis6991/gitsigns.nvim",
	event = "BufReadPost",
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
		on_attach = function(bufnr)
			local gs = require("gitsigns")
			local function map(mode, l, r, desc, opts)
				opts = opts or {}
				opts.buffer = bufnr
				opts.desc = desc
				vim.keymap.set(mode, l, r, opts)
			end

			map("n", "]c", function()
				if vim.wo.diff then
					return "]c"
				end
				vim.schedule(gs.next_hunk)
				return "<Ignore>"
			end, "Next Hunk", { expr = true })
			map("n", "[c", function()
				if vim.wo.diff then
					return "[c"
				end
				vim.schedule(gs.prev_hunk)
				return "<Ignore>"
			end, "Prev Hunk", { expr = true })

			map("n", "<leader>hp", gs.preview_hunk, "Preview Hunk")
			map("n", "<leader>hr", gs.reset_hunk, "Reset Hunk")
			map("v", "<leader>hr", function()
				gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end, "Reset Hunk (selection)")
			map("n", "<leader>hR", gs.reset_buffer, "Reset Buffer")
			map("n", "<leader>hb", gs.blame_line, "Blame Line")
		end,
	},
}
