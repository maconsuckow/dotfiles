local colors = require("colors")
local icons = require("icons")

-- Padding item required because of bracket
local apple = sbar.add("item", "apple", {
  position = "left",
  icon = {
    font = { size = 16.0 },
    string = icons.apple,
    padding_right = 10,
    padding_left = 10,
  },
  label = { drawing = false },
  popup = { background = { color = colors.popup.bg } },
})

local preferences = sbar.add("item", "preferences", {
  position = "popup." .. apple.name,
  icon = { string = icons.gear },
  label = { string = "Preferences" },
  background = { color = colors.transparent }
})

local activity = sbar.add("item", "activity", {
  position = "popup." .. apple.name,
  icon = { string = icons.activity },
  label = { string = "Activity" },
  background = { color = colors.transparent }
})

local lock = sbar.add("item", "lock", {
  position = "popup." .. apple.name,
  icon = { string = icons.lock },
  label = { string = "Lock" },
  background = { color = colors.transparent }
})

apple:subscribe({ "mouse.clicked" }, function()
  local drawing = apple:query().popup.drawing == "on"
  if not drawing then
    apple:set({ popup = { drawing = true } })
    return
  end
  apple:set({ popup = { drawing = false } })
end)
apple:subscribe("mouse.entered", "mouse.exited", function()
  local drawing = apple:query().popup.drawing == "on"
  if not drawing then
    apple:set({ popup = { drawing = true } })
    return
  end
  apple:set({ popup = { drawing = false } })
end)
apple:subscribe("mouse.exited.global", function()
  apple:set({ popup = { drawing = false } })
end)

preferences:subscribe({ "mouse.clicked" }, function()
  sbar.exec("open -a 'System Preferences';")

  apple:set({ popup = { drawing = false } })
end)

activity:subscribe({ "mouse.clicked" }, function()
  sbar.exec("open -a 'Activity Monitor';")

  apple:set({ popup = { drawing = false } })
end)

lock:subscribe({ "mouse.clicked" }, function()
  sbar.exec("pmset displaysleepnow;")

  apple:set({ popup = { drawing = false } })
end)
