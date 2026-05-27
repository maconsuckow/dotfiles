return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-treesitter/nvim-treesitter",
		"nvim-neotest/neotest-jest",
		"marilari88/neotest-vitest",
	},
	config = function()
		local jest_adapter = require("neotest-jest")({
			jestCommand = "yarn test",
			env = { CI = true, NODE_ENV = "test" },
			cwd = function(path)
				local root = vim.fs.find({ "package.json" }, { path = path, upward = true })[1]
				return root and vim.fs.dirname(root) or vim.loop.cwd()
			end,
		})

		local original_build_spec = jest_adapter.build_spec
		jest_adapter.build_spec = function(args)
			require("neotest.async").scheduler()
			local spec = original_build_spec(args)
			if spec and spec.command then
				local new_command = {}
				for _, arg in ipairs(spec.command) do
					if not arg:match("^%-%-config=") then
						table.insert(new_command, arg)
					end
				end
				spec.command = new_command
			end
			return spec
		end

		require("neotest").setup({
			adapters = {
				jest_adapter,
				require("neotest-vitest"),
			},
			output = {
				open_on_run = true,
			},
			floating = {
				border = "rounded",
				max_height = 0.9,
				max_width = 0.9,
				options = {},
			},
		})
	end,
	keys = {
		{
			"<leader>tr",
			function()
				require("neotest").run.run()
			end,
			desc = "Run Nearest",
		},
		{
			"<leader>tf",
			function()
				require("neotest").run.run(vim.fn.expand("%"))
			end,
			desc = "Run File",
		},
		{
			"<leader>ts",
			function()
				require("neotest").summary.toggle()
			end,
			desc = "Toggle Summary",
		},
		{
			"<leader>to",
			function()
				require("neotest").output.open({ enter = true, auto_close = true })
			end,
			desc = "Show Output",
		},
		{
			"<leader>tO",
			function()
				require("neotest").output_panel.toggle()
			end,
			desc = "Toggle Output Panel",
		},
		{
			"<leader>tS",
			function()
				require("neotest").run.stop()
			end,
			desc = "Stop",
		},
	},
}
