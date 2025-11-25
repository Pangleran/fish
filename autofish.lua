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

function AutoFish.Aktif()
    AutoFish.Running = true

    while AutoFish.Running do
        pcall(function()
            Events.equip:FireServer(1)
            task.wait()

            Events.charge:InvokeServer(9999999999)
            task.wait()

            Events.minigame:InvokeServer(0, 1)
            task.wait()

            for i = 1, 50 do
                Events.fishing:FireServer()
            end
        end)

        task.wait()
    end
end

function AutoFish.Nonaktif()
    AutoFish.Running = false
    pcall(function()
        Events.unequip:FireServer()
    end)
end

return AutoFish
