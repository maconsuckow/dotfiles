local colors = require("colors")
local icons = require("icons")
local icon_map = require("icon_map")

local front_app = sbar.add("item", "front_app", {
	position = "q",
	icon = {
		padding_left = 10,
		padding_right = 10,
	},
	label = {
		padding_right = 10,
	},
})

front_app:subscribe({ "front_app_switched" }, function(env)
	local icon = {
		string = icons.applications.default,
		font = {
			family = "JetBrainsMono Nerd Font",
			style = "Regular",
		},
	}

	if env.INFO == "Chrome" then
		icon = {
			string = icon_map["Google Chrome"],
			font = {
				family = "sketchybar-app-font",
				style = "Regular",
			},
		}
	end

	local found = icon_map[env.INFO]
	if found then
		icon = {
			string = icon_map[env.INFO],
			font = {
				family = "sketchybar-app-font",
				style = "Regular",
			},
		}
	end

	front_app:set({
		icon = icon,
		label = env.INFO,
	})
end)
