return {
	"rebelot/kanagawa.nvim",
    branch="master",
    config=function()
        require('kanagawa').setup({
            transparent=true,
            commentStyle = { italic = true },
		colors = {
			theme = {
				all = {
					ui = {
						bg_gutter = "none",
					},
				},
			},
		},
            theme = "dragon",
            overrides=function(colors)
                return {
				NormalFloat = { bg = "none" },
				FloatBorder = { bg = "none" },
				FloatTitle = { bg = "none" },
				CursorLineNr = { fg = "none" },
				StatusLine = { bg = "none" },
				StatusLineNC = { bg = "none" },

				BlinkCmpMenu = { bg = "none" },

				Pmenu = { fg = colors.theme.ui.shade0, bg = colors.theme.ui.bg_p1 }, -- add `blend = vim.o.pumblend` to enable transparency
				PmenuSel = { fg = "NONE", bg = colors.theme.ui.bg_p2 },
				PmenuSbar = { bg = colors.theme.ui.bg_m1 },
				PmenuThumb = { bg = colors.theme.ui.bg_p2 },
                    ["@markup.link.url.markdown_inline"] = { link = "Special" }, -- (url)
                    ["@markup.link.label.markdown_inline"] = { link = "WarningMsg" }, -- [label]
                    ["@markup.italic.markdown_inline"] = { link = "Exception" }, -- *italic*
                    ["@markup.raw.markdown_inline"] = { link = "String" }, -- `code`
                    ["@markup.list.markdown"] = { link = "Function" }, -- + list
                    ["@markup.quote.markdown"] = { link = "Error" }, -- > blockcode
                    ["@markup.list.checked.markdown"] = { link = "WarningMsg" } -- - [X] checked list item
                }
            end
        });
        vim.cmd("colorscheme kanagawa");
    end
}
