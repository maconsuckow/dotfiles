local settings = require("settings")
local icons = require("icons")
local colors = require("colors")

local cpu = sbar.add("item", "cpu", {
	position = "right",
	icon = {
		string = icons.memory,
		font = {
			style = settings.font.style_map["Regular"],
			size = 19.0,
		},
		padding_left = 10,
		padding_right = 10,
	},
	label = {
		font = {
			family = settings.font.numbers,
		},
		padding_right = 10,
	},
	update_freq = 60,
	background = {
		color = colors.transparent,
		height = 30,
		border_color = colors.grey,
		border_width = 1,
		padding_right = 10,
	},
})

cpu:subscribe({ "forced", "routine", "system_woke", "mouse_entered" }, function()
	sbar.exec("top -l 1 | awk '/^CPU usage:/ {print $3}' | tr -d '%' | cut -d \".\" -f1", function(cpu_info)
		cpu:set({ label = cpu_info .. "%" })
	end)
end)
