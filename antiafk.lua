local AntiAfk = {}

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer or Players.PlayerAdded:Wait()
local VirtualUser = game:GetService("VirtualUser")

local AntiAFKConnection

function AntiAfk.run()
  AntiAFKConnection = LocalPlayer.Idled:Connect(function()
      VirtualUser:CaptureController()
      VirtualUser:ClickButton2(Vector2.new())
    end)
end

function AntiAfk.stop()
  AntiAFKConnection:Disconnect()
  AntiAFKConnection = nil
end

return AntiAfk
