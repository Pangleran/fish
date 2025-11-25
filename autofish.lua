local AutoFish = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local net = ReplicatedStorage.Packages._Index["sleitnick_net@0.2.0"].net

local Events = {
    fishing = net:WaitForChild("RE/FishingCompleted"),
    charge = net:WaitForChild("RF/ChargeFishingRod"),
    minigame = net:WaitForChild("RF/RequestFishingMinigameStarted"),
    cancel = net:WaitForChild("RF/CancelFishingInputs"),
    equip = net:WaitForChild("RE/EquipToolFromHotbar"),
    unequip = net:WaitForChild("RE/UnequipToolFromHotbar"),
}

AutoFish.Running = false
AutoFish.DelayCastValue = 0.1
AutoFish.DelayReelValue = 15
AutoFish.DelayCompleteValue = 0.05

function AutoFish.SetDelayCast(v)
    AutoFish.DelayCastValue = v
end

function AutoFish.SetDelayReel(v)
    AutoFish.DelayReelValue = v
end

function AutoFish.SetDelayComplete(v)
    AutoFish.DelayCompleteValue = v
end

function AutoFish.Aktif()
    AutoFish.Running = true

    while AutoFish.Running do
        pcall(function()
            Events.equip:FireServer(1)
            task.wait(0.02)

            Events.charge:InvokeServer(9999999999)
            task.wait(0.01)
            Events.minigame:InvokeServer(9999, 1)
        end)

        task.wait(AutoFish.DelayCastValue)

        for i = 1, AutoFish.DelayReelValue do
            Events.fishing:FireServer()
            task.wait(0.005)
        end

        task.wait(AutoFish.DelayCompleteValue)
    end
end

function AutoFish.Nonaktif()
    AutoFish.Running = false
    pcall(function()
        Events.unequip:FireServer()
    end)
end

return AutoFish
