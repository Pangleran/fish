local AutoFish = {}
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LocalPlayer = Players.LocalPlayer

-- event asli (pakai WaitForChild)
local Events = {}
pcall(function()
    local eventFolder = ReplicatedStorage:WaitForChild("Events", 5)
    Events.equip = eventFolder:WaitForChild("equip", 5)
    Events.charge = eventFolder:WaitForChild("charge", 5)
    Events.minigame = eventFolder:WaitForChild("minigame", 5)
    Events.fishing = eventFolder:WaitForChild("fishing", 5)
end)

local Config = {
    AutoFish = false,
    AutoCatch = false,
    FishDelay = 0.9,
    CatchDelay = 0.2,
}

local fishingActive = false
local isFishing = false
local fishingLoop

local function castRod()
    pcall(function()
        if Events.equip and Events.charge and Events.minigame then
            Events.equip:FireServer(1)
            task.wait(0.05)
            Events.charge:InvokeServer(1755848498.4834)
            task.wait(0.02)
            Events.minigame:InvokeServer(1.2854545116425, 1)
        end
    end)
end

local function reelIn()
    pcall(function()
        if Events.fishing then
            Events.fishing:FireServer()
        end
    end)
end

local function normalFishingLoop()
    while fishingActive do
        if not isFishing then
            isFishing = true
            castRod()
            task.wait(Config.FishDelay)
            reelIn()
            task.wait(Config.CatchDelay)
            isFishing = false
        else
            task.wait(0.1)
        end
    end
end

task.spawn(function()
    while true do
        if Config.AutoCatch and not isFishing and Events.fishing then
            pcall(function()
                Events.fishing:FireServer()
            end)
        end
        task.wait(Config.CatchDelay)
    end
end)

function AutoFish.Aktif()
    Config.AutoFish = true
    fishingActive = true

    if fishingLoop then
        fishingLoop:Disconnect()
    end

    fishingLoop = RunService.Heartbeat:Connect(function()
        normalFishingLoop()
    end)
end

function AutoFish.Nonaktif()
    Config.AutoFish = false
    fishingActive = false

    if fishingLoop then
        fishingLoop:Disconnect()
        fishingLoop = nil
    end
end

AutoFish.Config = Config
return AutoFish