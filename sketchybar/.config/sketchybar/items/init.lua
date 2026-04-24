-- require("items.apple")
-- require("items.aerospace_layout")
require("items.aerospace")
require("items.front_app")
-- require("items.island")

-- require("items.media")
require("items.clock")
require("items.battery")
require("items.network")
require("items.bluetooth")
require("items.volume")

-- Spacer between system and resources
sbar.add("item", { position = "right", width = 10, background = { drawing = false } })

require("items.cpu")
require("items.memory")
-- require("items.weather")

local colors = require("colors")

sbar.add("bracket", "widgets.resources", {
  "cpu",
  "cpu.user",
  "cpu.total",
  "memory",
}, {
	background = { 
		color = colors.bar.bg,
		border_width = 1,
		border_color = colors.bar.border,
		corner_radius = 12,
	},
})

sbar.add("bracket", "widgets.system", {
	"bluetooth.main",
	"volume.icon",
	"widgets.battery",
	"clock",
}, {
	background = { 
		color = colors.bar.bg,
		border_width = 1,
		border_color = colors.bar.border,
		corner_radius = 12,
	},
})


print(os.date("refreshed at %c"))
