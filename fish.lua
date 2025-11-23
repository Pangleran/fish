local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Window = Rayfield:CreateWindow({
    Name = "Fish it - Iky Fareza",
    ConfigurationSaving = {
        Enabled = false
    }
})

local VirtualUser = game:GetService("VirtualUser")
local LocalPlayer = game:GetService("Players").LocalPlayer
local TeleportModule = loadstring(game:HttpGet("https://raw.githubusercontent.com/Pangleran/repo/main/teleport.lua"))()
local LowTexture = loadstring(game:HttpGet("https://raw.githubusercontent.com/Pangleran/repo/main/lowtexture.lua"))()

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
        if state then
            AntiAFKConnection = LocalPlayer.Idled:Connect(function()
                VirtualUser:CaptureController()
                VirtualUser:ClickButton2(Vector2.new())
            end)
        else
            if AntiAFKConnection then
                AntiAFKConnection:Disconnect()
                AntiAFKConnection = nil
            end
        end
    end,
})

Settings:CreateButton({
    Name = "Low Texture",
    Callback = function()
        LowTexture.Apply()
    end,
})
