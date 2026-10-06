-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
vim.keymap.set("n", "]e", function()
	vim.diagnostic.jump({ severity = vim.diagnostic.severity.ERROR, count = 1 })
end, { desc = "Next [E]rror" })
vim.keymap.set("n", "[e", function()
	vim.diagnostic.jump({ severity = vim.diagnostic.severity.ERROR, count = -1 })
end, { desc = "Previous [E]rror" })
vim.keymap.set("n", "]w", function()
	vim.diagnostic.jump({ severity = vim.diagnostic.severity.WARN, count = 1 })
end, { desc = "Next [W]arning" })
vim.keymap.set("n", "[w", function()
	vim.diagnostic.jump({ severity = vim.diagnostic.severity.WARN, count = -1 })
end, { desc = "Previous [W]arning" })

vim.keymap.set("n", "<leader>|", "<C-W>v", { desc = "Horizontal Split" })
vim.keymap.set("n", "<leader>_", "<C-W>s", { desc = "Vertical Split" })

vim.keymap.set("n", "]b", "<cmd>bnext<CR>", { desc = "Next Buffer" })
vim.keymap.set("n", "[b", "<cmd>bprevious<CR>", { desc = "Previous Buffer" })

vim.keymap.set("n", "<C-Up>", "<cmd>resize +2<CR>", { desc = "Increase Window Height" })
vim.keymap.set("n", "<C-Down>", "<cmd>resize -2<CR>", { desc = "Decrease Window Height" })
vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<CR>", { desc = "Decrease Window Width" })
vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<CR>", { desc = "Increase Window Width" })

vim.keymap.set("i", "jk", "<Esc>", { desc = "Exit insert mode", remap = true })

vim.keymap.set("n", "<leader>wd", "<C-W>c", { desc = "Delete Window", remap = true })

vim.keymap.set("n", "<leader>l", "<cmd>Lazy<CR>", { desc = "Open Lazy" })

vim.keymap.set("n", "<leader>uc", function()
	require("theme-select").open()
end, { desc = "Colorscheme Picker" })

vim.keymap.set("n", "<leader>cp", function()
	local path = vim.fn.expand("%:.")
	vim.fn.setreg("+", path)
	vim.notify('Copied "' .. path .. '" to clipboard')
end, { desc = "Copy relative file path" })

vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })

vim.keymap.set("t", "<C-h>", "<C-\\><C-n><C-w>h", { desc = "Go to Left Window", remap = true })
vim.keymap.set("t", "<C-j>", "<C-\\><C-n><C-w>j", { desc = "Go to Lower Window", remap = true })
vim.keymap.set("t", "<C-k>", "<C-\\><C-n><C-w>k", { desc = "Go to Upper Window", remap = true })
vim.keymap.set("t", "<C-l>", "<C-\\><C-n><C-w>l", { desc = "Go to Right Window", remap = true })

-- better indenting
vim.keymap.set("v", "<", "<gv", { desc = "Indent Left" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent Right" })

vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP: [C]ode [A]ction" })
vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { desc = "LSP: [R]e[n]ame" })
vim.keymap.set("n", "<leader>cc", vim.lsp.codelens.run, { desc = "LSP: [C]odelens Run" })
vim.keymap.set("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
vim.keymap.set("n", "<leader>co", function()
	local bufnr = vim.api.nvim_get_current_buf()
	local file = vim.api.nvim_buf_get_name(bufnr)
	local vtsls = vim.lsp.get_clients({ bufnr = bufnr, name = "vtsls" })[1]

	if vtsls then
		vtsls:request("workspace/executeCommand", {
			command = "typescript.organizeImports",
			arguments = { file },
		}, function(err)
			if err then
				vim.notify("Organize imports failed: " .. err.message, vim.log.levels.WARN)
			end
		end, bufnr)
		return
	end

	vim.lsp.buf.code_action({ context = { only = { "source.organizeImports" } }, apply = true })
end, { desc = "LSP: Organize Imports" })
vim.keymap.set("n", "<C-s>", "<cmd>w<CR>", { desc = "Save" })

-- Built-in undo tree (Neovim 0.12+)
vim.cmd.packadd("nvim.undotree")
vim.keymap.set("n", "<leader>uu", "<cmd>Undotree<CR>", { desc = "Toggle Undotree" })
vim.keymap.set("n", "ZZ", "<cmd>wq<CR>", { desc = "Save And Quit" })
