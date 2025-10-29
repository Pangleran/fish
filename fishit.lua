local TweenService = cloneref(game:GetService("TweenService"))
local CoreGui = cloneref(game:GetService("CoreGui"))

if CoreGui:FindFirstChild("OldScriptLoaderUI") then
    CoreGui:FindFirstChild("OldScriptLoaderUI"):Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "OldScriptLoaderUI"
ScreenGui.Parent = CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.Size = UDim2.new(0, 500, 0, 370)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.BorderSizePixel = 0

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(255, 85, 85)
MainStroke.Thickness = 2
MainStroke.Parent = MainFrame

local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Parent = MainFrame
TitleBar.Size = UDim2.new(1, 0, 0, 45)
TitleBar.BackgroundColor3 = Color3.fromRGB(255, 85, 85)
TitleBar.BorderSizePixel = 0

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 12)
TitleCorner.Parent = TitleBar

local TitleFix = Instance.new("Frame")
TitleFix.Parent = TitleBar
TitleFix.Position = UDim2.new(0, 0, 0.5, 0)
TitleFix.Size = UDim2.new(1, 0, 0.5, 0)
TitleFix.BackgroundColor3 = Color3.fromRGB(255, 85, 85)
TitleFix.BorderSizePixel = 0

local TitleText = Instance.new("TextLabel")
TitleText.Name = "TitleText"
TitleText.Parent = TitleBar
TitleText.Size = UDim2.new(1, -50, 1, 0)
TitleText.Position = UDim2.new(0, 15, 0, 0)
TitleText.BackgroundTransparency = 1
TitleText.Text = "⚠️ Old Script Version Detected"
TitleText.Font = Enum.Font.GothamBold
TitleText.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleText.TextSize = 18
TitleText.TextXAlignment = Enum.TextXAlignment.Left

local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Parent = TitleBar
CloseButton.AnchorPoint = Vector2.new(1, 0.5)
CloseButton.Position = UDim2.new(1, -12, 0.5, 0)
CloseButton.Size = UDim2.new(0, 32, 0, 32)
CloseButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
CloseButton.Text = "X"
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 16
CloseButton.BorderSizePixel = 0

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 8)
CloseCorner.Parent = CloseButton

local Separator = Instance.new("Frame")
Separator.Name = "Separator"
Separator.Parent = MainFrame
Separator.Position = UDim2.new(0, 0, 0, 45)
Separator.Size = UDim2.new(1, 0, 0, 2)
Separator.BackgroundColor3 = Color3.fromRGB(255, 85, 85)
Separator.BorderSizePixel = 0

local Content = Instance.new("Frame")
Content.Name = "Content"
Content.Parent = MainFrame
Content.Position = UDim2.new(0, 25, 0, 65)
Content.Size = UDim2.new(1, -50, 1, -85)
Content.BackgroundTransparency = 1

local MainWarningText = Instance.new("TextLabel")
MainWarningText.Name = "MainWarningText"
MainWarningText.Parent = Content
MainWarningText.Size = UDim2.new(1, 0, 0, 30)
MainWarningText.Position = UDim2.new(0, 0, 0, 0)
MainWarningText.BackgroundTransparency = 1
MainWarningText.Text = "🚨 IMPORTANT: You are using an outdated script version!"
MainWarningText.Font = Enum.Font.GothamBold
MainWarningText.TextColor3 = Color3.fromRGB(255, 85, 85)
MainWarningText.TextSize = 15
MainWarningText.TextWrapped = true
MainWarningText.TextYAlignment = Enum.TextYAlignment.Top

local WarningText = Instance.new("TextLabel")
WarningText.Name = "WarningText"
WarningText.Parent = Content
WarningText.Size = UDim2.new(1, 0, 0, 85)
WarningText.Position = UDim2.new(0, 0, 0, 40)
WarningText.BackgroundTransparency = 1
WarningText.Text = "To ensure the best performance, security, and access to the latest features, please update to the new script loader immediately.\n\nYou can copy the new loader from the button below or get it from our Discord server."
WarningText.Font = Enum.Font.Gotham
WarningText.TextColor3 = Color3.fromRGB(230, 230, 230)
WarningText.TextSize = 13
WarningText.TextWrapped = true
WarningText.TextYAlignment = Enum.TextYAlignment.Top

local DiscordContainer = Instance.new("Frame")
DiscordContainer.Name = "DiscordContainer"
DiscordContainer.Parent = Content
DiscordContainer.Position = UDim2.new(0, 0, 0, 135)
DiscordContainer.Size = UDim2.new(1, 0, 0, 55)
DiscordContainer.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
DiscordContainer.BorderSizePixel = 0

local DiscordContainerCorner = Instance.new("UICorner")
DiscordContainerCorner.CornerRadius = UDim.new(0, 8)
DiscordContainerCorner.Parent = DiscordContainer

local DiscordText = Instance.new("TextLabel")
DiscordText.Name = "DiscordText"
DiscordText.Parent = DiscordContainer
DiscordText.Size = UDim2.new(1, -20, 1, 0)
DiscordText.Position = UDim2.new(0, 10, 0, 0)
DiscordText.BackgroundTransparency = 1
DiscordText.Text = "💬 Alternative: Get the new script from our Discord\nServer: discord.gg/zenithhub | Channel: #Script"
DiscordText.Font = Enum.Font.Gotham
DiscordText.TextColor3 = Color3.fromRGB(200, 200, 200)
DiscordText.TextSize = 12
DiscordText.TextWrapped = true
DiscordText.TextYAlignment = Enum.TextYAlignment.Center
DiscordText.TextXAlignment = Enum.TextXAlignment.Left

local CopyButton = Instance.new("TextButton")
CopyButton.Name = "CopyButton"
CopyButton.Parent = Content
CopyButton.Position = UDim2.new(0.5, 0, 0, 205)
CopyButton.AnchorPoint = Vector2.new(0.5, 0)
CopyButton.Size = UDim2.new(0, 230, 0, 38)
CopyButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
CopyButton.Text = "📋 Copy New Loader Script"
CopyButton.Font = Enum.Font.GothamBold
CopyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CopyButton.TextSize = 15
CopyButton.BorderSizePixel = 0

local CopyCorner = Instance.new("UICorner")
CopyCorner.CornerRadius = UDim.new(0, 8)
CopyCorner.Parent = CopyButton

local DiscordButton = Instance.new("TextButton")
DiscordButton.Name = "DiscordButton"
DiscordButton.Parent = Content
DiscordButton.Position = UDim2.new(0.5, 0, 0, 250)
DiscordButton.AnchorPoint = Vector2.new(0.5, 0)
DiscordButton.Size = UDim2.new(0, 230, 0, 38)
DiscordButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
DiscordButton.Text = "🔗 Copy Discord Link"
DiscordButton.Font = Enum.Font.GothamBold
DiscordButton.TextColor3 = Color3.fromRGB(255, 255, 255)
DiscordButton.TextSize = 15
DiscordButton.BorderSizePixel = 0

local DiscordCorner = Instance.new("UICorner")
DiscordCorner.CornerRadius = UDim.new(0, 8)
DiscordCorner.Parent = DiscordButton

local newLoaderScript = [[loadstring(game:HttpGet("https://zenithhub.cloud/panel/script"))()]]
local discordLink = "discord.gg/zenithhub"

local copyButtonCooldown = false
local discordButtonCooldown = false

CopyButton.MouseButton1Click:Connect(function()
    if copyButtonCooldown then return end
    copyButtonCooldown = true
    
    setclipboard(newLoaderScript)
    local originalText = CopyButton.Text
    local originalColor = CopyButton.BackgroundColor3
    CopyButton.Text = "✅ Script Copied to Clipboard!"
    CopyButton.BackgroundColor3 = Color3.fromRGB(85, 255, 85)
    wait(2)
    CopyButton.Text = originalText
    CopyButton.BackgroundColor3 = originalColor
    
    copyButtonCooldown = false
end)

DiscordButton.MouseButton1Click:Connect(function()
    if discordButtonCooldown then return end
    discordButtonCooldown = true
    
    setclipboard(discordLink)
    local originalText = DiscordButton.Text
    local originalColor = DiscordButton.BackgroundColor3
    DiscordButton.Text = "✅ Discord Link Copied!"
    DiscordButton.BackgroundColor3 = Color3.fromRGB(85, 255, 85)
    wait(2)
    DiscordButton.Text = originalText
    DiscordButton.BackgroundColor3 = originalColor
    
    discordButtonCooldown = false
end)

CloseButton.MouseButton1Click:Connect(function()
    local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local tween = TweenService:Create(MainFrame, tweenInfo, {Size = UDim2.new(0, 0, 0, 0)})
    tween:Play()
    tween.Completed:Connect(function()
        ScreenGui:Destroy()
    end)
end)

local function addHoverEffect(button)
    button.MouseEnter:Connect(function()
        local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local tween = TweenService:Create(button, tweenInfo, {BackgroundColor3 = Color3.fromRGB(50, 50, 50)})
        tween:Play()
    end)
    button.MouseLeave:Connect(function()
        local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local tween = TweenService:Create(button, tweenInfo, {BackgroundColor3 = Color3.fromRGB(30, 30, 30)})
        tween:Play()
    end)
end

addHoverEffect(CloseButton)
addHoverEffect(CopyButton)
addHoverEffect(DiscordButton)

MainFrame.Size = UDim2.new(0, 0, 0, 0)
local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
local tween = TweenService:Create(MainFrame, tweenInfo, {Size = UDim2.new(0, 500, 0, 370)})
tween:Play()

local dragging
local dragInput
local dragStart
local startPos

local function update(input)
    local delta = input.Position - dragStart
    MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

TitleBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)
