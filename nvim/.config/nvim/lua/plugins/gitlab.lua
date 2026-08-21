return {
	"harrisoncramer/gitlab.nvim",
	dependencies = {
		"MunifTanjim/nui.nvim",
		"nvim-lua/plenary.nvim",
		"sindrets/diffview.nvim",
		"stevearc/dressing.nvim", -- optional but recommended
		"nvim-tree/nvim-web-devicons", -- optional
	},
	enabled = true,
	build = function()
		require("gitlab.server").build(true)
	end,
	config = function()
		require("gitlab").setup({
			-- port = 21036,
			gitlab_url = "https://gitlab.com",
			log_path = vim.fn.stdpath("cache") .. "/gitlab.nvim.log",
		})
	end,
	keys = {
		{
			"<leader>glr",
			function()
				require("gitlab").choose_merge_request()
			end,
			desc = "GitLab [r]eview (List MRs)",
		},
		{
			"<leader>glv",
			function()
				require("gitlab").review()
			end,
			desc = "GitLab [v]iew current branch review",
		},
		{
			"<leader>gls",
			function()
				require("gitlab").summary()
			end,
			desc = "GitLab [s]ummary",
		},
		{
			"<leader>glA",
			function()
				require("gitlab").approve()
			end,
			desc = "GitLab [A]pprove",
		},
		{
			"<leader>glR",
			function()
				require("gitlab").revoke()
			end,
			desc = "GitLab [R]evoke Approval",
		},
		{
			"<leader>glc",
			function()
				require("gitlab").create_comment()
			end,
			desc = "GitLab [c]reate comment",
			mode = { "n", "v" },
		},
		{
			"<leader>gld",
			function()
				require("gitlab").toggle_discussions()
			end,
			desc = "GitLab toggle [d]iscussions",
		},
		{
			"<leader>glO",
			function()
				require("gitlab").open_in_browser()
			end,
			desc = "GitLab [O]pen in browser",
		},
		{
			"<leader>glp",
			function()
				require("gitlab").pipeline()
			end,
			desc = "GitLab [p]ipeline status",
		},
	},
}
