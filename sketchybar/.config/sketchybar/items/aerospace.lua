local colors = require("colors")
local icons = require("icons")
local icon_map = require("icon_map")
local spaces = {}

local spaceConfigs = {
	["T"] = { family = "sketchybar-app-font", icon = icon_map["kitty"], name = "Terminal" },
	["P"] = { family = "JetBrainsMono Nerd Font", icon = icons.applications.process, name = "Process" },
	["B"] = { family = "sketchybar-app-font", icon = icon_map["Arc"], name = "Browsing" },
	["C"] = { family = "sketchybar-app-font", icon = icon_map["Messages"], name = "Communication" },
	["D"] = { family = "JetBrainsMono Nerd Font", icon = icons.applications.database, name = "Database" },
	["S"] = { family = "sketchybar-app-font", icon = icon_map["Spotify"], name = "Spotify" },
	["M"] = { family = "JetBrainsMono Nerd Font", icon = icons.applications.macos_cmd, name = "MacOS" },
	["O"] = { family = "sketchybar-app-font", icon = icon_map["Obsidian"], name = "Obsidian" },
}

local function selectCurrentWorkspace(focusedWorkspaceName)
	for sid, item in pairs(spaces) do
		if item ~= nil then
			local isSelected = sid == "workspaces." .. focusedWorkspaceName
			item:set({
				icon = {
					color = isSelected and colors.bg1 or colors.white,
					padding_right = isSelected and 10 or 0,
					padding_left = isSelected and 10 or 0,
				},
				label = {
					color = isSelected and colors.bg1 or colors.white,
					width = isSelected and "dynamic" or 0,
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
	local spaceConfig = spaceConfigs[workspaceName]

	spaces[spaceName] = sbar.add("item", spaceName, {
		label = {
			width = 0,
			padding_left = 0,
			padding_right = 10,
			string = spaceConfig.name,
		},
		icon = {
			font = {
				family = spaceConfig.family,
				style = "Regular",
				size = 16,
			},
			padding_right = 0,
			padding_left = 0,
			string = spaceConfig.icon,
			color = colors.white,
		},
		background = {
			border_width = 0,
			height = 20,
		},
		click_script = "aerospace workspace " .. workspaceName,
	})

	spaces[spaceName]:subscribe("mouse.entered", function()
		sbar.animate("tanh", 30, function()
			spaces[spaceName]:set({ label = { width = "dynamic" }, icon = { padding_right = 10 } })
		end)
	end)

	spaces[spaceName]:subscribe("mouse.exited", function()
		local background = spaces[spaceName]:query().geometry.background

		local isSelected = false
		if background ~= nil then
			isSelected = background.color == "0xffe2e2e3"
		end

		sbar.animate("tanh", 30, function()
			spaces[spaceName]:set({
				label = { width = isSelected and "dynamic" or 0 },
				icon = { padding_right = isSelected and 10 or 0 },
			})
		end)
	end)

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
			"workspaces.T",
			"workspaces.P",
			"workspaces.B",
			"workspaces.C",
			"workspaces.D",
			"workspaces.S",
			"workspaces.M",
			"workspaces.O",
		}, {
			background = {
				color = colors.transparent,
				height = 30,
				border_color = colors.grey,
				border_width = 1,
			},
		})

		findAndSelectCurrentWorkspace()
	end)
end

createWorkspaces()
