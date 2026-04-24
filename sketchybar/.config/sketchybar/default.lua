local settings = require("settings")
local colors = require("colors")

-- Equivalent to the --default domain
sbar.default({
  updates = "when_shown",
  icon = {
    font = "sketchybar-app-font:Regular:14.0",
    color = colors.white,
    padding_left = 10,
    -- padding_right = 10,
    background = {
      color = colors.transparent,
      image = {
        corner_radius = 9
      }
    },
  },
  label = {
    font = {
      family = settings.font.text,
      style = settings.font.style_map["Semibold"],
      size = 13.0,
    },
    color = colors.white,
    background = {
      color = colors.transparent
    },
    padding_left = 10,
    padding_right = 10,
  },
  background = {
    height = 30,
    corner_radius = 12,
    border_width = 0,
    border_color = colors.bar.border,
    color = colors.bar.bg,
    image = {
      corner_radius = 9,
    },
  },
  popup = {
    blur_radius = 30,
    background = {
      border_width = 1,
      corner_radius = 15,
      border_color = colors.popup.border,
      color = colors.popup.bg,
      shadow = { drawing = true },
    },
  },
  padding_left = 5,
  padding_right = 5,
  scroll_texts = true,
})
