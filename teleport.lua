local TeleportModule = {}

function TeleportModule.ToOcean()
    local player = game.Players.LocalPlayer
    local char = player.Character or player.CharacterAdded:Wait()
    local root = char:WaitForChild("HumanoidRootPart")
    root.CFrame = CFrame.new(-2659.45972, 5.53963947, -4.4157052)
end

function TeleportModule.ToCreater()
    local player = game.Players.LocalPlayer
    local char = player.Character or player.CharacterAdded:Wait()
    local root = char:WaitForChild("HumanoidRootPart")
    root.CFrame = CFrame.new(1081.57104, 4.11019707, 5093.01611)
end

function TeleportModule.ToUnderground()
    local player = game.Players.LocalPlayer
    local char = player.Character or player.CharacterAdded:Wait()
    local root = char:WaitForChild("HumanoidRootPart")
    root.CFrame = CFrame.new(2096.63135, -91.1976471, -703.089417)
end

function TeleportModule.ToSisyphus()
    local player = game.Players.LocalPlayer
    local char = player.Character or player.CharacterAdded:Wait()
    local root = char:WaitForChild("HumanoidRootPart")
    root.CFrame = CFrame.new(2096.63135, -91.1976471, -703.089417)
end

return TeleportModule
