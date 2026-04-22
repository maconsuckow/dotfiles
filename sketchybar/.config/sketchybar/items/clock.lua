local colors = require("colors")

local clock = sbar.add("item", "clock", {
  position = "right",
  update_freq = 10,
  background = {
    color = colors.transparent,
  }
})

clock:subscribe({ "routine", "forced", "system_work" }, function()
  clock:set({ label = os.date("%I:%M %p") })
end)
