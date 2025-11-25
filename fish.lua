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
    Name = "Teleport to Classic Island [NEW]",
    Callback = function()
        TeleportModule.ToClassicIsland()
    end,
})

Teleport:CreateButton({
    Name = "Teleport to Iron Cavern [NEW]",
    Callback = function()
        TeleportModule.ToIronCavern()
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

Settings:CreateButton({
    Name = "Low Texture",
    Callback = function()
        LowTexture.Apply()
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
        local TeleportService = game:GetService("TeleportService")
        local HttpService = game:GetService("HttpService")
        local PlaceId = game.PlaceId

        local success, result = pcall(function()
            return HttpService:JSONDecode(
                game:HttpGet("https://games.roblox.com/v1/games/"..PlaceId.."/servers/Public?sortOrder=Asc&limit=100")
            )
        end)

        if success and result and result.data then
            for _, v in pairs(result.data) do
                if v.playing < v.maxPlayers then
                    TeleportService:TeleportToPlaceInstance(PlaceId, v.id)
                    break
                end
            end
        end
    end,
})

Settings:CreateButton({
    Name = "Exit",
    Callback = function()
        Rayfield:Destroy()
    end,
})