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
        

function AutoFish.Aktif()
    while true do
        pcall(function()
            Events.equip:FireServer(1)
            task.wait(0.05)
            Events.charge:InvokeServer(1755848498.4834)
            task.wait(0.02)
            Events.minigame:InvokeServer(1.2854545116425, 1)
            task.wait(0.9)
            for i = 1, 5 do
                pcall(function() 
                    Events.fishing:FireServer() 
                end)
                task.wait(0.01)
            end
            task.wait(0.2 * 0.5)
        end)
    end
end

function AutoFish.Nonaktif()
    Events.cance
    Events.unequip:FireServer(1)
end

return AutoFish