local settings = require("settings")
local icons = require("icons")
local colors = require("colors")

local memory = sbar.add("item", "memory", {
  position = "right",
  icon = {
    string = icons.memory,
    font = {
      style = settings.font.style_map["Regular"],
      size = 14.0,
    },
    padding_left = 10,
    padding_right = 5,
  },
  label = {
    string = "??%",
    font = {
      family = settings.font.numbers,
      style = "Bold",
      size = 12.0,
    },
    padding_right = 10,
  },
  update_freq = 10,
  popup = { align = "right" },
  background = { color = colors.transparent },
})

sbar.add("item", {
  position = "popup." .. memory.name,
  icon = { drawing = false },
  label = {
    string = "Memory Usage",
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

local function memory_collapse_details()
  memory:set({ popup = { drawing = false } })
  sbar.remove("/memory.device%.*/")
end

local function update_memory_list()
  sbar.remove("/memory.device%.*/")
  -- Get top 5 Memory consuming processes with full paths
  sbar.exec("ps -Ao args,pmem -m | head -n 6 | tail -n 5", function(output)
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

        sbar.add("item", "memory.device." .. counter, {
          position = "popup." .. memory.name,
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

memory:subscribe({ "forced", "routine", "system_woke", "mouse_entered" }, function()
	sbar.exec(
		"vm_stat | awk '/Pages active/ {active=$3} /Pages wired/ {wired=$4} /Pages occupied by compressor/ {compressed=$5} END { printf \"%.0f\", (active + wired + compressed) * 16384 / 1024 / 1024 / 1024 / 32 * 100 }'",
		function(memory_info)
			memory:set({ label = memory_info .. "%" })
		end
	)
end)

memory:subscribe("mouse.clicked", function(env)
  local drawing = memory:query().popup.drawing
  if drawing == "off" then
    memory:set({ popup = { drawing = true } })
    update_memory_list()
  else
    memory_collapse_details()
  end
end)

memory:subscribe("mouse.exited.global", memory_collapse_details)
