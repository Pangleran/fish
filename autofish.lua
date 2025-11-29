local AutoFish = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local VirtualInputManager = game:GetService("VirtualInputManager")
local net = ReplicatedStorage.Packages._Index["sleitnick_net@0.2.0"].net

local Events = {
    fishing = net:WaitForChild("RE/FishingCompleted"),
    charge = net:WaitForChild("RF/ChargeFishingRod"),
    minigame = net:WaitForChild("RF/RequestFishingMinigameStarted"),
    cancel = net:WaitForChild("RF/CancelFishingInputs"),
    equip = net:WaitForChild("RE/EquipToolFromHotbar"),
    unequip = net:WaitForChild("RE/UnequipToolFromHotbar"),
    textfish = net:WaitForChild("RE/ReplicateTextEffect"),
}

AutoFish.Running = false
AutoFish.Click = false
AutoFish.DelayFishing = 1
AutoFish.ClickDelay = 0.1

function AutoFish.SetDelayFishing(v)
    AutoFish.DelayFishing = v
end

function AutoFish.run()
    AutoFish.Running = true

    while AutoFish.Running do
        pcall(function()
            Events.equip:FireServer(1)
            task.wait(0.05)

            Events.charge:InvokeServer(1)
            task.wait(0.1)

            Events.minigame:InvokeServer(1, 1)
        end)

        task.wait(AutoFish.DelayFishing)

        for i = 1, 3 do
            Events.fishing:FireServer()
            task.wait(0.01)
        end

        task.wait(0.1)
    end
end

function AutoFish.stop()
    AutoFish.Running = false
    pcall(function()
        Events.cancel:InvokeServer()
        Events.unequip:FireServer()
    end)
end

function click()
    Event.equip:FireServer(1)
    task.wait(0.02)
    VirtualInputManager:SendMouseButtonEvent(700, 250, 0, true, game, 1)
    task.wait(AutoFish.ClickDelay)
    VirtualInputManager:SendMouseButtonEvent(700, 250, 0, false, game, 1)
end

function AutoFish.runv2()
    AutoFish.Running = true

    click()
    
    while AutoFish.Running do
        Events.textfish.OnClientEvent:Connect(function(data)
            if data and data.TextData and data.TextData.EffectType == "Exclaim" then
                local head = Players.LocalPlayer.Character and Players.LocalPlayer.Character:FindFirstChild("Head")
                if head and data.Container == head then
                    task.wait(AutoFish.DelayFishing)
                    pcall(function()
                        Events.fishing:FireServer()
                        click()
                    end)
                end
            end
        end)
        task.wait(0.5)
    end
end

function AutoFish.stopv2()
    AutoFish.Running = false
end

function AutoFish.recovery()
    if AutoFish.Running == true then
        AutoFish.Running = false
        task.wait()
        Events.cancel:InvokeServer()
        task.wait()
        Events.unequip:FireServer()
    end
end

return AutoFish
