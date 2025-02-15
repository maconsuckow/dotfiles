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
			indent = {
				chunk = { enabled = true },
			},
			git = { enabled = true },
			explorer = {
				replace_netrw = true,
			},
			words = {
				enabled = false,
			},
			picker = {
				sources = {
					explorer = {
						finder = "explorer",
						auto_close = true,
						hidden = true,
						-- layout = { preset = "vscode", preview = true },
						layout = { preset = "default", layout = { width = 0.5 } },
					},
				},
			},
			styles = {
				wo = {
					wrap = true,
				},
			},
			scroll = {
				animate = { duration = { total = 100 } },
			},
			dashboard = {
				enable = true,
				sections = {
					{ section = "header", padding = 1 },
					{ section = "terminal", cmd = "cmatrix", padding = 2, height = 5 },
					{ section = "keys", gap = 1, padding = 1 },
					{ section = "startup" },
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
