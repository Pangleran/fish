local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

local TeleportModule = loadstring(game:HttpGet("https://raw.githubusercontent.com/Pangleran/rblx/refs/heads/main/teleport.lua"))()
local LowTexture = loadstring(game:HttpGet("https://raw.githubusercontent.com/Pangleran/rblx/refs/heads/main/lowtexture.lua"))()
local AntiAfk = loadstring(game:HttpGet("https://raw.githubusercontent.com/Pangleran/rblx/rblx/refs/heads/main/antiafk.lua"))()
local AutoFish = loadstring(game:HttpGet("https://raw.githubusercontent.com/Pangleran/rblx/refs/heads/main/autofish.lua"))()
local AutoSell = loadstring(game:HttpGet("https://raw.githubusercontent.com/Pangleran/rblx/refs/heads/main/autosell.lua"))()

local Window = WindUI:CreateWindow({
    Title = "Fish it - Iky Fareza",
    Theme = WindUI.Themes.Dark
})

local TeleportTab = Window:CreateTab("Teleport")

local teleportList = {
    ["Ocean"] = TeleportModule.ToOcean,
    ["Classic Island [NEW]"] = TeleportModule.ToClassicIsland,
    ["Iron Cavern [NEW]"] = TeleportModule.ToIronCavern,
    ["Underground"] = TeleportModule.ToUnderground,
    ["Sisyphus"] = TeleportModule.ToSisyphus
}

local selected = nil

TeleportTab:CreateDropdown({
    Title = "Teleport Locations",
    List = {"Ocean", "Classic Island [NEW]", "Iron Cavern [NEW]", "Underground", "Sisyphus"},
    Callback = function(v)
        selected = v
    end
})

TeleportTab:CreateButton({
    Title = "Teleport to Selected",
    Callback = function()
        if selected and teleportList[selected] then
            teleportList[selected]()
        end
    end
})

local FishingTab = Window:CreateTab("Fishing")

FishingTab:CreateInput({
    Title = "Set Delay Fishing",
    Placeholder = "default: 1",
    Callback = function(v)
        local num = tonumber(v)
        if not num then return end
        if num < 0.1 then num = 0.1 end
        if num > 2 then num = 2 end
        AutoFish.SetDelayFishing(num)
        WindUI:Notify("Set Delay", "to " .. num .. " second")
    end
})

FishingTab:CreateToggle({
    Title = "Auto Fishing",
    Default = false,
    Callback = function(s)
        if s then AutoFish.run() else AutoFish.stop() end
    end
})

FishingTab:CreateButton({
    Title = "Recovery Fishing",
    Callback = function()
        AutoFish.recovery()
    end
})

local SettingsTab = Window:CreateTab("Settings")

SettingsTab:CreateToggle({
    Title = "Anti AFK",
    Callback = function(s)
        if s then AntiAfk.run() else AntiAfk.stop() end
    end
})

SettingsTab:CreateToggle({
    Title = "Low Texture",
    Callback = function(s)
        if s then LowTexture.run() else LowTexture.stop() end
    end
})

SettingsTab:CreateToggle({
    Title = "Auto Sell Fish",
    Callback = function(s)
        if s then AutoSell.run() else AutoSell.stop() end
    end
})

SettingsTab:CreateButton({
    Title = "Exit",
    Callback = function()
        WindUI:Destroy()
    end
})
