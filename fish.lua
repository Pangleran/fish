local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

WindUI:Gradient({
    ["0"] = {
        Color = Color3.fromHex("#00111d"), -- Biru sangat gelap (deep ocean)
        Transparency = 0
    },

    ["50"] = {
        Color = Color3.fromHex("#004e89"), -- Biru tua ke laut dalam
        Transparency = 0
    },

    ["100"] = {
        Color = Color3.fromHex("#009dff"), -- Biru muda terang seperti permukaan air
        Transparency = 0
    },
}, {
    Rotation = 90, -- Bisa 0, 45, 90, 180 sesuai arah gradient
})

local TeleportModule = loadstring(game:HttpGet("https://raw.githubusercontent.com/Pangleran/rblx/refs/heads/main/teleport.lua"))()
local LowTexture = loadstring(game:HttpGet("https://raw.githubusercontent.com/Pangleran/rblx/refs/heads/main/lowtexture.lua"))()
local AntiAfk = loadstring(game:HttpGet("https://raw.githubusercontent.com/Pangleran/rblx/refs/heads/main/antiafk.lua"))()
local AutoFish = loadstring(game:HttpGet("https://raw.githubusercontent.com/Pangleran/rblx/refs/heads/main/autofish.lua"))()
local AutoSell = loadstring(game:HttpGet("https://raw.githubusercontent.com/Pangleran/rblx/refs/heads/main/autosell.lua"))()

local Window = WindUI:CreateWindow({
    Title = "Fish it",
    Icon = "door-open",
    Author = "by iky fareza",
    Folder = "fishit_ikyfareza",
    
    -- ↓ This all is Optional. You can remove it.
    Size = UDim2.fromOffset(580, 460),
    MinSize = Vector2.new(560, 350),
    MaxSize = Vector2.new(850, 560),
    Transparent = true,
    Theme = "Dark",
    Resizable = true,
    SideBarWidth = 200,
    BackgroundImageTransparency = 0.42,
    HideSearchBar = true,
    ScrollBarEnabled = false,
    
    -- ↓ Optional. You can remove it.
    --[[ You can set 'rbxassetid://' or video to Background.
        'rbxassetid://':
            Background = "rbxassetid://", -- rbxassetid
        Video:
            Background = "video:YOUR-RAW-LINK-TO-VIDEO.webm", -- video 
    --]]
    
    --       remove this all, 
    -- !  ↓  if you DON'T need the key system
    KeySystem = { 
        -- ↓ Optional. You can remove it.
        Key = { "iky", "cici" },
        
        Note = "press get key and join whatsapp",
        
        -- ↓ Optional. You can remove it.
        --[[
        Thumbnail = {
            Image = "rbxassetid://",
            Title = "Thumbnail",
        },
        --]]
        
        -- ↓ Optional. You can remove it.
        URL = "https://chat.whatsapp.com/KWQbg7nK11MHU90SGwGP7z?mode=hqrc",
        
        -- ↓ Optional. You can remove it.
        SaveKey = false, -- automatically save and load the key.
        
        -- ↓ Optional. You can remove it.
        -- API = {} ← Services. Read about it below ↓
    },
})

Window:DisableTopbarButtons({
    "Close", 
    "Fullscreen",
})

Window:EditOpenButton({
    Title = "Iky Fareza",
    Icon = "monitor",
    CornerRadius = UDim.new(0,16),
    StrokeThickness = 2,
    Color = ColorSequence.new(
        Color3.fromHex("FF0F7B"), 
        Color3.fromHex("F89B29")
    ),
    OnlyMobile = false,
    Enabled = true,
    Draggable = true,
})

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
    Callback = function()
        if selectedLocation then
            teleportList[selectedLocation]()
        end
    end
})

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
            Duration = 2
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
    Callback = function()
        AutoFish.recovery()
    end
})

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
