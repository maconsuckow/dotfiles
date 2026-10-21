vim.opt.expandtab = true -- Convert tabs to spaces
vim.opt.shiftwidth = 2 -- Amount to indent with << and >>
vim.opt.tabstop = 2 -- How many spaces are shown per Tab
-- vim.opt.softtabstop = 4 -- How many spaces are applied when pressing Tab

vim.opt.smarttab = true
vim.opt.smartindent = false
vim.opt.autoindent = true -- Keep identation from previous line

-- Enable break indent
vim.opt.breakindent = true

-- Show absolute line numbers
vim.opt.number = true
vim.opt.relativenumber = false

-- Show line under cursor
vim.opt.cursorline = true

-- Store undos between sessions
vim.opt.undofile = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = "a"

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false
vim.opt.cmdheight = 0

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = "yes"

-- Faster completion, diagnostic floats, swap writes, and key sequence timeouts
vim.opt.updatetime = 200
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- Prompt to save changes before exiting modified buffer instead of failing
vim.opt.confirm = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Minimal number of screen lines/columns to keep around the cursor.
vim.opt.scrolloff = 5
vim.opt.sidescrolloff = 8

vim.g.have_nerd_font = true

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldcolumn = "0"
vim.opt.foldtext = ""
vim.opt.foldlevel = 99

vim.opt.wrap = false

vim.opt.conceallevel = 1

vim.opt.guifont = "JetBrainsMono Nerd Font"
vim.opt.guifontwide = "JetBrainsMono Nerd Font"

vim.g.ai_cmp = true

-- Enable 24-bit RGB color in the TUI
vim.opt.termguicolors = true

-- Default rounded border for floating windows (LSP hover, diagnostic floats, etc.)
vim.opt.winborder = "rounded"
vim.opt.smoothscroll = true
vim.opt.jumpoptions = "view"

local core_group = vim.api.nvim_create_augroup("core_autocmds", { clear = true })

-- Check if we need to reload the file when it changed externally (e.g. git or CLI agents)
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
	group = core_group,
	callback = function()
		if vim.o.buftype ~= "nofile" then
			vim.cmd("checktime")
		end
	end,
})

-- Resize splits if terminal window got resized
vim.api.nvim_create_autocmd("VimResized", {
	group = core_group,
	callback = function()
		local current_tab = vim.fn.tabpagenr()
		vim.cmd("tabdo wincmd =")
		vim.cmd("tabnext " .. current_tab)
	end,
})

-- Go to last location when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
	group = core_group,
	callback = function(event)
		local exclude = { "gitcommit" }
		local buf = event.buf
		if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].lazyvim_last_loc then
			return
		end
		vim.b[buf].lazyvim_last_loc = true
		local mark = vim.api.nvim_buf_get_mark(buf, '"')
		local lcount = vim.api.nvim_buf_line_count(buf)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

-- Close utility filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
	group = core_group,
	pattern = {
		"checkhealth",
		"dbout",
		"gitsigns-blame",
		"help",
		"lspinfo",
		"man",
		"notify",
		"qf",
		"startuptime",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.schedule(function()
			vim.keymap.set("n", "q", function()
				vim.cmd("close")
				pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
			end, {
				buffer = event.buf,
				silent = true,
				desc = "Quit buffer",
			})
		end)
	end,
})
-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	group = core_group,
	callback = function()
		vim.hl.on_yank()
	end,
})

-- Keep floating windows, signcolumn, and Snacks picker headers transparent across colorschemes
vim.api.nvim_create_autocmd("ColorScheme", {
	group = core_group,
	callback = function()
		local transparent_hls = {
			"NormalFloat",
			"FloatBorder",
			"FloatTitle",
			"SignColumn",
			"SnacksPickerTitle",
			"SnacksPickerSubtitle",
			"SnacksPickerHeader",
			"SnacksPickerPrompt",
		}
		for _, hl in ipairs(transparent_hls) do
			vim.api.nvim_set_hl(0, hl, { bg = "none" })
		end
	end,
})

local swap_group = vim.api.nvim_create_augroup("swapfile_handling", { clear = true })

-- Obsidian vault: no swap files (the Obsidian app edits these notes too, and
-- killed sessions left hundreds of stale swaps that triggered E325 prompts)
vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
	group = swap_group,
	pattern = vim.fn.expand("~/Documents/Personal") .. "/*",
	callback = function()
		vim.opt_local.swapfile = false
	end,
})

-- Silently delete stale swap files: owner process gone and no unsaved changes.
-- Swaps with unsaved changes still prompt so they can be recovered.
vim.api.nvim_create_autocmd("SwapExists", {
	group = swap_group,
	callback = function()
		-- No hostname check: the swap dir is local, and this Mac's hostname changes per network
		local info = vim.fn.swapinfo(vim.v.swapname)
		if info.error then
			return
		end
		local running = info.pid > 0 and vim.uv.kill(info.pid, 0) == 0
		if not running and info.dirty == 0 then
			vim.v.swapchoice = "d"
		end
	end,
})
