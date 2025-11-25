local LowTexture = {}

function LowTexture.Aktif()
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
    pcall(function()
        settings().Rendering.QualityLevel = Enum.QualityLevel.Level02
        game.Lighting.GlobalShadows = true
        game.Lighting.FogEnd = 100000
        setfpscap(0)
    end)
end


return LowTexture