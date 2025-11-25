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

local buttons = {
    ["Teleport to Ocean"] = TeleportModule.ToOcean,
    ["Teleport to Classic Island [NEW]"] = TeleportModule.ToClassicIsland,
    ["Teleport to Iron Cavern [NEW]"] = TeleportModule.ToIronCavern,
    ["Teleport to Underground (element progress)"] = TeleportModule.ToUnderground,
    ["Teleport to Sisyphus (ghostfin progress)"] = TeleportModule.ToSisyphus
}

for name, func in pairs(buttons) do
    Teleport:CreateButton({
        Name = name,
        Callback = func
    })
end

local Fishing = Window:CreateTab("Fishing")

Fishing:CreateInput({
    Name = "Delay Cast (default 1)",
    PlaceholderText = "xx",
    RemoveTextAfterFocusLost = false,
    Callback = function(text)
        local value = tonumber(text)
        if value then
            AutoFish.SetDelayCast(value)
        end
    end,
})

Fishing:CreateInput({
    Name = "Delay Reel (default 5)",
    PlaceholderText = "xx",
    RemoveTextAfterFocusLost = false,
    Callback = function(text)
        local value = tonumber(text)
        if value then
            AutoFish.SetDelayReel(value)
        end
    end,
})

Fishing:CreateInput({
    Name = "Delay Complete (default 0.2)",
    PlaceholderText = "xx",
    RemoveTextAfterFocusLost = false,
    Callback = function(text)
        local value = tonumber(text)
        if value then
            AutoFish.SetDelayComplete(value)
        end
    end,
})

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
