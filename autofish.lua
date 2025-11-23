local AutoFish = {}
local rodRemote = net:WaitForChild("RF/ChargeFishingRod")
local miniGameRemote = net:WaitForChild("RF/RequestFishingMinigameStarted")
local finishRemote = net:WaitForChild("RE/FishingCompleted")
local RodIdle = ReplicatedStorage:WaitForChild("Modules"):WaitForChild("Animations"):WaitForChild("FishingRodReelIdle")
local RodReel = ReplicatedStorage:WaitForChild("Modules"):WaitForChild("Animations"):WaitForChild("EasyFishReelStart")
local RodShake = ReplicatedStorage:WaitForChild("Modules"):WaitForChild("Animations"):WaitForChild("CastFromFullChargePosition1Hand")

local character = Players.LocalPlayer.Character or Players.LocalPlayer.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local animator = humanoid:FindFirstChildOfClass("Animator") or Instance.new("Animator", humanoid)

local RodShakeAnim = animator:LoadAnimation(RodShake)
local RodIdleAnim = animator:LoadAnimation(RodIdle)
local RodReelAnim = animator:LoadAnimation(RodReel)

local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local FuncAutoFishV2 = {
  REReplicateTextEffectV2 = ReplicatedStorage.Packages._Index["sleitnick_net@0.2.0"].net["RE/ReplicateTextEffect"],
  autofishV2 = false,
  perfectCastV2 = true,
  fishingActiveV2 = false,
  delayInitializedV2 = false
}
local customDelayV2 = 1
local BypassDelayV2 = 0.5

FuncAutoFishV2.REReplicateTextEffectV2.OnClientEvent:Connect(function(data)
  if FuncAutoFishV2.autofishV2 and FuncAutoFishV2.fishingActiveV2
      and data
      and data.TextData
      and data.TextData.EffectType == "Exclaim" then
    local myHead = Players.LocalPlayer.Character and Players.LocalPlayer.Character:FindFirstChild("Head")
    if myHead and data.Container == myHead then
      task.spawn(function()
        for i = 1, 3 do
          task.wait(BypassDelayV2)
          finishRemote:FireServer()
          rconsoleclear()
        end
      end)
    end
  end
end)

function AutoFish.Aktif()
  if FuncAutoFishV2.autofishV2 then return end

  FuncAutoFishV2.autofishV2 = true
  updateDelayBasedOnRodV2(true)
  task.spawn(function()
    while FuncAutoFishV2.autofishV2 do
      pcall(function()
        FuncAutoFishV2.fishingActiveV2 = true

        local equipRemote = net:WaitForChild("RE/EquipToolFromHotbar")
        equipRemote:FireServer(1)
        task.wait(0.1)

        local chargeRemote = ReplicatedStorage
            .Packages._Index["sleitnick_net@0.2.0"].net["RF/ChargeFishingRod"]
        chargeRemote:InvokeServer(workspace:GetServerTimeNow())
        task.wait(0.5)

        local timestamp = workspace:GetServerTimeNow()
        RodShakeAnim:Play()
        rodRemote:InvokeServer(timestamp)

        local baseX, baseY = -0.7499996423721313, 1
        local x, y
        if FuncAutoFishV2.perfectCastV2 then
          x = baseX + (math.random(-500, 500) / 10000000)
          y = baseY + (math.random(-500, 500) / 10000000)
        else
          x = math.random(-1000, 1000) / 1000
          y = math.random(0, 1000) / 1000
        end

        RodIdleAnim:Play()
        miniGameRemote:InvokeServer(x, y)

        task.wait(customDelayV2)
        FuncAutoFishV2.fishingActiveV2 = false
      end)
    end
  end)
end

function AutoFish.Nonaktif()
    FuncAutoFishV2.autofishV2 = false
    FuncAutoFishV2.fishingActiveV2 = false
    FuncAutoFishV2.delayInitializedV2 = false
    RodIdleAnim:Stop()
    RodShakeAnim:Stop()
    RodReelAnim:Stop()
end

return AutoFish
