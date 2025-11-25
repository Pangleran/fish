local LowTexture = {}

local gpuActive = false
local whiteScreen = nil

function LowTexture.Aktif()
    if gpuActive then return end
    gpuActive = true

    pcall(function()
        settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
        game.Lighting.GlobalShadows = false
        game.Lighting.FogEnd = 1
        setfpscap(8)
    end)
end


-- ======================
-- FUNGSI NONAKTIF
-- ======================
function LowTexture.Nonaktif()
    if not gpuActive then return end
    gpuActive = false

    pcall(function()
        settings().Rendering.QualityLevel = Enum.QualityLevel.Level02
        game.Lighting.GlobalShadows = true
        game.Lighting.FogEnd = 100000
        setfpscap(0)
    end)
end


return LowTexture