local colors = require("colors")

local clock = sbar.add("item", "clock", {
  position = "right",
  update_freq = 10,
  icon = { drawing = false },
  label = {
    padding_left = 8,
    padding_right = 8,
  },
  padding_left = 0,
  background = {
    color = colors.transparent,
  }
})

clock:subscribe({ "routine", "forced", "system_woke" }, function()
  clock:set({ label = os.date("%I:%M %p"):gsub("^0", "") })
end)
