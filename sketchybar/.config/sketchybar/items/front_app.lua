local icons = require("icons")
local icon_map = require("icon_map")
local colors = require("colors")

local front_app = sbar.add("item", "front_app", {
	position = "left",
	icon = {
		padding_left = 10,
		padding_right = 0,
	},
	label = {
		padding_right = 10,
	},
	background = {
		color = colors.bar.bg,
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

	if env.INFO == "Activity Monitor" then
		icon = {
			string = icon_map["Activity Monitor"],
			font = {
				family = "sketchybar-app-font",
				style = "Regular",
			},
		}
	end

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
