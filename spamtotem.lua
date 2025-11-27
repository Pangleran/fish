local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local root = char:WaitForChild("HumanoidRootPart")

-- Titik awal
local origin = Vector3.new(xxx, xxx, xxx)
root.CFrame = CFrame.new(origin)

task.wait(5)

local positions = {
    Left        = origin + Vector3.new(-100, 0, 0),
    Right       = origin + Vector3.new(100, 0, 0),
    Front       = origin + Vector3.new(0, 0, 100),
    Back        = origin + Vector3.new(0, 0, -100),
    Up          = origin + Vector3.new(0, 100, 0),
    Down        = origin + Vector3.new(0, -100, 0),

    UpLeft      = origin + Vector3.new(-100, 100, 0),
    UpRight     = origin + Vector3.new(100, 100, 0),
    UpFront     = origin + Vector3.new(0, 100, 100),
    UpBack      = origin + Vector3.new(0, 100, -100),
}

for name, pos in pairs(positions) do
    print("Teleport:", name)
    root.CFrame = CFrame.new(pos)
    task.wait(5) -- delay antar teleport (bisa kamu kecilkan)
end
