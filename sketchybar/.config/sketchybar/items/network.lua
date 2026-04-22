local icons = require("icons")
local colors = require("colors")
local popupWidth = 250
local defaultDevice = "en0"

local wifi = sbar.add("item", "wifi", {
	position = "right",
	label = { 
		drawing = false,
	},
	icon = {
		font = {
			style = "Regular",
			size = 16,
		},
		padding_left = 6,
		padding_right = 6,
	},
	popup = { align = "center" },
	background = {
		color = colors.transparent,
	},
})

local ssid = sbar.add("item", {
	position = "popup." .. wifi.name,
	background = {
		height = 18,
	},
	icon = { drawing = false },
	label = {
		string = "SSID: Not Connected",
		width = popupWidth,
		align = "center",
	},
})

local hostname = sbar.add("item", {
	position = "popup." .. wifi.name,
	background = {
		height = 18,
	},
	icon = { drawing = false },
	label = {
		string = "Hostname: ????????????",
		width = popupWidth,
		align = "center",
	},
})

local ip = sbar.add("item", {
	position = "popup." .. wifi.name,
	background = {
		height = 18,
	},
	icon = { drawing = false },
	label = {
		string = "IP: ???.???.???.???",
		width = popupWidth,
		align = "center",
	},
})

local router = sbar.add("item", {
	position = "popup." .. wifi.name,
	background = {
		height = 18,
	},
	icon = { drawing = false },
	label = {
		string = "Router: ???.???.???.???",
		width = popupWidth,
		align = "center",
	},
})

local function setDetails()
	local ipCommand = "ipconfig getifaddr " .. defaultDevice
	sbar.exec(ipCommand, function(ip_addr)
		local ipConnected = not (ip_addr == "")

		local wifiIcon = icons.wifi.disconnected
		local wifiColor = colors.white
		local wifiName = "Not Connected"

		if ipConnected then
			if defaultDevice == "en0" then
				wifiIcon = icons.wifi.connected
				sbar.exec("ipconfig getsummary en0 | awk -F ' SSID : '  '/ SSID : / {print $2}'", function(ssid_name)
					wifiName = ssid_name:gsub("^%s*(.-)%s*$", "%1")
					wifi:set({ icon = { string = wifiIcon, color = wifiColor } })
					ssid:set({ label = { string = "SSID: " .. wifiName } })
				end)
			else
				wifiIcon = icons.ethernet.connected
				wifiName = "Ethernet"
				wifi:set({ icon = { string = wifiIcon, color = wifiColor } })
				ssid:set({ label = { string = "SSID: " .. wifiName } })
			end
		else
			wifi:set({ icon = { string = wifiIcon, color = wifiColor } })
			ssid:set({ label = { string = "SSID: " .. wifiName } })
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
			hostname:set({ label = "Hostname: " .. result })
		end)
		sbar.exec("ipconfig getifaddr " .. defaultDevice, function(result)
			ip:set({ label = "IP: " .. result })
		end)
		sbar.exec("networksetup -getinfo Wi-Fi | awk -F 'Router: ' '/^Router: / {print $2}'", function(result)
			router:set({ label = "Router: " .. result })
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
