local colors = require("colors")
local icons = require("icons")
local settings = require("settings")

local bluetooth = sbar.add("item", "bluetooth.main", {
  position = "right",
  icon = {
    string = icons.bluetooth.main,
    font = {
      style = settings.font.style_map["Regular"],
      size = 14.0,
    },
    padding_left = 10,
    padding_right = 10,
  },
  label = { drawing = false },
  background = { color = colors.transparent },
  popup = { align = "center" },
})

-- Pre-add the header and a status item so the popup is never empty
sbar.add("item", "bluetooth.device_header", {
  position = "popup." .. bluetooth.name,
  label = { 
    string = "Bluetooth Devices", 
    width = 250, 
    align = "center",
    font = { family = settings.font.text, style = "Bold", size = 14 }
  },
  background = { drawing = true, height = 1, color = colors.bg2, y_offset = -12 },
})

local bluetooth_status = sbar.add("item", "bluetooth.status", {
  position = "popup." .. bluetooth.name,
  width = 250,
  align = "center",
  label = { 
    string = "Checking status...",
    color = colors.grey,
    font = { family = settings.font.text, style = "Regular", size = 12 },
  },
  background = { drawing = false, height = 22 },
})

local function bluetooth_collapse_details()
  bluetooth:set({ popup = { drawing = false } })
  sbar.remove("/bluetooth.device%.*/")
end

local function update_bluetooth_list()
  bluetooth_status:set({ label = { string = "Searching..." }, drawing = true })
  
  -- Clear existing device items
  sbar.remove("/bluetooth.device%.%d+/")

  sbar.exec("system_profiler SPBluetoothDataType", function(output)
    local counter = 0
    
    local function add_device(name, is_connected)
      sbar.add("item", "bluetooth.device." .. counter, {
        position = "popup." .. bluetooth.name,
        width = 250,
        align = "center",
        icon = {
          string = is_connected and "󰄬" or "",
          padding_left = 15,
          color = colors.white,
          width = 20,
        },
        label = { 
          string = name,
          color = is_connected and colors.white or colors.grey,
          font = { family = settings.font.text, style = is_connected and "Bold" or "Regular", size = 12 },
          padding_right = 35,
        },
        background = { drawing = false, height = 22 },
      })
      counter = counter + 1
    end

    local connected_section = output:match("Connected:(.-)Not Connected:") or output:match("Connected:(.*)")
    if connected_section then
      for line in connected_section:gmatch("[^\r\n]+") do
        local name = line:match("^%s%s%s%s%s%s%s%s%s%s([^:]+):%s*$")
        if name then add_device(name, true) end
      end
    end

    local not_connected_section = output:match("Not Connected:(.*)")
    if not_connected_section then
      for line in not_connected_section:gmatch("[^\r\n]+") do
        local name = line:match("^%s%s%s%s%s%s%s%s%s%s([^:]+):%s*$")
        if name then add_device(name, false) end
      end
    end
    
    if counter > 0 then
      bluetooth_status:set({ drawing = false })
    else
      bluetooth_status:set({ 
        drawing = true,
        label = { string = "No Devices Found" }
      })
    end
  end)
end

bluetooth:subscribe("mouse.clicked", function(env)
  local drawing = bluetooth:query().popup.drawing
  if drawing == "off" then
    bluetooth:set({ popup = { drawing = true } })
    update_bluetooth_list()
  else
    bluetooth_collapse_details()
  end
end)

bluetooth:subscribe("mouse.exited.global", bluetooth_collapse_details)
