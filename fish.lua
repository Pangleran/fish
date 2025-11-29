local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

local TeleportModule = loadstring(game:HttpGet("https://raw.githubusercontent.com/Pangleran/rblx/refs/heads/main/teleport.lua"))()
local LowTexture = loadstring(game:HttpGet("https://raw.githubusercontent.com/Pangleran/rblx/refs/heads/main/lowtexture.lua"))()
local AntiAfk = loadstring(game:HttpGet("https://raw.githubusercontent.com/Pangleran/rblx/refs/heads/main/antiafk.lua"))()
local AutoFish = loadstring(game:HttpGet("https://raw.githubusercontent.com/Pangleran/rblx/refs/heads/main/autofish.lua"))()
local AutoSell = loadstring(game:HttpGet("https://raw.githubusercontent.com/Pangleran/rblx/refs/heads/main/autosell.lua"))()

local Window = WindUI:CreateWindow({
    Title = "Fish it",
    Icon = "rbxassetid://124360663785796",
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
        if selectedLocation == nil then return end
        teleportList[selectedLocation]()
        WindUI:Notify({
            Title = "✅ Teleport",
            Content = "to " .. selectedLocation,
            Duration = 2
        })
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
        WindUI:Notify({
            Title = "✅ Set Delay",
            Content = "to " .. num .. " second",
            Duration = 2
        })
        task.wait(0.5)
        AutoFish.SetDelayFishing(num)
    end
})

FishingTab:Toggle({
    Title = "Auto Fishing",
    Desc = "otomatis memancing",
    Default = false,
    Callback = function(s)
        if s then
            WindUI:Notify({
                Title = "🟢 Fishing",
                Content = "mengaktifkan auto fishing",
                Duration = 2
            })
            task.wait(0.5)
            AutoFish.run()
        else
            WindUI:Notify({
                Title = "🔴 Fishing",
                Content = "menghentikan auto fishing",
                Duration = 2
            })
            task.wait(0.5)
            AutoFish.stop()
        end
    end
})

FishingTab:Button({
    Title = "Recovery Fishing",
    Desc = "memperbaiki bug/crash pancing",
    Callback = function()
        WindUI:Notify({
            Title = "✅ Recovery Fishing",
            Content = "memperbaiki bug atau crash",
            Duration = 2
        })
        task.wait(0.5)
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
        if s then
            WindUI:Notify({
                Title = "🟢 Anti Afk",
                Content = "mengaktifkan anti disconnect",
                Duration = 2
            })
            task.wait(0.5)
            AntiAfk.run()
        else
            WindUI:Notify({
                Title = "🔴 Anti Afk",
                Content = "menghentikan anti disconnect",
                Duration = 2
            })
            task.wait(0.5)
            AntiAfk.stop()
        end
    end
})

SettingsTab:Toggle({
    Title = "Low Texture",
    Desc = "smooth & boost fps",
    Callback = function(s)
        if s then
            WindUI:Notify({
                Title = "🟢 Low Texture",
                Content = "mengaktifkan smooth texture",
                Duration = 2
            })
            task.wait(0.5)
            LowTexture.run()
        else
            WindUI:Notify({
                Title = "🔴 Low Texture",
                Content = "mengembalikan texture",
                Duration = 2
            })
            task.wait(0.5)
            Lowtexture.stop()
        end
    end
})

SettingsTab:Toggle({
    Title = "Auto Sell Fish",
    Desc = "otomatis setiap 1 menit",
    Callback = function(s)
        if s then
            WindUI:Notify({
                Title = "🟢 Selling Fish",
                Content = "mengaktifkan auto sell",
                Duration = 2
            })
            task.wait(0.5)
            AutoSell.run()
        else
            WindUI:Notify({
                Title = "🔴 Selling Fish",
                Content = "menghentikan auto sell",
                Duration = 2
            })
            task.wait(0.5)
            AutoSell.stop()
        end
    end
})
