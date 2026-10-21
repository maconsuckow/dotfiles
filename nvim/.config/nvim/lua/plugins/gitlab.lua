return {
	"harrisoncramer/gitlab.nvim",
	dependencies = {
		"MunifTanjim/nui.nvim",
		"nvim-lua/plenary.nvim",
		"sindrets/diffview.nvim",
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
			"<leader>gmr",
			function()
				require("gitlab").choose_merge_request()
			end,
			desc = "GitLab [r]eview (List MRs)",
		},
		{
			"<leader>gmv",
			function()
				require("gitlab").review()
			end,
			desc = "GitLab [v]iew current branch review",
		},
		{
			"<leader>gms",
			function()
				require("gitlab").summary()
			end,
			desc = "GitLab [s]ummary",
		},
		{
			"<leader>gmA",
			function()
				require("gitlab").approve()
			end,
			desc = "GitLab [A]pprove",
		},
		{
			"<leader>gmR",
			function()
				require("gitlab").revoke()
			end,
			desc = "GitLab [R]evoke Approval",
		},
		{
			"<leader>gmc",
			function()
				require("gitlab").create_comment()
			end,
			desc = "GitLab [c]reate comment",
			mode = { "n", "v" },
		},
		{
			"<leader>gmd",
			function()
				require("gitlab").toggle_discussions()
			end,
			desc = "GitLab toggle [d]iscussions",
		},
		{
			"<leader>gmO",
			function()
				require("gitlab").open_in_browser()
			end,
			desc = "GitLab [O]pen in browser",
		},
		{
			"<leader>gmp",
			function()
				require("gitlab").pipeline()
			end,
			desc = "GitLab [p]ipeline status",
		},
	},
}
