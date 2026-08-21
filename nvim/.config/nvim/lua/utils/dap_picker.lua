local M = {}

local function process_label(proc, opts)
	if opts.label then
		return opts.label(proc)
	end

	return string.format("id=%d name=%s", proc.pid, proc.name)
end

function M.pick_process(opts)
	opts = opts or {}

	local dap = require("dap")
	local dap_ui = require("dap.ui")
	local dap_utils = require("dap.utils")
	local processes = dap_utils.get_processes(opts)

	if vim.tbl_isempty(processes) then
		vim.notify("No running processes found for DAP attach", vim.log.levels.INFO)
		return dap.ABORT
	end

	local selected = dap_ui.pick_one_sync(processes, opts.prompt or "Select process:", function(proc)
		return process_label(proc, opts)
	end)

	return selected and selected.pid or dap.ABORT
end

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
