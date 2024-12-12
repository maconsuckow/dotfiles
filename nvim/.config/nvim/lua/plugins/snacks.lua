return {
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		keys = {
			{
				"<leader>gf",
				function()
					Snacks.lazygit.log()
				end,
				desc = "Lazygit Log (cwd)",
			},
		},
		opts = {
			lazygit = {
				configure = true,
			},
			scroll = {
				animate = { duration = { total = 100 } },
			},
			statuscolumn = {},
			dashboard = {
				enable = true,
				sections = {
					{ section = "header" },
					{ section = "keys", gap = 1, padding = 1 },
					{ section = "startup" },
					-- {
					-- 	pane = 2,
					-- 	{ height = 10 },
					-- 	{
					-- 		icon = " ",
					-- 		title = "Recent Files",
					-- 		section = "recent_files",
					-- 		indent = 2,
					-- 		padding = 1,
					-- 	},
					-- 	{ icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
					-- },
				},
				preset = {
					header = [[
███████╗ ██████╗ ██╗     ██╗██████╗ ██████╗  ██████╗  ██████╗██╗  ██╗
██╔════╝██╔═══██╗██║     ██║██╔══██╗██╔══██╗██╔═══██╗██╔════╝██║ ██╔╝
███████╗██║   ██║██║     ██║██║  ██║██████╔╝██║   ██║██║     █████╔╝ 
╚════██║██║   ██║██║     ██║██║  ██║██╔══██╗██║   ██║██║     ██╔═██╗ 
███████║╚██████╔╝███████╗██║██████╔╝██║  ██║╚██████╔╝╚██████╗██║  ██╗
╚══════╝ ╚═════╝ ╚══════╝╚═╝╚═════╝ ╚═╝  ╚═╝ ╚═════╝  ╚═════╝╚═╝  ╚═╝
          ]],
				},
			},
		},
	},
}
