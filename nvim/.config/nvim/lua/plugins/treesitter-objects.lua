return {
	"nvim-treesitter/nvim-treesitter-textobjects",
	branch = "main",
	event = { "BufReadPost", "BufNewFile" },
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
	},
	config = function()
		require("nvim-treesitter-textobjects").setup({
			select = {
				-- Automatically jump forward to textobj, similar to targets.vim
				lookahead = true,
				selection_modes = {
					["@parameter.outer"] = "v", -- charwise
					["@function.outer"] = "V", -- linewise
					["@class.outer"] = "<c-v>", -- blockwise
				},
				-- Extend textobjects to include preceding or succeeding whitespace, like `ap`
				include_surrounding_whitespace = true,
			},
			move = {
				set_jumps = true,
			},
		})

		local map = function(lhs, query, desc, group)
			vim.keymap.set({ "x", "o" }, lhs, function()
				require("nvim-treesitter-textobjects.select").select_textobject(query, group or "textobjects")
			end, { desc = desc })
		end

		map("af", "@function.outer", "Select outer function")
		map("if", "@function.inner", "Select inner function")
		map("ac", "@class.outer", "Select outer class")
		map("ic", "@class.inner", "Select inner part of a class region")
		map("ao", "@comment.outer", "Select outer comment")
		map("as", "@local.scope", "Select language scope", "locals")

		local move = require("nvim-treesitter-textobjects.move")
		vim.keymap.set({ "n", "x", "o" }, "]f", function()
			move.goto_next_start("@function.outer", "textobjects")
		end, { desc = "Next Function Start" })
		vim.keymap.set({ "n", "x", "o" }, "[f", function()
			move.goto_previous_start("@function.outer", "textobjects")
		end, { desc = "Prev Function Start" })
		vim.keymap.set({ "n", "x", "o" }, "]F", function()
			move.goto_next_end("@function.outer", "textobjects")
		end, { desc = "Next Function End" })
		vim.keymap.set({ "n", "x", "o" }, "[F", function()
			move.goto_previous_end("@function.outer", "textobjects")
		end, { desc = "Prev Function End" })
		vim.keymap.set({ "n", "x", "o" }, "]a", function()
			move.goto_next_start("@parameter.inner", "textobjects")
		end, { desc = "Next Parameter" })
		vim.keymap.set({ "n", "x", "o" }, "[a", function()
			move.goto_previous_start("@parameter.inner", "textobjects")
		end, { desc = "Prev Parameter" })

		local ts_repeat = require("nvim-treesitter-textobjects.repeatable_move")
		vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat.repeat_last_move_next, { desc = "Repeat Last Move Next" })
		vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat.repeat_last_move_previous, { desc = "Repeat Last Move Prev" })
		vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat.builtin_f_expr, { expr = true, desc = "Move to Next Char" })
		vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat.builtin_F_expr, { expr = true, desc = "Move to Prev Char" })
		vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat.builtin_t_expr, { expr = true, desc = "Move Before Next Char" })
		vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat.builtin_T_expr, { expr = true, desc = "Move After Prev Char" })

		vim.keymap.set("n", "<leader>cx", function()
			require("nvim-treesitter-textobjects.swap").swap_next("@parameter.inner")
		end, { desc = "Swap with next parameter" })
		vim.keymap.set("n", "<leader>cX", function()
			require("nvim-treesitter-textobjects.swap").swap_previous("@parameter.inner")
		end, { desc = "Swap with previous parameter" })
	end,
}
