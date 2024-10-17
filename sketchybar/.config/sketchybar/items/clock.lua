local colors = require("colors")

local clock = sbar.add("item", "clock", {
	position = "right",
	icon = {
		drawing = false,
	},
	update_freq = 10,
	label = {
		padding_right = 10,
		padding_left = 0,
	},
	popup = { background = { color = colors.popup.bg } },
})

clock:subscribe({ "routine", "forced", "system_work" }, function()
	clock:set({ label = os.date("%a %b %d %I:%M %p") })
end)
