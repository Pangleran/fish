local AntiAfk = {}

function AntiAfk.Apply(state)
  if state then
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
