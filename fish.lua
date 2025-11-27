local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()
local TeleportModule = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/Pangleran/rblx/refs/heads/main/teleport.lua"))()
local LowTexture = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/Pangleran/rblx/refs/heads/main/lowtexture.lua"))()
local AntiAfk = loadstring(game:HttpGet("https://raw.githubusercontent.com/Pangleran/rblx/refs/heads/main/antiafk.lua"))()
local AutoFish = loadstring(game:HttpGet("https://raw.githubusercontent.com/Pangleran/rblx/refs/heads/main/autofish.lua"))()
local AutoSell = loadstring(game:HttpGet("https://raw.githubusercontent.com/Pangleran/rblx/refs/heads/main/autosell.lua"))()

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
    Callback = function(value)
        AutoFish.SetDelayCast(value)
    end,
})

Fishing:CreateInput({
    Name = "Delay Reel (default 5)",
    PlaceholderText = "xx",
    RemoveTextAfterFocusLost = false,
    Callback = function(value)
        AutoFish.SetDelayReel(value)
    end,
})

Fishing:CreateInput({
    Name = "Delay Complete (default 0.2)",
    PlaceholderText = "xx",
    RemoveTextAfterFocusLost = false,
    Callback = function(value)
        AutoFish.SetDelayComplete(value)
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
        Callback = function(state)
            if state then
                AntiAfk.run()
            else
                AntiAfk.stop()
            end
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

Settings:CreateToggle({
        Name = "Auto Sell Fish",
        Callback = function(state)
            if state then
                AutoSell.run()
            else
                AutoSell.stop()
            end
        end,
    })

Settings:CreateButton({
    Name = "Exit",
    Callback = function()
        Rayfield:Destroy()
    end,
})
