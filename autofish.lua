local AutoFish = {}
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LocalPlayer = Players.LocalPlayer

-- event asli
local Events = {
    equip = ReplicatedStorage.Events.equip,
    charge = ReplicatedStorage.Events.charge,
    minigame = ReplicatedStorage.Events.minigame,
    fishing = ReplicatedStorage.Events.fishing,
    sell = ReplicatedStorage.Events.sell,
}

-- config normal
local Config = {
    AutoFish = false,
    AutoCatch = false,
    AutoSell = false,
    FishDelay = 0.9,
    CatchDelay = 0.2,
    SellDelay = 30,
}

local fishingActive = false
local isFishing = false
local fishingLoop

-- cast
local function castRod()
    pcall(function()
        Events.equip:FireServer(1)
        task.wait(0.05)
        Events.charge:InvokeServer(1755848498.4834)
        task.wait(0.02)
        Events.minigame:InvokeServer(1.2854545116425, 1)
    end)
end

-- reel / catch
local function reelIn()
    pcall(function()
        Events.fishing:FireServer()
    end)
end

-- loop normal fishing
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

-- auto catch
task.spawn(function()
    while true do
        if Config.AutoCatch and not isFishing then
            pcall(function()
                Events.fishing:FireServer()
            end)
        end
        task.wait(Config.CatchDelay)
    end
end)

-- auto sell
local function simpleSell()
    pcall(function()
        Events.sell:InvokeServer()
    end)
end

task.spawn(function()
    while true do
        task.wait(Config.SellDelay)
        if Config.AutoSell then
            simpleSell()
        end
    end
end)

-- Aktif
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

-- Nonaktif
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