-- ~/.config/nvim/lua/utils/dap_picker.lua (or wherever you prefer)
local M = {}

function M.dap_configurations()
	local dap = require("dap")
	local fzf_lua = require("fzf-lua")

	local current_filetype = vim.bo.filetype
	local configurations = dap.configurations[current_filetype] or {}

	if #configurations == 0 then
		vim.notify("No DAP configurations found for filetype: " .. current_filetype, vim.log.levels.INFO)
		return
	end

	local choices = {}
	local config_map = {}
	for i, config in ipairs(configurations) do
		local entry_name = string.format("[%s] %s", config.request, config.name)
		table.insert(choices, entry_name)
		config_map[entry_name] = config
	end

	fzf_lua.fzf_exec(choices, {
		prompt = "DAP Configuration > ",
		winopts = {
			height = 0.5,
			width = 0.5,
			row = 0.25,
			col = 0.25,
			border = "rounded",
		},
		actions = {
			["default"] = function(selected_lines)
				if #selected_lines > 0 then
					local selected_entry = selected_lines[1]
					local config = config_map[selected_entry]
					if config then
						dap.run(config)
					end
				end
			end,
		},
	})
end

return M
