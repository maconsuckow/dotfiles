return {
	"stevearc/oil.nvim",
	enabled = false,
	opts = {
		-- Oil will take over directory buffers (e.g. `vim .` or `:e src/`)
		default_file_explorer = true,
		columns = {
			"icon",
			-- "permissions",
			-- "size",
			-- "mtime",
		},
		-- Buffer-local options to use for oil buffers
		buf_options = {
			buflisted = false,
			bufhidden = "hide",
		},
		-- Window-local options to use for oil buffers
		win_options = {
			wrap = false,
			signcolumn = "no",
			cursorcolumn = false,
			foldcolumn = "0",
			spell = false,
			list = false,
			conceallevel = 3,
			concealcursor = "nvic",
		},
		-- Keymaps in oil buffer
		keymaps = {
			["g?"] = "actions.show_help",
			["<CR>"] = "actions.select",
			["<C-s>"] = "actions.select_vsplit",
			["<C-h>"] = "actions.select_split",
			["<C-t>"] = "actions.select_tab",
			["<C-p>"] = "actions.preview",
			["<C-c>"] = "actions.close",
			["<C-l>"] = "actions.refresh",
			["-"] = "actions.parent",
			["_"] = "actions.open_cwd",
			["`"] = "actions.cd",
			["~"] = "actions.tcd",
			["gs"] = "actions.change_sort",
			["gx"] = "actions.open_external",
			["g."] = "actions.toggle_hidden",
			["g\\"] = "actions.toggle_trash",
		},
		-- Set to false to disable all of the above keymaps
		use_default_keymaps = true,
		view_options = {
			-- Show files and directories that start with "."
			show_hidden = false,
			-- This function defines what is considered a "hidden" file
			is_hidden_file = function(name, bufnr)
				return vim.startswith(name, ".")
			end,
			-- This function defines what will never be displayed, even when "show_hidden" is set
			is_always_hidden_file = function(name, bufnr)
				return false
			end,
			sort = {
				-- sort order can be "asc" or "desc"
				-- see :help oil-columns to see which columns are sortable
				{ "type", "asc" },
				{ "name", "asc" },
			},
		},
		-- Configuration for the floating window in oil.open_float
		float = {
			-- Padding around the floating window
			padding = 2,
			max_width = 80,
			max_height = 20,
			border = "rounded",
			win_options = {
				winhl = "Normal:OilFloat",
			},
			-- preview_split: 'auto', 'left', 'right', 'top', 'bottom'
			preview_split = "auto",
			-- This is the config that will be passed to nvim_open_win.
			-- Change values here to customize the layout
			override = function(conf)
				return conf
			end,
		},
	},
	-- Optional dependencies
	dependencies = { "nvim-tree/nvim-web-devicons" },
	keys = {
		{
			"-",
			function()
				require("oil").open_float()
			end,
			desc = "Open Oil floating window",
		},
	},
}
