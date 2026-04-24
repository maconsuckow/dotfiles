local icons = require("icons")
local colors = require("colors")
local settings = require("settings")
local popupWidth = 250
local defaultDevice = "en0"

sbar.add("event", "network_update")

local wifi_up = sbar.add("item", "wifi.up", {
  position = "right",
  padding_left = 0,
  padding_right = 0,
  width = 0,
  label = {
    padding_left = 0,
    width = 50,
    align = "left",
    font = {
      family = settings.font.numbers,
      style = settings.font.style_map["Bold"],
      size = 9.0,
    },
    color = colors.blue,
    string = "0 B/s",
  },
  y_offset = 4,
  background = { color = colors.transparent }
})

local wifi_down = sbar.add("item", "wifi.down", {
  position = "right",
  padding_left = 0,
  padding_right = 0,
  width = 50,
  label = {
    padding_left = 0,
    width = 50,
    align = "left",
    font = {
      family = settings.font.numbers,
      style = settings.font.style_map["Bold"],
      size = 9.0,
    },
    color = colors.magenta,
    string = "0 B/s",
  },
  y_offset = -4,
  background = { color = colors.transparent }
})

local wifi = sbar.add("item", "wifi", {
	position = "right",
  padding_left = 0,
  padding_right = 0,
	icon = {
    string = icons.wifi.disconnected,
		font = {
			style = "Regular",
			size = 16,
		},
		padding_left = 6,
		padding_right = 8,
	},
  label = { drawing = false },
	popup = { align = "right" },
	background = {
		color = colors.transparent,
	},
})


sbar.add("bracket", "wifi.bracket", { wifi.name, wifi_up.name, wifi_down.name }, {
  background = { color = colors.transparent }
})

wifi:subscribe("network_update", function(env)
  wifi_up:set({ label = { string = env.upload } })
  wifi_down:set({ label = { string = env.download } })
end)

sbar.exec("/Users/" .. os.getenv("USER") .. "/dotfiles/sketchybar/.config/sketchybar/helpers/network_load/network_load en0 2 network_update &")



local ssid = sbar.add("item", {
	position = "popup." .. wifi.name,
	background = {
		drawing = true,
		height = 1,
    color = colors.bg2,
    y_offset = -12,
	},
  icon = {
    string = "SSID",
    width = 100,
    align = "left",
    padding_left = 15,
    font = { family = settings.font.text, style = "Bold", size = 12 },
  },
	label = {
		string = "Not Connected",
		width = 150,
		align = "right",
    padding_right = 15,
    font = { family = settings.font.text, style = "Regular", size = 12 },
	},
})

local speed = sbar.add("item", {
	position = "popup." .. wifi.name,
	background = {
		drawing = false,
		height = 22,
	},
  icon = {
    string = "Speed",
    width = 100,
    align = "left",
    padding_left = 15,
    font = { family = settings.font.text, style = "Bold", size = 12 },
  },
	label = {
		string = "0 Mbps",
		width = 150,
		align = "right",
    padding_right = 15,
    font = { family = settings.font.text, style = "Regular", size = 12 },
	},
})

local hostname = sbar.add("item", {
	position = "popup." .. wifi.name,
	background = {
		drawing = false,
		height = 22,
	},
  icon = {
    string = "Hostname",
    width = 100,
    align = "left",
    padding_left = 15,
    font = { family = settings.font.text, style = "Bold", size = 12 },
  },
	label = {
		string = "????????????",
		width = 150,
		align = "right",
    padding_right = 15,
    font = { family = settings.font.text, style = "Regular", size = 12 },
	},
})

local ip = sbar.add("item", {
	position = "popup." .. wifi.name,
	background = {
		drawing = false,
		height = 22,
	},
  icon = {
    string = "IP",
    width = 100,
    align = "left",
    padding_left = 15,
    font = { family = settings.font.text, style = "Bold", size = 12 },
  },
	label = {
		string = "???.???.???.???",
		width = 150,
		align = "right",
    padding_right = 15,
    font = { family = settings.font.text, style = "Regular", size = 12 },
	},
})

local router = sbar.add("item", {
	position = "popup." .. wifi.name,
	background = {
		drawing = false,
		height = 22,
	},
  icon = {
    string = "Router",
    width = 100,
    align = "left",
    padding_left = 15,
    font = { family = settings.font.text, style = "Bold", size = 12 },
  },
	label = {
		string = "???.???.???.???",
		width = 150,
		align = "right",
    padding_right = 15,
    font = { family = settings.font.text, style = "Regular", size = 12 },
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
					ssid:set({ label = { string = wifiName } })
				end)
			else
				wifiIcon = icons.ethernet.connected
				wifiName = "Ethernet"
				wifi:set({ icon = { string = wifiIcon, color = wifiColor } })
				ssid:set({ label = { string = wifiName } })
			end
		else
			wifi:set({ icon = { string = wifiIcon, color = wifiColor } })
			ssid:set({ label = { string = wifiName } })
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
    sbar.exec("swift -e 'import CoreWLAN; if let i = CWWiFiClient.shared().interface() { print(Int(i.transmitRate())) }'", function(result)
      local txRate = result:match("(%d+)")
      speed:set({ label = (txRate or "0") .. " Mbps" })
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
wifi:subscribe("mouse.exited.global", hideDetails)

wifi_up:subscribe("mouse.clicked", toggleDetails)
wifi_up:subscribe("mouse.exited.global", hideDetails)

wifi_down:subscribe("mouse.clicked", toggleDetails)
wifi_down:subscribe("mouse.exited.global", hideDetails)


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
