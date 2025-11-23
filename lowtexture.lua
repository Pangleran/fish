local LowTexture = {}

function LowTexture.Apply()
  for _, v in pairs(game:GetDescendants()) do
    if v:IsA("BasePart") then
      v.Material = Enum.Material.SmoothPlastic
      v.Reflectance = 0
    elseif v:IsA("Decal") or v:IsA("Texture") then
      v.Transparency = 1
    end
  end

  local Lighting = game:GetService("Lighting")
  for _, effect in pairs(Lighting:GetChildren()) do
    if effect:IsA("PostEffect") then
      effect.Enabled = false
    end
  end

  Lighting.GlobalShadows = false
  Lighting.FogEnd = 1e10
  settings().Rendering.QualityLevel = "Level01"
end

return LowTexture
