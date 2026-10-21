local M = {}

function M.dap_configurations()
	local dap = require("dap")
	local dap_ui = require("dap.ui")
	local current_filetype = vim.bo.filetype
	local configurations = dap.configurations[current_filetype] or {}

	if vim.tbl_isempty(configurations) then
		vim.notify("No DAP configurations found for filetype: " .. current_filetype, vim.log.levels.INFO)
		return
	end

	local selected = dap_ui.pick_one_sync(configurations, "Select debug action:", function(config)
		local request = config.request or "unknown"
		local name = config.name or "Unnamed configuration"
		return string.format("[%s] %s", request, name)
	end)

	if selected then
		dap.run(selected)
	end
end

return M
