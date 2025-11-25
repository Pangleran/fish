local AutoFish = {}
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LocalPlayer = Players.LocalPlayer

function AutoFish.Aktif()
    pcall(function()
        if Events.equip and Events.charge and Events.minigame then
            Events.equip:FireServer(1)
            task.wait(0.05)
            Events.charge:InvokeServer(1755848498.4834)
            task.wait(0.02)
            Events.minigame:InvokeServer(1.2854545116425, 1)
        end
    end)
end

return AutoFish