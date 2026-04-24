local colors = require("colors")
local icons = require("icons")
local settings = require("settings")

local aerospace_layout = sbar.add("item", "aerospace.layout", {
  position = "left",
  padding_left = 5,
  padding_right = 5,
  icon = {
    font = { family = settings.font.text, style = "Bold", size = 16 },
    padding_left = 12,
    padding_right = 12,
    align = "center",
  },
  label = { drawing = false },
  background = {
    color = colors.transparent,
    -- border_width = 1,
    border_color = colors.bar.border,
    corner_radius = 12,
    height = 30,
  },
})

local function updateLayout()
  sbar.exec("/opt/homebrew/bin/aerospace list-workspaces --focused --format '%{workspace-root-container-layout}'", function(layout)
    layout = layout:match("[^\r\n]+")
    if not layout then return end

    local layout_icon = ""
    if layout == "tiles" or layout == "accordion" then
      layout_icon = icons.layout.tiling
    else
      layout_icon = icons.layout.floating
    end

    aerospace_layout:set({
      icon = { string = layout_icon }
    })
  end)
end

-- Update on workspace change or manual trigger
aerospace_layout:subscribe({ "aerospace_workspace_change", "forced", "ready" }, function(env)
  updateLayout()
end)

-- Initial fetch
updateLayout()
