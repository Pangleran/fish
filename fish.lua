local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()
local TeleportModule = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/Pangleran/rblx/refs/heads/main/teleport.lua"))()
local LowTexture = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/Pangleran/rblx/refs/heads/main/lowtexture.lua"))()
local AntiAfk = loadstring(game:HttpGet("https://raw.githubusercontent.com/Pangleran/rblx/refs/heads/main/antiafk.lua"))()
local AutoFish = loadstring(game:HttpGet("https://raw.githubusercontent.com/Pangleran/rblx/refs/heads/main/autofish.lua"))()
local SwitchServer = loadstring(game:HttpGet("https://raw.githubusercontent.com/Pangleran/rblx/refs/heads/main/switchserver.lua"))()

local Window = Rayfield:CreateWindow({
    Name = "Fish it - Iky Fareza",
    ConfigurationSaving = {
        Enabled = false
    }
})

local Teleport = Window:CreateTab("Teleport")

local selectedLocation = nil

local Dropdown = Teleport:CreateDropdown({
    Name = "Pilih Lokasi",
    Options = {
        "Ocean",
        "Classic Island",
        "Iron Cavern",
        "Underground",
        "Sisyphus"
    },
    Callback = function(opt)
        selectedLocation = opt
    end
})

Teleport:CreateButton({
    Name = "Teleport",
    Callback = function()
        if not selectedLocation then return end

        if selectedLocation == "Ocean" then
            TeleportModule.ToOcean()

        elseif selectedLocation == "Classic Island" then
            TeleportModule.ToClassicIsland()

        elseif selectedLocation == "Iron Cavern" then
            TeleportModule.ToIronCavern()

        elseif selectedLocation == "Underground" then
            TeleportModule.ToUnderground()

        elseif selectedLocation == "Sisyphus" then
            TeleportModule.ToSisyphus()
        end
    end
})

local Fishing = Window:CreateTab("Fishing")

Fishing:CreateToggle({
    Name = "Auto Fishing",
    CurrentValue = false,
    Flag = "AutoFishToggle",
    Callback = function(state)
        if state then
            AutoFish.Aktif()
        else
            AutoFish.Nonaktif()
        end
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

Settings:CreateToggle({
    Name = "Low Texture",
    CurrentValue = false,
    Callback = function(state)
        if state then
            LowTexture.Aktif()
        else
            LowTexture.Nonaktif()
        end
    end,
})

Settings:CreateButton({
    Name = "Rejoin Server",
    Callback = function()
        local TeleportService = game:GetService("TeleportService")
        TeleportService:Teleport(game.PlaceId, game.Players.LocalPlayer)
    end,
})

Settings:CreateButton({
    Name = "Switch Server",
    Callback = function()
        SwitchServer.Apply()
    end,
})

Settings:CreateButton({
    Name = "Exit",
    Callback = function()
        Rayfield:Destroy()
    end,
})
