local icons = require("icons")
local colors = require("colors")
local popupWidth = 250
local defaultDevice = "en0"

local wifi = sbar.add("item", "wifi", {
	position = "right",
	label = { drawing = true },
	icon = {
		font = {
			family = "JetBrainsMono Nerd Font",
			style = "Regular",
			size = 16,
		},
		padding_left = 10,
		padding_right = 0,
	},
	popup = { align = "center" },
	background = {
		color = colors.bar.bg,
	},
})

local hostname = sbar.add("item", {
	position = "popup." .. wifi.name,
	background = {
		height = 16,
	},
	icon = {
		font = {
			family = "JetBrainsMono Nerd Font",
			style = "Regular",
			size = 16,
		},
		align = "left",
		string = "Hostname:",
		width = popupWidth / 2,
	},
	label = {
		max_chars = 20,
		string = "????????????",
		width = popupWidth / 2,
		align = "right",
	},
})

local ip = sbar.add("item", {
	position = "popup." .. wifi.name,
	background = {
		height = 16,
	},
	icon = {
		align = "left",
		string = "IP:",
		width = popupWidth / 2,
		font = {
			family = "JetBrainsMono Nerd Font",
			style = "Regular",
			size = 16,
		},
	},
	label = {
		align = "right",
		string = "???.???.???.???",
		width = popupWidth / 2,
	},
})

local router = sbar.add("item", {
	position = "popup." .. wifi.name,
	background = {
		height = 16,
	},
	icon = {
		align = "left",
		string = "Router:",
		width = popupWidth / 2,
		font = {
			family = "JetBrainsMono Nerd Font",
			style = "Regular",
			size = 16,
		},
	},
	label = {
		align = "right",
		string = "???.???.???.???",
		width = popupWidth / 2,
	},
})

local function setDetails()
	wifi:set({
		icon = {
			font = {
				family = "JetBrainsMono Nerd Font",
				style = "Regular",
				size = 16,
			},
			string = icons.wifi.disconnected,
			color = colors.magenta,
		},
	})

	local ipCommand = "ipconfig getifaddr " .. defaultDevice
	sbar.exec(ipCommand, function(ip)
		local ipConnected = not (ip == "")

		local wifiIcon
		local wifiColor
		local wifiName

		if ipConnected and defaultDevice == "en0" then
			wifiIcon = icons.wifi.connected
			wifiColor = colors.white
		elseif ipConnected and defaultDevice == "en8" then
			wifiIcon = icons.ethernet.connected
			label = "disconnected"
			wifiColor = colors.white
		else
			wifiIcon = icons.wifi.disconnected
			wifiColor = colors.white
		end

		if defaultDevice == "en0" and ipConnected then
			sbar.exec("ipconfig getsummary en0 | awk -F ' SSID : '  '/ SSID : / {print $2}'", function(ssid)
				wifiName = ssid:gsub("%s", "") -- Remove leading/trailing whitespace
				wifi:set({
					icon = {
						string = wifiIcon,
						color = wifiColor,
					},
					label = {
						string = wifiName,
					},
				})
			end)
		else
			-- If not connected or not a Wi-Fi device, set a default label
			wifi:set({
				icon = {
					string = wifiIcon,
					color = wifiColor,
				},
				label = {
					string = "Not Connected",
				},
			})
		end
	end)
end

local function hideDetails()
	wifi:set({ popup = { drawing = false } })
end

local function toggleDetails()
	local shouldDrawDetails = wifi:query().popup.drawing == "off"

	if shouldDrawDetails then
		wifi:set({ popup = { drawing = true } })
		sbar.exec("networksetup -getcomputername", function(result)
			hostname:set({ label = result })
		end)
		sbar.exec("ipconfig getifaddr " .. defaultDevice, function(result)
			ip:set({ label = result })
		end)
		sbar.exec("networksetup -getinfo Wi-Fi | awk -F 'Router: ' '/^Router: / {print $2}'", function(result)
			router:set({ label = result })
		end)
	else
		hideDetails()
	end
end

local function copyLabelToClipboard(env)
	local label = sbar.query(env.NAME).label.value
	sbar.exec('echo "' .. label .. '" | pbcopy')
	sbar.set(env.NAME, { label = { string = icons.clipboard, align = "center" } })
	sbar.delay(1, function()
		sbar.set(env.NAME, { label = { string = label, align = "right" } })
	end)
end

wifi:subscribe("mouse.clicked", toggleDetails)
-- wifi:subscribe("mouse.entered", toggleDetails)
-- wifi:subscribe("mouse.exited", toggleDetails)

hostname:subscribe("mouse.clicked", copyLabelToClipboard)
ip:subscribe("mouse.clicked", copyLabelToClipboard)
router:subscribe("mouse.clicked", copyLabelToClipboard)

local function reset()
	sbar.exec("networksetup -listallhardwareports", function(hardwarePorts)
		sbar.exec(
			"echo '"
				.. hardwarePorts
				.. "' | awk '/Thunderbolt Ethernet Slot 0/ || /Thunderbolt Ethernet Slot 1/{getline; print $2}'",
			function(defaultDeviceOutput)
				defaultDevice = defaultDeviceOutput:match("[^\r\n]+")

				if defaultDevice == nil then
					defaultDevice = "en0"
				end

				setDetails()
			end
		)
	end)
end

wifi:subscribe({ "wifi_change", "system_woke", "forced" }, function(env)
	reset()
end)

reset()
