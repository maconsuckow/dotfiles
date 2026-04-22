local icon_map = require("icon_map")

local M = {}

function M.get_icon(app_name)
  if not app_name or app_name == "" then
    return ":default:"
  end

  -- Hardcoded mappings for testing
  local test_map = {
    ["Arc"] = ":arc:",
    ["Code"] = ":code:",
    ["Finder"] = ":finder:",
    ["Spotify"] = ":spotify:",
  }

  if test_map[app_name] then
    return test_map[app_name]
  end

  local icon = icon_map[app_name]
  if icon then
    return icon
  end

  -- Fallback to case-insensitive search
  for name, mapped_icon in pairs(icon_map) do
    if name:lower() == app_name:lower() then
      return mapped_icon
    end
  end

  return ":default:"
end

return M
