local colors = require("colors")
local app_icons = require("app_icons")
local settings = require("settings")

local front_app = sbar.add("item", "front_app", {
  position = "q",
  icon = {
    font = "sketchybar-app-font:Regular:14.0",
    padding_left = 10,
    padding_right = 4,
  },
  label = {
    font = { family = settings.font.text, style = "Bold", size = 12 },
    padding_right = 10,
  },
  background = {
    color = colors.bg1,
    border_width = 1,
    border_color = colors.bar.border,
    corner_radius = 12,
    height = 30,
  },
})

front_app:subscribe({ "front_app_switched", "forced" }, function(env)
  local icon = app_icons.get_icon(env.INFO or "")

  front_app:set({
    icon = { 
      string = icon,
    },
    label = env.INFO or "",
  })
end)
