local colors = require("colors")
local icons = require("icons")
local settings = require("settings")

local island = sbar.add("item", "island", {
	position = "center",
	drawing = false,
	icon = {
		font = {
			style = settings.font.style_map["Bold"],
			size = 14.0,
		},
		padding_left = 15,
	},
	label = {
		font = {
			style = settings.font.style_map["Bold"],
			size = 14.0,
		},
		padding_right = 15,
	},
	background = {
		color = colors.bar.bg,
		corner_radius = 12,
		height = 28,
	},
})

local function display_island(icon, label)
	island:set({
		icon = { string = icon },
		label = { string = label },
		drawing = true,
	})

	-- Hide after 2 seconds
	sbar.delay(2, function()
		island:set({ drawing = false })
	end)
end

island:subscribe("volume_change", function(env)
	local volume = tonumber(env.INFO)
	local icon = icons.volume._0
	if volume > 90 then
		icon = icons.volume._100
	elseif volume > 50 then
		icon = icons.volume._66
	elseif volume > 25 then
		icon = icons.volume._33
	elseif volume > 0 then
		icon = icons.volume._10
	end

	display_island(icon, volume .. "%")
end)

-- You can add more subscriptions here (e.g., brightness, wifi change, etc.)
