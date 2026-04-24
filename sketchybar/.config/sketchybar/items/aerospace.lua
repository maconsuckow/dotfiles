local colors = require("colors")
local icons = require("icons")
local app_icons = require("app_icons")
local settings = require("settings")

local spaces = {}
local AEROSPACE_PATH = "/opt/homebrew/bin/aerospace"

local function clean(str)
    return str:gsub("^%s*(.-)%s*$", "%1")
end

local function updateWorkspacesBatch(focusedName)
    sbar.exec(AEROSPACE_PATH .. " list-windows --all --format '%{workspace}|%{app-name}'", function(windowsOutput)
        local workspace_apps = {}
        for line in windowsOutput:gmatch("[^\r\n]+") do
            local workspace, app = line:match("([^|]+)|(.+)")
            if workspace and app then
                workspace = clean(workspace)
                if not workspace_apps[workspace] then workspace_apps[workspace] = {} end
                workspace_apps[workspace][app] = true
            end
        end

        for spaceName, item in pairs(spaces) do
            local workspaceName = spaceName:gsub("workspaces%.", "")
            local isSelected = (workspaceName == focusedName)
            local apps = workspace_apps[workspaceName] or {}
            
            if isSelected then
                local icon_line = ""
                local sorted_apps = {}
                for app, _ in pairs(apps) do table.insert(sorted_apps, app) end
                table.sort(sorted_apps)

                for _, app in ipairs(sorted_apps) do
                    local icon = app_icons.get_icon(app)
                    if icon_line == "" then icon_line = icon else icon_line = icon_line .. " " .. icon end
                end

                local font = "sketchybar-app-font:Regular:14.0"
                if icon_line == "" then 
                    icon_line = workspaceName 
                    font = { family = settings.font.text, style = "Bold", size = 12.0 }
                end

                item:set({
                    label = {
                        string = icon_line,
                        color = colors.white,
                        font = font,
                        padding_left = 5,
                        padding_right = 5,
                    },
                    background = { drawing = false },
                })
            else
                local has_windows = next(apps) ~= nil
                item:set({
                    label = {
                        string = workspaceName,
                        color = has_windows and colors.white or colors.with_alpha(colors.white, 0.5),
                        font = { family = settings.font.text, style = "Bold", size = 12.0 },
                        padding_left = 5,
                        padding_right = 5,
                    },
                    background = { drawing = false },
                })
            end
        end
    end)
end

local function addWorkspaceItem(workspaceName)
    local spaceName = "workspaces." .. workspaceName

    spaces[spaceName] = sbar.add("item", spaceName, {
        icon = { drawing = false },
        label = {
            font = { family = settings.font.text, style = "Bold", size = 12 },
            padding_left = 5,
            padding_right = 5,
        },
        background = {
            corner_radius = 10,
            height = 26,
        },
    })

    -- Subscribe each item to the change event
    spaces[spaceName]:subscribe("aerospace_workspace_change", function(env)
        updateWorkspacesBatch(env.FOCUSED_WORKSPACE)
    end)

    spaces[spaceName]:subscribe("mouse.clicked", function()
        sbar.exec(AEROSPACE_PATH .. " workspace " .. workspaceName)
    end)
end

local function createWorkspaces()
    sbar.add("event", "aerospace_workspace_change")
    
    sbar.exec(AEROSPACE_PATH .. " list-workspaces --all", function(workspacesOutput)
        local bracket_items = {}
        for workspaceName in workspacesOutput:gmatch("[^\r\n]+") do
            workspaceName = clean(workspaceName)
            addWorkspaceItem(workspaceName)
            table.insert(bracket_items, "workspaces." .. workspaceName)
        end

        sbar.add("bracket", "aerospace.bracket", bracket_items, {
            background = { 
                color = colors.bg1,
                border_width = 1,
                border_color = colors.bar.border,
                corner_radius = 12,
                height = 30,
            },
            padding_left = 2,
            padding_right = 2,
        })

        -- Initial update for all items
        sbar.exec(AEROSPACE_PATH .. " list-workspaces --focused", function(focusedWorkspace)
            local focusedName = clean(focusedWorkspace:match("[^\r\n]+"))
            updateWorkspacesBatch(focusedName)
        end)

        -- Centralized watcher for app switches
        sbar.add("item", { drawing = false }):subscribe("front_app_switched", function(env)
            sbar.exec(AEROSPACE_PATH .. " list-workspaces --focused", function(focusedWorkspace)
                local focusedName = clean(focusedWorkspace:match("[^\r\n]+"))
                updateWorkspacesBatch(focusedName)
            end)
        end)
    end)
end

createWorkspaces()
