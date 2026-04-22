-- require("items.apple")
require("items.aerospace")
-- require("items.front_app")
-- require("items.island")

-- require("items.media")
require("items.clock")
require("items.battery")
require("items.network")
require("items.volume")
-- require("items.weather")
-- require("items.cpu")
-- require("items.memory")

local colors = require("colors")

sbar.add("bracket", "widgets.system", {
	"volume.icon",
	"wifi",
	"widgets.battery",
	"clock",
}, {
	background = { 
		color = colors.bar.bg,
		border_width = 2,
		border_color = colors.bar.border,
	},
})

print(os.date("refreshed at %c"))
