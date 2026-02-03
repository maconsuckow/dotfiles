return {
	"folke/snacks.nvim",
	lazy = false,
	priority = 1000,
	keys = {
		{
			"<leader><space>",
			function()
				Snacks.picker.smart()
			end,
			desc = "Find Files",
		},
		{
			"<leader>/",
			function()
				Snacks.picker.grep()
			end,
			desc = "Grep",
		},
		{
			"<leader>:",
			function()
				Snacks.picker.command_history()
			end,
			desc = "Command Hisotry",
		},
		{
			"<leader>e",
			function()
				Snacks.picker.explorer()
			end,
			desc = "Explorer",
		},
		{
			"<leader>n",
			function()
				Snacks.picker.notifications()
			end,
			desc = "Notification History",
		},
		{
			"<leader>fb",
			function()
				Snacks.picker.buffers()
			end,
			desc = "Open Buffers",
		},
		{
			"<leader>bd",
			function()
				Snacks.bufdelete()
			end,
			desc = "[B]uffer [D]elete",
		},
		{
			"<leader>sd",
			function()
				Snacks.picker.diagnostics()
			end,
			desc = "[S]how [D]iagnostics",
		},
		{
			"<leader>bo",
			function()
				Snacks.bufdelete()
			end,
			desc = "[B]uffer Delete [O]thers",
		},
		{
			"gd",
			function()
				Snacks.picker.lsp_definitions()
			end,
			desc = "LSP: [G]oto [D]efinitions",
		},
		{
			"gD",
			function()
				Snacks.picker.lsp_declarations()
			end,
			desc = "LSP: [G]oto [D]eclarations",
		},
		{
			"gr",
			function()
				Snacks.picker.lsp_references()
			end,
			desc = "LSP: [G]oto [R]eferences",
		},
		{
			"gI",
			function()
				Snacks.picker.lsp_implementations()
			end,
			desc = "LSP: [G]oto [I]mplementation",
		},
		{
			"<leader>z",
			function()
				Snacks.zen()
			end,
			desc = "Zen",
		},
		{
			"<leader>gb",
			function()
				Snacks.picker.git_branches()
			end,
			desc = "Git Branches",
		},
		{
			"<leader>gl",
			function()
				Snacks.picker.git_log()
			end,
			desc = "Git Log",
		},
		{
			"<leader>gL",
			function()
				Snacks.picker.git_log_line()
			end,
			desc = "Git Log Line",
		},
		{
			"<leader>gs",
			function()
				Snacks.picker.git_status()
			end,
			desc = "Git Status",
		},
		{
			"<leader>gS",
			function()
				Snacks.picker.git_stash()
			end,
			desc = "Git Stash",
		},
		{
			"<leader>gd",
			function()
				Snacks.picker.git_diff()
			end,
			desc = "Git Diff (Hunks)",
		},
		{
			"<leader>gf",
			function()
				Snacks.picker.git_log_file()
			end,
			desc = "Git Log File",
		},
		{
			"<leader>gg",
			function()
				Snacks.lazygit()
			end,
			desc = "LazyGit",
		},
		-- Grep
		{
			"<leader>sb",
			function()
				Snacks.picker.lines()
			end,
			desc = "Buffer Lines",
		},
		{
			"<leader>sB",
			function()
				Snacks.picker.grep_buffers()
			end,
			desc = "Grep Open Buffers",
		},
		{
			"<leader>sg",
			function()
				Snacks.picker.grep()
			end,
			desc = "Grep",
		},
		{
			"<leader>sw",
			function()
				Snacks.picker.grep_word()
			end,
			desc = "Visual selection or word",
			mode = { "n", "x" },
		},
		{
			"<leader>.",
			function()
				Snacks.scratch()
			end,
			desc = "Toggle Scratch Buffer",
		},
		{
			"<leader>S",
			function()
				Snacks.scratch.select()
			end,
			desc = "Select Scratch Buffer",
		},
		{
			"<leader>gB",
			function()
				Snacks.gitbrowse()
			end,
			desc = "Git Browse",
			mode = { "n", "v" },
		},
	},
	opts = {
		bigfile = { enabled = true },
		dashboard = {
			enabled = true,
			sections = {
				{ section = "keys", gap = 1, padding = 1 },
				{ title = "Recent Files", section = "recent_files", indent = 2, padding = { 2, 1 } },
				{
					align = "center",
					text = {
						{
							string.format("v%d.%d.%d", vim.version().major, vim.version().minor, vim.version().patch),
							hl = "SnacksDashboardHeader",
						},
					},
					padding = 1,
				},
				{ section = "startup" },
			},
		},
		explorer = {
			enabled = true,
			tree = false,
			focus = "input",
		},
		indent = { enabled = true },
		input = { enabled = true },
		picker = {
			enabled = true,
			sources = {
				explorer = {
					hidden = true,
					ignored = true,
					exclude = { "node_modules" },
					replace_netrw = true,
					layout = { preset = "default", preview = true },
					tree = false,
					focus = "list",
					auto_close = true,
					formatters = {
						file = {
							filename_first = true,
						},
					},
					win = {
						list = {
							keys = {
								["<c-c>"] = "", -- I would rather this do nothing than change working directory
							},
						},
					},
				},
			},
		},
		notify = { enabled = true },
		notifier = { enabled = true },
		quickfile = { enabled = true },
		scope = { enabled = false },
		scroll = {
			enabled = true,
			-- animate_repeat = {
			-- 	delay = 200,
			-- },
			-- animate = {
			-- 	duration = {
			-- 		total = 100,
			-- 	},
			-- },
		},
		word = { enabled = false },
		zen = {
			enabled = true,
		},
	},
}
