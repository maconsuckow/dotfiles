-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- vim.api.nvim_create_autocmd("User", {
-- 	pattern = "OilEnter",
-- 	callback = vim.schedule_wrap(function(args)
-- 		require("oil").open_preview()
-- 		-- if vim.api.nvim_get_current_buf() == args.data.buf and oil.get_cursor_entry() then
-- 		-- 	oil.open_preview()
-- 		-- end
-- 	end),
-- })
