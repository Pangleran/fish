local LowTexture = {}

function LowTexture.Apply()
    -- ============================
    -- REMOVE ALL TEXTURES & DETAILS
    -- ============================
    for _, v in ipairs(game:GetDescendants()) do
        if v:IsA("BasePart") then
            v.Material = Enum.Material.SmoothPlastic
            v.Reflectance = 0
            v.CastShadow = false

        elseif v:IsA("Decal") or v:IsA("Texture") then
            v.Transparency = 1

        elseif v:IsA("ParticleEmitter")
            or v:IsA("Trail")
            or v:IsA("Beam")
            or v:IsA("Highlight")
            or v:IsA("Smoke")
            or v:IsA("Sparkles")
            or v:IsA("Fire") then
            v.Enabled = false
        end
    end

    -- ============================
    -- KILL ALL HEAVY LIGHTING EFFECTS
    -- ============================
    local Lighting = game:GetService("Lighting")

    for _, obj in ipairs(Lighting:GetChildren()) do
        if obj:IsA("PostEffect")
        or obj:IsA("BloomEffect")
        or obj:IsA("ColorCorrectionEffect")
        or obj:IsA("SunRaysEffect")
        or obj:IsA("DepthOfFieldEffect")
        or obj:IsA("Atmosphere")
        or obj:IsA("Sky") then
            obj:Destroy()
        end
    end

    Lighting.GlobalShadows = false
    Lighting.Brightness = 1
    Lighting.EnvironmentDiffuseScale = 0
    Lighting.EnvironmentSpecularScale = 0
    Lighting.FogEnd = 1e10
    Lighting.ClockTime = 12

    -- ============================
    -- RENDERING LOWEST
    -- ============================
    settings().Rendering.QualityLevel = Enum.QualityLevel.Level01

    -- ============================
    -- PHYSICS & NETWORK OPTIMIZATION
    -- ============================
    pcall(function()
        -- Membatasi physics client supaya ringan
        game:GetService("PhysicsSettings").PhysicsEnvironmentalThrottle = Enum.EnviromentalPhysicsThrottle.Always

        -- Mengurangi update replicator network
        sethiddenproperty(game:GetService("NetworkClient"), "ClientMinOutgoingBandwidth", 0)
        sethiddenproperty(game:GetService("NetworkClient"), "ClientMaxOutgoingBandwidth", 0)
    end)

    -- ============================
    -- OPTIONAL FPS LIMITER
    -- ============================
    pcall(function()
        if setfpscap then setfpscap(45) end -- FPS stabil paling tinggi
    end)
end

return LowTexture