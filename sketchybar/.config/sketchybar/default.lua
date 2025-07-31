local settings = require("settings")
local colors = require("colors")

-- Equivalent to the --default domain
sbar.default({
  updates = "when_shown",
  icon = {
    font = {
      family = "sketchybar-app-font",
      style = "Regular",
      size = 14.0,
    },
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
    height = 35,
    -- padding_right = 10,
    -- padding_left = 10,
    corner_radius = 10,
    border_width = 2,
    color = colors.bar.bg,
    image = {
      corner_radius = 9,
    },
  },
  popup = {
    background = {
      border_width = 2,
      corner_radius = 9,
      border_color = colors.popup.border,
      color = colors.popup.bg,
      -- shadow = { drawing = true },
    },
    -- blur_radius = 50,
  },
  padding_left = 5,
  padding_right = 5,
  scroll_texts = true,
})
