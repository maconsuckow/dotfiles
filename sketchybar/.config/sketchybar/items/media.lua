local icons = require("icons")
local colors = require("colors")

local whitelist = { ["Spotify"] = true, ["Music"] = true }

local media_cover = sbar.add("item", {
	position = "e",
	background = {
		image = {
			string = "media.artwork",
			scale = 0.85,
		},
		color = colors.transparent,
	},
	label = { drawing = false },
	icon = { drawing = false },
	drawing = false,
	updates = true,
	popup = {
		align = "center",
		horizontal = true,
	},
	padding_left = 0,
	padding_right = 0,
})

local media_artist = sbar.add("item", {
	position = "e",
	drawing = true,
	padding_left = 10,
	padding_right = 5,
	width = 0,
	icon = { drawing = false },
	label = {
		width = "dynamic",
		font = { size = 9 },
		color = colors.with_alpha(colors.white, 0.6),
		max_chars = 40,
		y_offset = 6,
	},
})

local media_title = sbar.add("item", {
	position = "e",
	drawing = true,
	padding_left = 10,
	padding_right = 5,
	icon = { drawing = false },
	label = {
		font = { size = 11 },
		width = "dynamic",
		max_chars = 50,
		y_offset = -5,
	},
})

sbar.add("item", {
	position = "popup." .. media_cover.name,
	icon = { string = icons.media.back },
	label = { drawing = false },
	click_script = "nowplaying-cli previous",
})
sbar.add("item", {
	position = "popup." .. media_cover.name,
	icon = { string = icons.media.play_pause },
	label = { drawing = false },
	click_script = "nowplaying-cli togglePlayPause",
})
sbar.add("item", {
	position = "popup." .. media_cover.name,
	icon = { string = icons.media.forward },
	label = { drawing = false },
	click_script = "nowplaying-cli next",
})

media_cover:subscribe("media_change", function(env)
	if whitelist[env.INFO.app] then
		local drawing = (env.INFO.state == "playing")
		if env.INFO.artist ~= "" then
			media_artist:set({ drawing = drawing, label = env.INFO.artist })
		else
			media_artist:set({ drawing = drawing, label = env.INFO.album })
		end
		media_title:set({ drawing = drawing, label = env.INFO.title })
		media_cover:set({ drawing = drawing })
	end
end)

media_cover:subscribe("mouse.clicked", function()
	media_cover:set({ popup = { drawing = "toggle" } })
end)

media_title:subscribe("mouse.exited.global", function()
	media_cover:set({ popup = { drawing = false } })
end)
