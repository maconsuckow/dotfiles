local colors = require("colors")
local icons = require("icons")

local weather = sbar.add("item", "weather", {
  position = "e",
  update_freq = 900,
  padding_right = 10,
  padding_left = 10,
  icon = {
    font = {
      family = "JetBrainsMono Nerd Font",
      style = "Regular",
      size = 16,
    },
    padding_left = 10,
  },

  label = {
    padding_left = 10,
    padding_right = 10,
  },
})

weather:subscribe({ "routine", "forced", "mouse.entered" }, function()
  sbar.exec('curl -s "https://v2d.wttr.in/Olathe,KS?format=j1"', function(weather_info)
    local temp = weather_info.current_condition[1].temp_F
    local condition = weather_info.current_condition[1].weatherDesc[1].value

    local tempString = ""
    local tempNum = tonumber(temp)
    print("Temp: " .. temp)

    if tempNum > 0 then
      tempString = "+" .. temp .. ""
    else
      tempString = "-" .. temp .. ""
    end

    if condition == "Sunny" then
      weather:set({ icon = icons.weather.sunny, label = tempString })
    elseif condition == "Partly cloudy" then
      weather:set({ icon = icons.weather.partly_sunny, label = tempString })
    else
      print("Condition:" .. condition)
      weather:set({ icon = icons.weather.sunny, label = tempString })
    end
  end)
end)
