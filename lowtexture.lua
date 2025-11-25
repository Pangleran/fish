local LowTexture = {}

function LowTexture.Apply()
    -- LOW TEXTURE
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("BasePart") then
            v.Material = Enum.Material.SmoothPlastic
            v.Reflectance = 0

        elseif v:IsA("Decal") or v:IsA("Texture") then
            v.Transparency = 1

        elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
            v.Enabled = false

        elseif v:IsA("Lighting") or v:IsA("Highlight") then
            v.Enabled = false
        end
    end

    -- REMOVE SKY & HEAVY LIGHTING EFFECTS
    local Lighting = game:GetService("Lighting")

    for _, obj in pairs(Lighting:GetChildren()) do
        if obj:IsA("PostEffect") or obj:IsA("BloomEffect") or obj:IsA("ColorCorrectionEffect") or obj:IsA("SunRaysEffect") then
            obj.Enabled = false
        elseif obj:IsA("Sky") then
            obj:Destroy()
        end
    end

    -- LIGHTING BOOST
    Lighting.GlobalShadows = false
    Lighting.EnvironmentDiffuseScale = 0
    Lighting.EnvironmentSpecularScale = 0
    Lighting.FogEnd = 1e10

    -- MORE PERFORMANCE BOOST
    settings().Rendering.QualityLevel = Enum.QualityLevel.Level01

    -- DETECT EXECUTOR SUPPORT FOR FPS CAP
    pcall(function()
        if setfpscap then
            setfpscap(60)   -- Bisa diganti 30 kalau mau super stabil
        end
    end)

    -- NETWORK + PING SMOOTHER
    pcall(function()
        if setfflag then
            setfflag("CrashPadUploadEnabled", "False")
        end
    end)
end

return LowTexture

ok