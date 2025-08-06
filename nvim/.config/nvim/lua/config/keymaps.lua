-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

vim.keymap.set("n", "<leader>|", "<C-W>v", { desc = "Horizontal Split" })
vim.keymap.set("n", "<leader>-", "<C-W>s", { desc = "Vertical Split" })

vim.keymap.set("i", "jk", "<Esc>", { desc = "Exit insert mode", remap = true })

vim.keymap.set("n", "<leader>wd", "<C-W>c", { desc = "Delete Window", remap = true })

vim.keymap.set("n", "<leader>l", "<cmd>Lazy<CR>", { desc = "Open Lazy" })

vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })

-- better indenting
vim.keymap.set("v", "<", "<gv", { desc = "Indent Left" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent Right" })

vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP: [C]ode [A]ction" })
vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { desc = "LSP: [R]e[n]ame" })
vim.keymap.set("n", "<leader>cc", vim.lsp.codelens.run, { desc = "LSP: [C]odelens Run" })
vim.keymap.set("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
