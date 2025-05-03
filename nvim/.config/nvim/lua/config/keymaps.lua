-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
--
-- vim.keymap.set("n", "<leader>o", "o<Esc>k")
-- vim.keymap.set("n", "<leader>O", "O<Esc>j")

local map = LazyVim.safe_keymap_set

map("i", "jk", "<Esc>", { noremap = true })
map("i", "jj", "<Esc>", { noremap = true })

print("keymaps loaded")
