-- autofish.lua (FIXED)
local AutoFish = {}

local isFishing = false
local fishingActive = false

-- Helper functions
local function castRod()
pcall(function()
    Events.equip:FireServer(1)
    task.wait(0.05)
    Events.charge:InvokeServer(1755848498.4834)
    task.wait(0.02)
    Events.minigame:InvokeServer(1.2854545116425, 1)
    print("[Fishing] ðŸŽ£ Cast")
end)
end

local function reelIn()
pcall(function()
    Events.fishing:FireServer()
    print("[Fishing] âœ… Reel")
end)
end
----------------------------------------------------------------
-- AKTIFKAN AUTO FISH
----------------------------------------------------------------
function AutoFish.Aktif()
    if FuncAutoFishV2.autofishV2 then return end

    FuncAutoFishV2.autofishV2 = true
    FuncAutoFishV2.perfectCastV2 = true
    updateDelayBasedOnRodV2(true)

    task.spawn(function()
        while FuncAutoFishV2.autofishV2 do
            pcall(function()

                FuncAutoFishV2.fishingActiveV2 = true

                -- EQUIP ROD
                local equipRemote = NetFolder:WaitForChild("RE/EquipToolFromHotbar")
                equipRemote:FireServer(1)
                task.wait(0.1)

                -- CHARGE ROD
                rodRemote:InvokeServer(workspace:GetServerTimeNow())
                task.wait(0.5)

                -- CAST ANIMATION
                if RodShakeAnim then RodShakeAnim:Play() end
                rodRemote:InvokeServer(workspace:GetServerTimeNow())

                -- CAST VALUES
                local baseX, baseY = -0.7499996423721313, 1
                local x, y

                if FuncAutoFishV2.perfectCastV2 then
                    x = baseX + math.random(-500, 500) / 1e7
                    y = baseY + math.random(-500, 500) / 1e7
                else
                    x = math.random(-1000, 1000) / 1000
                    y = math.random(0, 1000) / 1000
                end

                if RodIdleAnim then RodIdleAnim:Play() end
                miniGameRemote:InvokeServer(x, y)

                task.wait(customDelayV2)
                FuncAutoFishV2.fishingActiveV2 = false
            end)
        end
    end)
end


----------------------------------------------------------------
-- NONAKTIFKAN AUTO FISH
----------------------------------------------------------------
function AutoFish.Nonaktif()
    FuncAutoFishV2.autofishV2 = false
    FuncAutoFishV2.fishingActiveV2 = false
    FuncAutoFishV2.delayInitializedV2 = false

    if RodIdleAnim then RodIdleAnim:Stop() end
    if RodShakeAnim then RodShakeAnim:Stop() end
    if RodReelAnim then RodReelAnim:Stop() end
end

return AutoFish
