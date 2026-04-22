local colors = require("colors")
local icons = require("icons")
local settings = require("settings")

local volume_icon = sbar.add("item", "volume.icon", {
  position = "right",
  icon = {
    drawing = false,
  },
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
  background = {
    color = colors.transparent,
  },
  popup = { align = "center" },
})

local volume_slider = sbar.add("slider", 250, {
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
  background = { height = 2, y_offset = -20 },
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
  volume_slider:set({ slider = { percentage = volume } })
end)

local function volume_collapse_details()
  local drawing = volume_icon:query().popup.drawing == "on"
  if not drawing then
    return
  end
  volume_icon:set({ popup = { drawing = false } })
  sbar.remove("/volume.device\\.*/")
  sbar.remove("volume.header")
  sbar.remove("volume.device_header")
end

local current_audio_device = "None"
local function volume_toggle_details(env)
  if env.BUTTON == "right" then
    sbar.exec("open /System/Library/PreferencePanes/Sound.prefpane")
    return
  end

  local should_draw = volume_icon:query().popup.drawing == "off"
  if should_draw then
    volume_icon:set({ popup = { drawing = true } })

    -- Add Volume header and percentage
    sbar.add("item", "volume.header", {
      position = "popup." .. volume_icon.name,
      icon = { drawing = false },
      label = {
        string = "Volume: ??%",
        width = 250,
        align = "center",
        font = settings.font.text .. ":Bold:14.0",
      },
      background = { height = 20 },
    })
    
    sbar.exec('osascript -e "output volume of (get volume settings)"', function(vol)
      sbar.set("volume.header", { label = { string = "Volume: " .. vol .. "%" } })
    end)

    sbar.add("item", "volume.device_header", {
      position = "popup." .. volume_icon.name,
      label = { string = "Output Devices", width = 250, align = "center" },
      background = { height = 24 },
    })

    sbar.exec("SwitchAudioSource -t output -c", function(result)
      current_audio_device = result:sub(1, -2)
      sbar.exec("SwitchAudioSource -a -t output", function(available)
        current = current_audio_device
        local counter = 0

        for device in string.gmatch(available, "[^\r\n]+") do
          if not string.find(device, "Teams") then
            local color = colors.grey
            if current == device then
              color = colors.white
            end
            sbar.add("item", "volume.device." .. counter, {
              position = "popup." .. volume_icon.name,
              width = 250,
              align = "center",
              background = { color = colors.transparent, height = 18 },
              label = { string = device, color = color },
              click_script = 'SwitchAudioSource -s "'
                  .. device
                  .. '" && sketchybar --set /volume.device\\.*/ label.color='
                  .. colors.grey
                  .. " --set $NAME label.color="
                  .. colors.white,
            })
            counter = counter + 1
          end
        end
      end)
    end)
  else
    volume_collapse_details()
  end
end

local function volume_scroll(env)
  local delta = env.SCROLL_DELTA
  sbar.exec('osascript -e "set volume output volume (output volume of (get volume settings) + ' .. delta .. ')"')
end

volume_icon:subscribe("mouse.clicked", volume_toggle_details)
-- volume_icon:subscribe("mouse.entered", volume_toggle_details)
-- volume_icon:subscribe("mouse.exited", volume_toggle_details)
volume_icon:subscribe("mouse.scrolled", volume_scroll)
volume_icon:subscribe("mouse.exited.global", volume_collapse_details)
