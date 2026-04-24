local colors = require("colors")
local icons = require("icons")
local settings = require("settings")

local volume_icon = sbar.add("item", "volume.icon", {
  position = "right",
  icon = { drawing = false },
  label = {
    string = icons.volume._100,
    width = 30,
    align = "left",
    font = {
      style = settings.font.style_map["Regular"],
      size = 14.0,
    },
    padding_left = 8,
    padding_right = 8,
  },
  background = { color = colors.transparent },
  popup = { align = "center" },
})

local volume_percent = sbar.add("item", "volume.percent", {
  position = "popup." .. volume_icon.name,
  label = {
    string = "??%",
    font = { family = settings.font.numbers, style = "Bold", size = 14.0 },
    width = 250,
    align = "center",
  },
  background = { height = 30 },
})

local volume_slider = sbar.add("slider", 210, {
  position = "popup." .. volume_icon.name,
  slider = {
    highlight_color = colors.blue,
    background = {
      height = 6,
      corner_radius = 3,
      color = colors.bg2,
    },
    knob = {
      string = "􀀁",
      drawing = true,
    },
  },
  background = { height = 2, y_offset = -4, color = colors.bg2, drawing = true },
  click_script = 'osascript -e "set volume output volume $PERCENTAGE"',
})

volume_icon:subscribe("volume_change", function(env)
  local volume = tonumber(env.INFO)
  local icon = icons.volume._0
  if volume > 90 then
    icon = icons.volume._100
  elseif volume > 50 then
    icon = icons.volume._66
  elseif volume > 25 then
    icon = icons.volume._33
  elseif volume > 0 then
    icon = icons.volume._10
  end

  volume_icon:set({ label = icon })
  volume_percent:set({ label = { string = volume .. "%" } })
  volume_slider:set({ slider = { percentage = volume } })
end)

local function volume_collapse_details()
  volume_icon:set({ popup = { drawing = false } })
end

local function volume_toggle_details(env)
  if env.BUTTON == "right" then
    sbar.exec("open /System/Library/PreferencePanes/Sound.prefpane")
    return
  end

  local should_draw = volume_icon:query().popup.drawing == "off"
  if should_draw then
    volume_icon:set({ popup = { drawing = true } })
  else
    volume_collapse_details()
  end
end

volume_icon:subscribe("mouse.clicked", volume_toggle_details)
volume_icon:subscribe("mouse.scrolled", function(env)
  sbar.exec('osascript -e "set volume output volume (output volume of (get volume settings) + ' .. env.SCROLL_DELTA .. ')"')
end)
volume_icon:subscribe("mouse.exited.global", volume_collapse_details)
