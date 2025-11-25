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
AutoFish.DelayCast = 1
AutoFish.DelayReel = 5
AutoFish.DelayComplete = 0.2

function AutoFish.DelayCast(v)
    AutoFish.DelayCast = v
end

function AutoFish.DelayReel(v)
    AutoFish.DelayReel = v
end

function AutoFish.DelayComplete(v)
    AutoFish.DelayComplete = v
end

function AutoFish.Aktif()
    AutoFish.Running = true

    while AutoFish.Running do
        pcall(function()
            Events.equip:FireServer(1)
            task.wait(0.05)

            Events.charge:InvokeServer(1755848498.4834)
            task.wait(0.02)

            Events.minigame:InvokeServer(1.2854545116425, 1)
        end)

        task.wait(AutoFish.DelayCast)

        for i = 1, AutoFish.DelayReel do
            Events.fishing:FireServer()
            task.wait(0.01)
        end

        task.wait(AutoFish.DelayComplete)
    end
end

function AutoFish.Nonaktif()
    AutoFish.Running = false
    pcall(function()
        Events.unequip:FireServer()
    end)
end

return AutoFish
