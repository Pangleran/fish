local LowTexture = {}

local gpuActive = false
local whiteScreen = nil


-- ======================
-- FUNGSI AKTIF
-- ======================
function LowTexture.Aktif()
    if gpuActive then return end
    gpuActive = true

    pcall(function()
        settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
        game.Lighting.GlobalShadows = false
        game.Lighting.FogEnd = 1
        setfpscap(8)
    end)

    whiteScreen = Instance.new("ScreenGui")
    whiteScreen.ResetOnSpawn = false
    whiteScreen.DisplayOrder = 999999

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
    frame.Parent = whiteScreen

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0, 400, 0, 100)
    label.Position = UDim2.new(0.5, -200, 0.5, -50)
    label.BackgroundTransparency = 1
    label.Text = "🔋 GPU SAVER ACTIVE\n\nAuto Fish Running..."
    label.TextColor3 = Color3.new(0, 1, 0)
    label.TextSize = 28
    label.Font = Enum.Font.GothamBold
    label.TextXAlignment = Enum.TextXAlignment.Center
    label.Parent = frame

    whiteScreen.Parent = game.CoreGui
end


-- ======================
-- FUNGSI NONAKTIF
-- ======================
function LowTexture.Nonaktif()
    if not gpuActive then return end
    gpuActive = false

    pcall(function()
        settings().Rendering.QualityLevel = Enum.QualityLevel.Automatic
        game.Lighting.GlobalShadows = true
        game.Lighting.FogEnd = 100000
        setfpscap(0)
    end)

    if whiteScreen then
        whiteScreen:Destroy()
        whiteScreen = nil
    end
end


return LowTexture