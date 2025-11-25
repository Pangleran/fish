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
            task.wait(0.01)

            -- Cast 1
            task.spawn(function()
                Events.charge:InvokeServer(1755848498.4834)
                task.wait(0.01)
                Events.minigame:InvokeServer(1.2854545116425, 1)
            end)

            task.wait(0.05)

            -- Cast 2 (overlapping)
            task.spawn(function()
                Events.charge:InvokeServer(1755848498.4834)
                task.wait(0.01)
                Events.minigame:InvokeServer(1.2854545116425, 1)
            end)
        end)

        task.wait()

        for i = 1, 5 do
            Events.fishing:FireServer()
            task.wait(0.005)
        end

        task.wait(0.05)
    end
end

function AutoFish.Nonaktif()
    AutoFish.Running = false
    pcall(function()
        Events.unequip:FireServer()
    end)
end

return AutoFish
