local AntiAfk = {}

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer or Players.PlayerAdded:Wait()
local VirtualUser = game:GetService("VirtualUser")

local AntiAFKConnection

function AntiAfk.Apply(state)
  if state then
    if AntiAFKConnection then AntiAFKConnection:Disconnect() end

    AntiAFKConnection = LocalPlayer.Idled:Connect(function()
      VirtualUser:CaptureController()
      VirtualUser:ClickButton2(Vector2.new())
    end)
  else
    if AntiAFKConnection then
      AntiAFKConnection:Disconnect()
      AntiAFKConnection = nil
    end
  end
end

return AntiAfk
