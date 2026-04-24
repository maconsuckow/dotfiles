local settings = require("settings")
local icons = require("icons")
local colors = require("colors")

sbar.add("event", "cpu_update")

local cpu_user = sbar.add("item", "cpu.user", {
  position = "right",
  padding_left = 0,
  padding_right = 0,
  width = 0,
  label = {
    padding_left = 0,
    width = 35,
    align = "left",
    font = {
      family = settings.font.numbers,
      style = settings.font.style_map["Bold"],
      size = 9.0,
    },
    string = "0%",
  },
  y_offset = 4,
  background = { color = colors.transparent }
})

local cpu_total = sbar.add("item", "cpu.total", {
  position = "right",
  padding_left = 0,
  padding_right = 0,
  width = 35,

  label = {
    padding_left = 0,
    width = 35,
    align = "left",
    font = {
      family = settings.font.numbers,
      style = settings.font.style_map["Bold"],
      size = 9.0,
    },
    string = "0%",
  },
  y_offset = -4,
  background = { color = colors.transparent }
})

local cpu = sbar.add("item", "cpu", {
  position = "right",
  padding_left = 0,
  padding_right = 0,
  icon = {
    string = icons.cpu,
    font = {
      style = settings.font.style_map["Regular"],
      size = 14.0,
    },
    padding_left = 10,
    padding_right = 8,
  },
  label = { drawing = false },
  popup = { align = "right" },
  background = { color = colors.transparent }
})

cpu:subscribe("cpu_update", function(env)

  cpu_user:set({ label = { string = env.user_load } })
  cpu_total:set({ label = { string = env.total_load } })
end)

sbar.exec("/Users/" .. os.getenv("USER") .. "/dotfiles/sketchybar/.config/sketchybar/helpers/cpu_load/cpu_load cpu_update 2 &")


local cpu_header = sbar.add("item", {
  position = "popup." .. cpu.name,
  icon = { drawing = false },
  label = {
    string = "CPU Usage",
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

local function cpu_collapse_details()
  cpu:set({ popup = { drawing = false } })
  sbar.remove("/cpu.device%.*/")
end

local function update_cpu_list()
  sbar.remove("/cpu.device%.*/")
  -- Get top 5 CPU consuming processes with full paths
  sbar.exec("ps -Ao args,pcpu -r | head -n 6 | tail -n 5", function(output)
    local counter = 0
    for line in string.gmatch(output, "[^\r\n]+") do
      local name, usage = line:match("^(.-)%s+([%d%.]+)$")
      if name and usage then
        -- Extract App name from path
        if name:find("Ghostty") then name = "Ghostty"
        elseif name:find("Google Chrome") then name = "Google Chrome"
        elseif name:find("Slack") then name = "Slack"
        elseif name:find("Code") then name = "VS Code"
        elseif name:find("WindowServer") then name = "WindowServer"
        else
          -- Fallback: get the last part of the path
          name = name:match("([^/]+)$") or name
          -- Remove everything after the first space to clean up args
          name = name:match("^([^%s]+)") or name
        end

        sbar.add("item", "cpu.device." .. counter, {
          position = "popup." .. cpu.name,
          icon = { 
            string = name, 
            width = 125, 
            align = "left",
            font = { family = settings.font.text, style = "Regular", size = 12 },
            padding_left = 15,
          },
          label = { 
            string = usage .. "%",
            width = 125,
            align = "right",
            font = { family = settings.font.text, style = "Regular", size = 12 },
            padding_right = 15,
          },
          background = { drawing = false, height = 22 },
        })
        counter = counter + 1
      end
    end
  end)
end

cpu:subscribe("mouse.clicked", function(env)
  local drawing = cpu:query().popup.drawing
  if drawing == "off" then
    cpu:set({ popup = { drawing = true } })
    update_cpu_list()
  else
    cpu_collapse_details()
  end
end)

cpu_user:subscribe("mouse.clicked", function(env)
  cpu:trigger("mouse.clicked")
end)

cpu_total:subscribe("mouse.clicked", function(env)
  cpu:trigger("mouse.clicked")
end)

cpu:subscribe("mouse.exited.global", cpu_collapse_details)
cpu_user:subscribe("mouse.exited.global", cpu_collapse_details)
cpu_total:subscribe("mouse.exited.global", cpu_collapse_details)

