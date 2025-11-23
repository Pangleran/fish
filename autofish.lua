-- autofish.lua (FIXED)
local AutoFish = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local Packages = ReplicatedStorage:WaitForChild("Packages")
local Index = Packages:WaitForChild("_Index")
local NetFolder = Index:WaitForChild("sleitnick_net@0.2.0"):WaitForChild("net")

local rodRemote = NetFolder:WaitForChild("RF/ChargeFishingRod")
local miniGameRemote = NetFolder:WaitForChild("RF/RequestFishingMinigameStarted")
local finishRemote = NetFolder:WaitForChild("RE/FishingCompleted")

local ReplicateText = NetFolder:WaitForChild("RE/ReplicateTextEffect")

-- ANIMASI
local modules = ReplicatedStorage:WaitForChild("Modules")
local animFolder = modules:WaitForChild("Animations")

local RodShake = animFolder:FindFirstChild("CastFromFullChargePosition1Hand")
local RodIdle = animFolder:FindFirstChild("FishingRodReelIdle")
local RodReel = animFolder:FindFirstChild("EasyFishReelStart")

local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

local animator = humanoid:FindFirstChildOfClass("Animator") or Instance.new("Animator", humanoid)

local RodShakeAnim = RodShake and animator:LoadAnimation(RodShake)
local RodIdleAnim = RodIdle and animator:LoadAnimation(RodIdle)
local RodReelAnim = RodReel and animator:LoadAnimation(RodReel)

-- SYSTEM
local FuncAutoFishV2 = {
    REReplicateTextEffectV2 = ReplicateText,
    autofishV2 = false,
    perfectCastV2 = true,
    fishingActiveV2 = false,
    delayInitializedV2 = false
}

local customDelayV2 = 1
local BypassDelayV2 = 0.5

-- SAFE CLEAR RCONSOLE
local function SafeClear()
    if rconsoleclear then
        pcall(function() rconsoleclear() end)
    end
end

-- DELAY HANDLER
function updateDelayBasedOnRodV2(first)
    customDelayV2 = first and 1 or 0.8
end

-- TEXT EFFECT LISTENER
FuncAutoFishV2.REReplicateTextEffectV2.OnClientEvent:Connect(function(data)
    if not FuncAutoFishV2.autofishV2 then return end
    if not FuncAutoFishV2.fishingActiveV2 then return end

    if data and data.TextData and data.TextData.EffectType == "Exclaim" then
        local head = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Head")

        if head and data.Container == head then
            task.spawn(function()
                for i = 1, 3 do
                    task.wait(BypassDelayV2)
                    finishRemote:FireServer()
                    SafeClear()
                end
            end)
        end
    end
end)


----------------------------------------------------------------
-- AKTIFKAN AUTO FISH
----------------------------------------------------------------
function AutoFish.Aktif()
    if FuncAutoFishV2.autofishV2 then return end

    FuncAutoFishV2.autofishV2 = true
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
