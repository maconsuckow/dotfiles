return {
	"saghen/blink.cmp",
	dependencies = {
		"rafamadriz/friendly-snippets",
		"saghen/blink.compat",
		"hrsh7th/nvim-cmp",
	},
	version = "1.*",
	opts = {
		keymap = {
			preset = "default",
			["<C-y>"] = { "select_and_accept" },
		},
		appearance = {
			nerd_font_variant = "mono",
			kind_icons = {
				Keyword = " ",
				Function = " ",
				Variable = " ",
				obsidian = "󱞶",
				obsidian_new = "󱞶",
				obsidian_tags = "󰓹",
			},
		},
		completion = {
			accept = {
				auto_brackets = {
					enabled = false,
				},
			},
			menu = {
				border = "rounded",
				winhighlight = "Normal:BlinkCmpSignatureHelp,FloatBorder:BlinkCmpSignatureHelpBorder",
				auto_show = true,
				scrollbar = false,
				draw = {
					columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind" }, { "source_name" } },
					treesitter = { "lsp" },
				},
			},
			documentation = {
				auto_show = true,
				window = {
					border = "rounded",
					winhighlight = "Normal:BlinkCmpSignatureHelp,FloatBorder:BlinkCmpSignatureHelpBorder",
					max_width = 60,
					max_height = 20,
				},
			},
			ghost_text = {
				enabled = vim.g.ai_cmp,
			},
		},
		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
			per_filetype = {
				sql = { "lsp", "path", "snippets", "buffer", "dadbod" },
				markdown = { "obsidian", "obsidian_new", "obsidian_tags", "lsp", "path", "snippets", "buffer" },
			},
			providers = {
				lsp = {
					name = "lsp",
					enabled = true,
					module = "blink.cmp.sources.lsp",
					score_offset = 90,
				},
				dadbod = {
					name = "Dadbod",
					module = "vim_dadbod_completion.blink",
				},
			},
		},

		fuzzy = { implementation = "prefer_rust_with_warning" },
	},
	opts_extend = { "sources.default" },
}
