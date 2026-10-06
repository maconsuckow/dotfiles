local parsers = {
	"bash",
	"css",
	"html",
	"javascript",
	"jsdoc",
	"json", -- also used for jsonc on the main branch
	"lua",
	"luadoc",
	"markdown",
	"markdown_inline",
	"python",
	"regex",
	"sql",
	"toml",
	"tsx",
	"typescript",
	"vim",
	"vimdoc",
	"xml",
	"yaml",
}

return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	lazy = false, -- main branch does not support lazy-loading
	build = ":TSUpdate",
	config = function()
		-- No-op for parsers that are already installed (requires tree-sitter-cli)
		require("nvim-treesitter").install(parsers)

		-- Highlighting is built into Neovim; start it for any filetype with a parser
		vim.api.nvim_create_autocmd("FileType", {
			group = vim.api.nvim_create_augroup("treesitter_start", { clear = true }),
			callback = function(args)
				pcall(vim.treesitter.start, args.buf)
			end,
		})

		-- Incremental selection via Neovim's built-in `an` / `in` (parent / child node)
		vim.keymap.set("n", "<C-space>", "van", { remap = true, desc = "Start node selection" })
		vim.keymap.set("x", "<C-space>", "an", { remap = true, desc = "Expand to parent node" })
		vim.keymap.set("x", "<Backspace>", "in", { remap = true, desc = "Shrink to child node" })
	end,
}
