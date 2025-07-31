local settings = require("settings")
local colors = require("colors")
local icons = require("icons")

local clock = sbar.add("item", "clock", {
  position = "right",
  icon = {
    string = icons.calendar,
    font = {
      style = settings.font.style_map["Regular"],
      size = 19.0,
    },
    padding_left = 10,
  },
  update_freq = 10,
  label = {
    padding_right = 10,
  },
  background = {
    color = colors.bar.bg
  }
})

clock:subscribe({ "routine", "forced", "system_work" }, function()
  clock:set({ label = os.date("%a %b %d %I:%M %p") })
end)
