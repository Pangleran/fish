local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

local TeleportModule = loadstring(game:HttpGet("https://raw.githubusercontent.com/Pangleran/rblx/refs/heads/main/teleport.lua"))()
local LowTexture = loadstring(game:HttpGet("https://raw.githubusercontent.com/Pangleran/rblx/refs/heads/main/lowtexture.lua"))()
local AntiAfk = loadstring(game:HttpGet("https://raw.githubusercontent.com/Pangleran/rblx/refs/heads/main/antiafk.lua"))()
local AutoFish = loadstring(game:HttpGet("https://raw.githubusercontent.com/Pangleran/rblx/refs/heads/main/autofish.lua"))()
local AutoSell = loadstring(game:HttpGet("https://raw.githubusercontent.com/Pangleran/rblx/refs/heads/main/autosell.lua"))()

local Window = WindUI:CreateWindow({
    Title = "Fish it - Iky Fareza",
    Theme = "Dark",

    PrimaryColor = Color3.fromHex("A259FF"),
    SecondaryColor = Color3.fromHex("2B1A38"),
    TertiaryColor = Color3.fromHex("1A1122"),

    TextColor = Color3.fromHex("E4CCFF"),
    Font = Enum.Font.GothamMedium,
    TitleFont = Enum.Font.GothamBold,

    TitleSize = 20,
    TextSize = 17,

    CornerRadius = UDim.new(0, 14),
    Padding = 12,
})

Window:EditOpenButton({
    Title = "Iky Fareza",
    Icon = "widgets",
    CornerRadius = UDim.new(0,16),
    StrokeThickness = 2,
    Color = ColorSequence.new(
        Color3.fromHex("A259FF"), 
        Color3.fromHex("6E00FF")
    ),
    Draggable = true,
})

--------------------------------------------------------
-- TELEPORT TAB
--------------------------------------------------------

local TeleportTab = Window:Tab({
    Title = "Teleport",
    Locked = false,
})

local teleportList = {
    ["Ocean"] = TeleportModule.ToOcean,
    ["Classic Island [NEW]"] = TeleportModule.ToClassicIsland,
    ["Iron Cavern [NEW]"] = TeleportModule.ToIronCavern,
    ["Underground"] = TeleportModule.ToUnderground,
    ["Sisyphus"] = TeleportModule.ToSisyphus
}

local selectedLocation = nil

TeleportTab:Dropdown({
    Title = "Teleport Locations",
    Desc = "pilih pulau",
    Values = { "Ocean", "Classic Island [NEW]", "Iron Cavern [NEW]", "Underground", "Sisyphus" },
    Value = "Ocean",
    Callback = function(v)
        selectedLocation = v
    end
})

TeleportTab:Button({
    Title = "Teleport to Selected",
    Desc = "berpindah ke pulau",
    Icon = "send",
    Callback = function()
        if selectedLocation then
            teleportList[selectedLocation]()
        end
    end
})

--------------------------------------------------------
-- FISHING TAB
--------------------------------------------------------

local FishingTab = Window:Tab({
    Title = "Fishing",
    Locked = false,
})

FishingTab:Input({
    Title = "Set Delay Fishing",
    Desc = "default: 1",
    Type = "Input",
    Placeholder = "0.1 ~ 2",
    Callback = function(v)
        local num = tonumber(v)
        if not num then return end
        if num < 0.1 then num = 0.1 end
        if num > 2 then num = 2 end

        AutoFish.SetDelayFishing(num)

        WindUI:Notify({
            Title = "Set Delay",
            Content = "to " .. num .. " second",
            Duration = 2,
        })
    end
})

FishingTab:Toggle({
    Title = "Auto Fishing",
    Desc = "otomatis memancing",
    Default = false,
    Callback = function(s)
        if s then AutoFish.run() else AutoFish.stop() end
    end
})

FishingTab:Button({
    Title = "Recovery Fishing",
    Desc = "memperbaiki bug/crash pancing",
    Icon = "restart_alt",
    Callback = function()
        AutoFish.recovery()
    end
})

--------------------------------------------------------
-- SETTINGS TAB
--------------------------------------------------------

local SettingsTab = Window:Tab({
    Title = "Settings",
    Locked = false,
})

SettingsTab:Toggle({
    Title = "Anti AFK",
    Desc = "menghindari putus koneksi",
    Callback = function(s)
        if s then AntiAfk.run() else AntiAfk.stop() end
    end
})

SettingsTab:Toggle({
    Title = "Low Texture",
    Desc = "smooth & boost fps",
    Callback = function(s)
        if s then LowTexture.run() else LowTexture.stop() end
    end
})

SettingsTab:Toggle({
    Title = "Auto Sell Fish",
    Desc = "otomatis setiap 1 menit",
    Callback = function(s)
        if s then AutoSell.run() else AutoSell.stop() end
    end
})
