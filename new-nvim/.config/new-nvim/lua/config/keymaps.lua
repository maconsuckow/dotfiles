-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

vim.keymap.set("n", "<leader>|", "<C-W>v", { desc = "Horizontal Split" })
vim.keymap.set("n", "<leader>-", "<C-W>s", { desc = "Vertical Split" })

vim.keymap.set("n", "<leader>l", "<cmd>Lazy<CR>", { desc = "Open Lazy" })

vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })

vim.keymap.set("n", "<leader>bd", function()
	Snacks.bufdelete()
end, { desc = "Delete Buffer" })
vim.keymap.set("n", "<leader>bo", function()
	Snacks.bufdelete.other()
end, { desc = "Delete Other Buffers" })

-- better indenting
vim.keymap.set("v", "<", "<gv", { desc = "Indent Left" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent Right" })

vim.keymap.set("n", "<leader><space>", function()
	Snacks.picker.smart()
end, { desc = "Smart Find Files" })
vim.keymap.set("n", "<leader>,", function()
	Snacks.picker.buffers()
end, { desc = "Buffers" })
vim.keymap.set("n", "<leader>/", function()
	Snacks.picker.grep()
end, { desc = "Grep" })
vim.keymap.set("n", "<leader>:", function()
	Snacks.picker.command_history()
end, { desc = "Command History" })
vim.keymap.set("n", "<leader>n", function()
	Snacks.picker.notifications()
end, { desc = "Notification History" })
-- vim.keymap.set("n", "<leader>e", function()
-- 	Snacks.explorer()
-- end, { desc = "File Explorer" })

-- Jump to the definition of the word under your cursor.
--  This is where a variable was first declared, or where a function is defined, etc.
--  To jump back, press <C-t>.
vim.keymap.set("n", "gd", Snacks.picker.lsp_definitions, { desc = "LSP: [G]oto [D]efinition" })
-- vim.keymap.set("n", "gd", require("fzf-lua").lsp_definitions, { desc = "LSP: [G]oto [D]efinition" })

-- Find references for the word under your cursor.
-- vim.keymap.set("n", "gr", require("fzf-lua").lsp_references, { desc = "LSP: [G]oto [R]eferences" })
vim.keymap.set("n", "gr", Snacks.picker.lsp_references, { desc = "LSP: [G]oto [R]eferences" })

-- Jump to the implementation of the word under your cursor.
--  Useful when your language has ways of declaring types without an actual implementation.
vim.keymap.set("n", "gI", require("fzf-lua").lsp_implementations, { desc = "LSP: [G]oto [I]mplementation" })

-- Jump to the type of the word under your cursor.
--  Useful when you're not sure what type a variable is and you want to see
--  the definition of its *type*, not where it was *defined*.
vim.keymap.set("n", "<leader>D", require("fzf-lua").lsp_typedefs, { desc = "Type [D]efinition" })

-- Fuzzy find all the symbols in your current document.
--  Symbols are things like variables, functions, types, etc.
vim.keymap.set("n", "<leader>ds", require("fzf-lua").lsp_document_symbols, { desc = "[D]ocument [S]ymbols" })

-- Fuzzy find all the symbols in your current workspace.
--  Similar to document symbols, except searches over your entire project.
vim.keymap.set(
	"n",
	"<leader>ws",
	require("fzf-lua").lsp_live_workspace_symbols,
	{ desc = "LSP: [W]orkspace [S]ymbols" }
)

-- Rename the variable under your cursor.
--  Most Language Servers support renaming across files, etc.
vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { desc = "LSP: [R]e[n]ame" })

-- Execute a code action, usually your cursor needs to be on top of an error
-- or a suggestion from your LSP for this to activate.
vim.keymap.set({ "n", "x" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "[C]ode [A]ction" })

vim.keymap.set("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })

-- WARN: This is not Goto Definition, this is Goto Declaration.
--  For example, in C this would take you to the header.
vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "[G]oto [D]eclaration" })
