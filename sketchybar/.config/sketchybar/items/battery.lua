local icons = require("icons")
local colors = require("colors")
local settings = require("settings")

local battery = sbar.add("item", "widgets.battery", {
  position = "right",
  icon = {
    font = {
      style = settings.font.style_map["Regular"],
      size = 19.0,
    },
    padding_left = 6,
    padding_right = 6,
  },
  label = { 
    drawing = false,
  },
  update_freq = 60,
  popup = { align = "right" },
  background = {
    color = colors.transparent,
  }
})

local battery_header = sbar.add("item", {
  position = "popup." .. battery.name,
  icon = { drawing = false },
  label = {
    string = "Battery Details",
    width = 250,
    align = "center",
    font = { family = settings.font.text, style = "Bold", size = 14 },
  },
  background = {
    drawing = true,
    height = 1,
    color = colors.bg2,
    y_offset = -12,
  },
})

local charge_status = sbar.add("item", {
  position = "popup." .. battery.name,
  background = { drawing = false, height = 22 },
  icon = {
    string = "Charge",
    width = 100,
    align = "left",
    padding_left = 15,
    font = { family = settings.font.text, style = "Bold", size = 12 },
  },
  label = {
    string = "??%",
    width = 150,
    align = "right",
    padding_right = 15,
    font = { family = settings.font.text, style = "Regular", size = 12 },
  },
})

local remaining_time = sbar.add("item", {
  position = "popup." .. battery.name,
  background = { drawing = false, height = 22 },
  icon = {
    string = "Remaining",
    width = 100,
    align = "left",
    padding_left = 15,
    font = { family = settings.font.text, style = "Bold", size = 12 },
  },
  label = {
    string = "??:??h",
    width = 150,
    align = "right",
    padding_right = 15,
    font = { family = settings.font.text, style = "Regular", size = 12 },
  },
})

local power_source = sbar.add("item", {
  position = "popup." .. battery.name,
  background = { drawing = false, height = 22 },
  icon = {
    string = "Source",
    width = 100,
    align = "left",
    padding_left = 15,
    font = { family = settings.font.text, style = "Bold", size = 12 },
  },
  label = {
    string = "???",
    width = 150,
    align = "right",
    padding_right = 15,
    font = { family = settings.font.text, style = "Regular", size = 12 },
  },
})

battery:subscribe({ "routine", "power_source_change", "system_woke" }, function()
  sbar.exec("pmset -g batt", function(batt_info)
    local icon = "!"
    local label = "?"

    local found, _, charge = batt_info:find("(%d+)%%")
    if found then
      charge = tonumber(charge)
      label = charge .. "%"
    end

    local color = colors.green
    local charging, _, _ = batt_info:find("AC Power")

    if charging then
      icon = icons.battery.charging
    else
      if found and charge > 80 then
        icon = icons.battery._100
      elseif found and charge > 60 then
        icon = icons.battery._75
      elseif found and charge > 40 then
        icon = icons.battery._50
      elseif found and charge > 20 then
        icon = icons.battery._25
        color = colors.orange
      else
        icon = icons.battery._0
        color = colors.red
      end
    end

    battery:set({
      icon = {
        string = icon,
        color = color,
      },
    })
    
    charge_status:set({ label = label })
  end)
end)

local function toggle_details()
  local drawing = battery:query().popup.drawing
  if drawing == "off" then
    battery:set({ popup = { drawing = true } })
    sbar.exec("pmset -g batt", function(batt_info)
      local found, _, remaining = batt_info:find(" (%d+:%d+) remaining")
      local label = found and remaining .. "h" or "N/A"
      
      local charging = batt_info:find("AC Power")
      if charging then
        local found_to_full, _, to_full = batt_info:find(" (%d+:%d+) until full")
        label = found_to_full and to_full .. " until full" or "Charging"
      end
      
      remaining_time:set({ label = label })
      power_source:set({ label = charging and "AC Power" or "Battery" })
    end)
  else
    battery:set({ popup = { drawing = false } })
  end
end

battery:subscribe("mouse.clicked", toggle_details)
battery:subscribe("mouse.exited.global", function()
  battery:set({ popup = { drawing = false } })
end)
