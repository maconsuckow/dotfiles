local colors = require("colors")

-- Equivalent to the --bar domain
sbar.bar({
  topmost = "window",
  height = 45,
  color = colors.bar.bg,
  border_width = 1,
  border_color = colors.bar.border,
  blur_radius = 30,
  position = "top",
  padding_right = 10,
  padding_left = 10,
  y_offset = 10,
  margin = 10,
  corner_radius = 15,
  display = "main",
})
