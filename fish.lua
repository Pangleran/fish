local Luna = loadstring(game:HttpGet("https://raw.githubusercontent.com/Nebula-Softworks/Luna-Interface-Suite/refs/heads/master/source.lua", true))()

local TeleportModule = loadstring(game:HttpGet("https://raw.githubusercontent.com/Pangleran/rblx/refs/heads/main/teleport.lua"))()
local LowTexture = loadstring(game:HttpGet("https://raw.githubusercontent.com/Pangleran/rblx/refs/heads/main/lowtexture.lua"))()
local AntiAfk = loadstring(game:HttpGet("https://raw.githubusercontent.com/Pangleran/rblx/refs/heads/main/antiafk.lua"))()
local AutoFish = loadstring(game:HttpGet("https://raw.githubusercontent.com/Pangleran/rblx/refs/heads/main/autofish.lua"))()
local AutoSell = loadstring(game:HttpGet("https://raw.githubusercontent.com/Pangleran/rblx/refs/heads/main/autosell.lua"))()

local Window = Luna:CreateWindow({
    Name = "Fish it - Iky Fareza",
    Subtitle = "Luna UI",
    LoadingEnabled = false
})

local TeleportTab = Window:CreateTab({
    Name = "Teleport",
    Icon = "map",
    ImageSource = "Material"
})

local buttons = {
    ["Teleport to Ocean"] = TeleportModule.ToOcean,
    ["Teleport to Classic Island [NEW]"] = TeleportModule.ToClassicIsland,
    ["Teleport to Iron Cavern [NEW]"] = TeleportModule.ToIronCavern,
    ["Teleport to Underground"] = TeleportModule.ToUnderground,
    ["Teleport to Sisyphus"] = TeleportModule.ToSisyphus
}

for name, func in pairs(buttons) do
    TeleportTab:CreateButton({
        Name = name,
        Callback = func
    })
end

local FishingTab = Window:CreateTab({
    Name = "Fishing",
    Icon = "set_meal",
    ImageSource = "Material"
})

FishingTab:CreateInput({
    Name = "Set Delay Fishing",
    PlaceholderText = "default: 1",
    Callback = function(v)
        local num = tonumber(v)
        if not num then return end
        if num < 0.1 or num > 2 then return end
        AutoFish.SetDelayFishing(v)
        Luna:Notification({
            Title = "✅ Set Delay",
            Icon = "notifications_active",
            ImageSource = "Material",
            Content = "to " .. v .. " second"
        })
    end
})

FishingTab:CreateToggle({
    Name = "Auto Fishing",
    CurrentValue = false,
    Callback = function(s)
        if s then AutoFish.run() else AutoFish.stop() end
    end
})

FishingTab:CreateButton({
    Name = "Recovery Fishing",
    Callback = function()
        AutoFish.recovery()
    end
})

local SettingsTab = Window:CreateTab({
    Name = "Settings",
    Icon = "settings",
    ImageSource = "Material"
})

SettingsTab:CreateToggle({
    Name = "Anti AFK",
    Callback = function(s)
        if s then AntiAfk.run() else AntiAfk.stop() end
    end
})

SettingsTab:CreateToggle({
    Name = "Low Texture",
    Callback = function(s)
        if s then LowTexture.run() else LowTexture.stop() end
    end
})

SettingsTab:CreateToggle({
    Name = "Auto Sell Fish",
    Callback = function(s)
        if s then AutoSell.run() else AutoSell.stop() end
    end
})

SettingsTab:CreateButton({
    Name = "Exit",
    Callback = function()
        Luna:Destroy()
    end
})
