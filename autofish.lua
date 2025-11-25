local AutoFish = {}
local RunService = game:GetService("RunService")

local fishingLoop
local Config = {
    AutoFish = false,
    BlatantMode = false,
    FishDelay = 0.9,
    CatchDelay = 0.2
}

-- =====================
--  AKTIF
-- =====================
function AutoFish.Aktif()
    Config.AutoFish = true

    if fishingLoop then
        fishingLoop:Disconnect()
    end

    fishingLoop = RunService.Heartbeat:Connect(function()
        if not Config.AutoFish then return end

        pcall(function()
            -- cast
            game.ReplicatedStorage.Events.equip:FireServer(1)
            task.wait(Config.FishDelay)

            -- pull / catch
            game.ReplicatedStorage.Events.charge:InvokeServer(1)
            task.wait(Config.CatchDelay)
        end)
    end)
end


-- =====================
--  NONAKTIF
-- =====================
function AutoFish.Nonaktif()
    Config.AutoFish = false

    if fishingLoop then
        fishingLoop:Disconnect()
        fishingLoop = nil
    end
end

return AutoFish