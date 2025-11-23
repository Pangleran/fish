local AutoFish = {}

function AutoFish.Apply()
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

return AutoFish
