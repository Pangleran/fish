local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()
local TeleportModule = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/Pangleran/rblx/refs/heads/main/teleport.lua"))()
local LowTexture = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/Pangleran/rblx/refs/heads/main/lowtexture.lua"))()
local AntiAfk = loadstring(game:HttpGet("https://raw.githubusercontent.com/Pangleran/rblx/refs/heads/main/antiafk.lua"))()
local AutoFish = loadstring(game:HttpGet("https://raw.githubusercontent.com/Pangleran/rblx/refs/heads/main/autofish.lua"))()

local Window = Rayfield:CreateWindow({
    Name = "Fish it - Iky Fareza",
    ConfigurationSaving = {
        Enabled = false
    }
})

local Teleport = Window:CreateTab("Teleport")

Teleport:CreateButton({
    Name = "Teleport to Ocean",
    Callback = function()
        TeleportModule.ToOcean()
    end,
})

Teleport:CreateButton({
    Name = "Teleport to Creater",
    Callback = function()
        TeleportModule.ToCreater()
    end,
})

Teleport:CreateButton({
    Name = "Teleport to Undeground (element progress)",
    Callback = function()
        TeleportModule.ToUnderground()
    end,
})

Teleport:CreateButton({
    Name = "Teleport to Sisyphus (ghostfin progress)",
    Callback = function()
        TeleportModule.ToSisyphus()
    end,
})

local Fishing = Window:CreateTab("Fishing")

Fishing:CreateToggle({
    Name = "Auto Fishing",
    CurrentValue = false,
    Flag = "AutoFishingToggle",
    Callback = function(state)
        -- code
    end,
})

local Settings = Window:CreateTab("Settings")

Settings:CreateToggle({
    Name = "Anti AFK",
    CurrentValue = false,
    Flag = "AntiAFKToggle",
    Callback = function(state)
        AntiAfk.Apply(state)
    end,
})

Settings:CreateButton({
    Name = "Low Texture",
    Callback = function()
        LowTexture.Apply()
    end,
})
