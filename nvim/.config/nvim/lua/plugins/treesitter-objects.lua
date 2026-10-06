return {
	"nvim-treesitter/nvim-treesitter-textobjects",
	branch = "main",
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

		vim.keymap.set("n", "<leader>px", function()
			require("nvim-treesitter-textobjects.swap").swap_next("@parameter.inner")
		end, { desc = "Swap with next parameter" })
		vim.keymap.set("n", "<leader>pX", function()
			require("nvim-treesitter-textobjects.swap").swap_previous("@parameter.inner")
		end, { desc = "Swap with previous parameter" })
	end,
}
