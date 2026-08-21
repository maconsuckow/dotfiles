local M = {}

local STATE_PATH = vim.fn.stdpath("state") .. "/theme-select-active.txt"

-- Legacy/default themes that are usually built-in to Neovim and can be filtered out
local DEFAULT_THEMES = {
	["blue"] = true,
	["darkblue"] = true,
	["delek"] = true,
	["desert"] = true,
	["elflord"] = true,
	["evening"] = true,
	["industry"] = true,
	["koehler"] = true,
	["morning"] = true,
	["murphy"] = true,
	["pmenu"] = true,
	["ron"] = true,
	["shine"] = true,
	["slate"] = true,
	["torte"] = true,
	["zellner"] = true,
	["default"] = true,
	["habamax"] = true,
	["lunaperche"] = true,
	["quiet"] = true,
	["retrobox"] = true,
	["sorbet"] = true,
	["wildcharm"] = true,
	["zaibatsu"] = true,
}

-- Returns a sorted list of all installed colorschemes, excluding standard default ones
function M.get_themes()
	local all_themes = vim.fn.getcompletion("", "color")
	local filtered = {}
	for _, theme in ipairs(all_themes) do
		if not DEFAULT_THEMES[theme] then
			table.insert(filtered, theme)
		end
	end
	if #filtered == 0 then
		return all_themes
	end
	table.sort(filtered)
	return filtered
end

-- Read the persisted theme name from the state file
function M.get_saved_theme()
	local f = io.open(STATE_PATH, "r")
	if not f then
		return nil
	end
	local theme = f:read("*all")
	f:close()
	return theme:gsub("%s+", "") -- trim whitespace
end

-- Persist the selected theme name to the state file
function M.save_theme(theme)
	local f = io.open(STATE_PATH, "w")
	if f then
		f:write(theme)
		f:close()
		return true
	end
	return false
end

-- Apply transparency and other overrides globally
function M.apply_overrides()
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
	vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })
	vim.api.nvim_set_hl(0, "FloatTitle", { bg = "none" })
	vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })

	local snacks_hls = {
		"SnacksPickerTitle",
		"SnacksPickerSubtitle",
		"SnacksPickerHeader",
		"SnacksPickerPrompt",
	}
	for _, hl in ipairs(snacks_hls) do
		vim.api.nvim_set_hl(0, hl, { bg = "none" })
	end
end

-- Open the custom interactive theme selector menu
function M.open()
	local themes = M.get_themes()
	local current_theme = vim.g.colors_name or "default"
	local original_theme = current_theme
	local confirmed = false

	-- Setup scratch buffer
	local buf = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_set_option_value("bufhidden", "wipe", { buf = buf })
	vim.api.nvim_set_option_value("modifiable", true, { buf = buf })

	-- Build buffer lines and highlight active theme
	local lines = {}
	local initial_index = 1
	for i, theme in ipairs(themes) do
		if theme == current_theme then
			table.insert(lines, "  ● " .. theme)
			initial_index = i
		else
			table.insert(lines, "    " .. theme)
		end
	end
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

	-- Apply highlights to the buffer
	local ns_id = vim.api.nvim_create_namespace("theme_select")
	for i, theme in ipairs(themes) do
		if theme == current_theme then
			-- Highlight the dot marker and make active theme bold
			vim.api.nvim_buf_add_highlight(buf, ns_id, "Character", i - 1, 2, 5)
			vim.api.nvim_buf_add_highlight(buf, ns_id, "Bold", i - 1, 4, -1)
		else
			-- Dim non-active themes slightly
			vim.api.nvim_buf_add_highlight(buf, ns_id, "Comment", i - 1, 4, -1)
		end
	end

	vim.api.nvim_set_option_value("modifiable", false, { buf = buf })

	-- Define window dimensions & position
	local width = 45
	local max_height = 15
	local height = math.min(max_height, #themes)
	local row = math.floor((vim.o.lines - height) / 2) - 1
	local col = math.floor((vim.o.columns - width) / 2)

	local win_opts = {
		relative = "editor",
		width = width,
		height = height,
		row = row,
		col = col,
		style = "minimal",
		border = "rounded",
		title = " 🎨 Select Theme ",
		title_pos = "center",
		footer = " 󰌑 Confirm | ⎋ Cancel ",
		footer_pos = "center",
	}

	-- Open the floating window
	local win = vim.api.nvim_open_win(buf, true, win_opts)
	vim.api.nvim_set_option_value("cursorline", true, { win = win })

	-- Set initial cursor position on current theme
	vim.api.nvim_win_set_cursor(win, { initial_index, 0 })

	-- Helper to close menu safely
	local function close_menu()
		pcall(vim.api.nvim_del_augroup_by_name, "ThemeSelectPreview")
		if vim.api.nvim_win_is_valid(win) then
			vim.api.nvim_win_close(win, true)
		end
	end

	-- Keybindings
	local keymap_opts = { noremap = true, silent = true, buffer = buf }

	-- Confirm selection
	vim.keymap.set("n", "<CR>", function()
		confirmed = true
		local cursor_row = vim.api.nvim_win_get_cursor(win)[1]
		local selected_theme = themes[cursor_row]
		if selected_theme then
			M.save_theme(selected_theme)
			pcall(vim.cmd.colorscheme, selected_theme)
			M.apply_overrides()
			vim.notify("🎨 Theme applied & saved: " .. selected_theme, vim.log.levels.INFO)
		end
		close_menu()
	end, keymap_opts)

	-- Abort selection
	local function abort()
		close_menu()
		pcall(vim.cmd.colorscheme, original_theme)
		M.apply_overrides()
	end

	vim.keymap.set("n", "<Esc>", abort, keymap_opts)
	vim.keymap.set("n", "q", abort, keymap_opts)

	-- Set up autocommand to restore original theme if window is closed without confirming
	vim.api.nvim_create_autocmd("BufWipeout", {
		buffer = buf,
		once = true,
		callback = function()
			if not confirmed then
				pcall(vim.cmd.colorscheme, original_theme)
				M.apply_overrides()
			end
		end,
	})

	-- Live preview autocommand on cursor movement
	local augroup = vim.api.nvim_create_augroup("ThemeSelectPreview", { clear = true })
	vim.api.nvim_create_autocmd("CursorMoved", {
		group = augroup,
		buffer = buf,
		callback = function()
			if vim.api.nvim_win_is_valid(win) then
				local cursor_row = vim.api.nvim_win_get_cursor(win)[1]
				local selected_theme = themes[cursor_row]
				if selected_theme then
					pcall(vim.cmd.colorscheme, selected_theme)
					M.apply_overrides()
				end
			end
		end,
	})
end

return M
