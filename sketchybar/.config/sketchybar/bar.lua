local colors = require("colors")

-- Equivalent to the --bar domain
sbar.bar({
	topmost = "window",
	height = 40,
	color = colors.bar.bg,
	padding_right = 5,
	padding_left = 5,
	display = "main",
	y_offset = 0,
	notch_width = 250,
	border_color = colors.grey,
})