local settings = require("settings")
local icons = require("icons")
local colors = require("colors")

local memory = sbar.add("item", "memory", {
	position = "e",
	icon = {
		string = icons.cpu,
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
	update_freq = 10,
	background = {
		color = colors.transparent,
		height = 30,
		border_color = colors.grey,
		border_width = 1,
	},
})

memory:subscribe({ "forced", "routine", "system_woke", "mouse_entered" }, function()
	sbar.exec(
		"vm_stat | awk '/Pages free:/ {free=$3} /Pages active:/ {active=$3} /Pages inactive:/ {inactive=$3} /Pages speculative:/ {speculative=$3} END {total=free + active + inactive + speculative; used=active + inactive; print int(100*used/total)}'",
		function(memory_info)
			memory:set({ label = memory_info .. "%" })
		end
	)
end)
