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

local function fishingLoop()
while fishingActive do
    if Config.BlatantMode then
        blatantFishingLoop()
    else
        normalFishingLoop()
    end
    task.wait(0.1)
end
end

----------------------------------------------------------------
-- AKTIFKAN AUTO FISH
----------------------------------------------------------------
function AutoFish.Aktif()
    if not isFishing then
        isFishing = true

        castRod()
        task.wait(0.9)
        reelIn()
        task.wait(0.2)

        isFishing = false
    else
        task.wait(0.1)
    end
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
