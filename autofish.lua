local AutoFish = {}

-- CORE SERVICES
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")
local VirtualUser = game:GetService("VirtualUser")
local LocalPlayer = Players.LocalPlayer

if not LocalPlayer then
    error("[AutoFish] LocalPlayer not found!")
end

-- CONFIG & EVENTS (HARUS DIISI SESUAI GAME)
local Events = {
    equip = ReplicatedStorage:WaitForChild("Equip"),
    charge = ReplicatedStorage:WaitForChild("Charge"),
    minigame = ReplicatedStorage:WaitForChild("Minigame"),
    fishing = ReplicatedStorage:WaitForChild("Fishing")
}

local Config = {
    CatchDelay = 1 -- delay antara catch, bisa disesuaikan
}

local isFishing = false
local AutoCatch = false

-- CAST ROD
local function castRod()
    pcall(function()
        Events.equip:FireServer(1)
        task.wait(0.05)
        Events.charge:InvokeServer(1755848498.4834)
        task.wait(0.02)
        Events.minigame:InvokeServer(1.2854545116425, 1)
        print("[Fishing] 🎣 Cast")
    end)
end

-- REEL IN
local function reelIn()
    pcall(function()
        Events.fishing:FireServer()
        print("[Fishing] ✔ Reel")
    end)
end

-- AUTO CATCH LOOP
task.spawn(function()
    while true do
        if AutoCatch and not isFishing then
            pcall(function()
                Events.fishing:FireServer()
            end)
        end
        task.wait(Config.CatchDelay)
    end
end)

-- AKTIFKAN AUTO FISH
function AutoFish.Aktif()
    if not isFishing then
        isFishing = true
        castRod()
        task.wait(0.9)
        reelIn()
        task.wait(0.2)
        isFishing = false
    end
end

-- NONAKTIFKAN AUTO FISH
function AutoFish.Nonaktif()
    AutoCatch = false
    isFishing = false
    print("[AutoFish] Nonaktif")
end

return AutoFish
