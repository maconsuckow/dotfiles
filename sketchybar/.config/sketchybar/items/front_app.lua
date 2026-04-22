local colors = require("colors")
local app_icons = require("app_icons")

local front_app = sbar.add("item", "front_app", {
	position = "left",
	icon = {
		padding_left = 10,
		padding_right = 0,
    font = "sketchybar-app-font:Regular:14.0",
	},
	label = {
		padding_right = 10,
	},
	background = {
		color = colors.bar.bg,
	},
})

front_app:subscribe({ "front_app_switched", "forced" }, function(env)
	local icon = app_icons.get_icon(env.INFO or "")

	front_app:set({
		icon = { 
			string = icon,
      font = "sketchybar-app-font:Regular:14.0",
		},
		label = env.INFO or "",
	})
end)
