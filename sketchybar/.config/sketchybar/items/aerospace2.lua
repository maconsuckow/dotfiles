local colors = require("colors")
local icons = require("icons")
local spaces = {}

local function selectCurrentWorkspace(focusedWorkspaceName)
	for sid, item in pairs(spaces) do
		if item ~= nil then
			local isSelected = sid == "workspaces." .. focusedWorkspaceName
			item:set({
				icon = {
					color = isSelected and colors.bg1 or colors.white,
					padding_right = isSelected and 10 or 0,
					padding_left = isSelected and 10 or 0,
					string = isSelected and icons.dot.filled or icons.dot.empty,
				},
				background = { color = isSelected and colors.white or colors.transparent },
			})
		end
	end

	sbar.trigger("update_windows")
end

local function findAndSelectCurrentWorkspace()
	sbar.exec("aerospace list-workspaces --focused", function(focusedWorkspaceOutput)
		local focusedWorkspaceName = focusedWorkspaceOutput:match("[^\r\n]+")
		selectCurrentWorkspace(focusedWorkspaceName)
	end)
end

local function addWorkspaceItem(workspaceName)
	local spaceName = "workspaces." .. workspaceName

	spaces[spaceName] = sbar.add("item", spaceName, {
		icon = {
			font = {
				family = "JetBrainsMono Nerd Font",
				style = "Regular",
				size = 16,
			},
			string = icons.dot.empty,
		},
		background = {
			border_width = 0,
			height = 20,
		},
	})

	spaces[spaceName]:subscribe("aerospace_workspace_change", function(env)
		selectCurrentWorkspace(env.FOCUSED_WORKSPACE)
		sbar.trigger("update_windows")
	end)
end

local function createWorkspaces()
	sbar.exec("aerospace list-workspaces --all", function(workspacesOutput)
		for workspaceName in workspacesOutput:gmatch("[^\r\n]+") do
			addWorkspaceItem(workspaceName)
		end

		sbar.add("bracket", "aerospace.bracket", {
			"workspaces.1",
			"workspaces.2",
			"workspaces.3",
			"workspaces.4",
			"workspaces.5",
			"workspaces.6",
			"workspaces.7",
			"workspaces.8",
		}, {})

		findAndSelectCurrentWorkspace()
	end)
end

createWorkspaces()
