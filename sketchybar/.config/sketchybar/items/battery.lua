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
  popup = { align = "center" },
  background = {
    color = colors.transparent,
  }
})

local battery_details = sbar.add("item", {
  position = "popup." .. battery.name,
  label = {
    string = "Battery Details",
    width = 200,
    align = "center",
  },
})

local charge_status = sbar.add("item", {
  position = "popup." .. battery.name,
  background = { height = 18 },
  icon = { string = "Charge:", width = 100, align = "left" },
  label = {
    string = "??%",
    width = 100,
    align = "right",
  },
})

local remaining_time = sbar.add("item", {
  position = "popup." .. battery.name,
  background = { height = 18 },
  icon = { string = "Remaining:", width = 100, align = "left" },
  label = {
    string = "??:??h",
    width = 100,
    align = "right",
  },
})

local power_source = sbar.add("item", {
  position = "popup." .. battery.name,
  background = { height = 18 },
  icon = { string = "Source:", width = 100, align = "left" },
  label = {
    string = "???",
    width = 100,
    align = "right",
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
  battery:set({ popup = { drawing = "toggle" } })

  if drawing == "off" then
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
  end
end

battery:subscribe("mouse.clicked", toggle_details)
