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
            -- Equip
            Events.equip:FireServer(1)
            task.wait(0.02)

            -- Cast
            Events.charge:InvokeServer(1755848498.4834)
            task.wait(0.01)
            Events.minigame:InvokeServer(1.2854545116425, 1)
            task.wait(0.15)

            -- BRUTAL REEL SPAM (tanpa berhenti)
            local start = tick()
            while AutoFish.Running and tick() - start < 1.2 do
                Events.fishing:FireServer()
                task.wait(0.002) -- super cepat
            end
        end)

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
