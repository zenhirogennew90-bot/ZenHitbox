--[[
    Project: Custom Floating UI & Game Enhancer (Speed & Hitbox)
    Compatible: Delta Executor / Mobile Environment
    Design: Modern Dark Glassmorphic with Purple Accents
]]--

-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer

-- Configuration / State Variables
local Config = {
    SpeedBoostEnabled = false,
    SpeedValue = 18.9,
    HitboxEnabled = false,
    ShowHitbox = false,
    HitboxSize = 20, -- Default safe expanded size
    HitboxTransparency = 0.7
}

-- Cleanup existing UI if executed multiple times
if CoreGui:FindFirstChild("SgxCustomMenu") then
    CoreGui.SgxCustomMenu:Destroy()
end

-- ScreenGui Setup
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SgxCustomMenu"
ScreenGui.ResetOnSpawn = false
pcall(function()
    ScreenGui.Parent = CoreGui
end)
if not ScreenGui.Parent then
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
end

-- Floating Toggle Button (To open/close menu)
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Name = "ToggleBtn"
ToggleBtn.Size = UDim2.new(0, 50, 0, 50)
ToggleBtn.Position = UDim2.new(0, 30, 0, 150)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
ToggleBtn.Text = "⚡"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.TextSize = 22
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.Parent = ScreenGui

local BtnCorner = Instance.new("UICorner")
BtnCorner.CornerRadius = UDim.new(0, 12)
BtnCorner.Parent = ToggleBtn

-- Main Window Frame
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 340, 0, 420)
MainFrame.Position = UDim2.new(0.5, -170, 0.5, -210)
MainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
MainFrame.BorderSizePixel = 0
MainFrame.Visible = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 14)
MainCorner.Parent = MainFrame

-- Make Window Draggable for Mobile
local dragging, dragInput, dragStart, startPos
MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
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

UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement) then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

ToggleBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- Container for Sections (ScrollingFrame)
local Container = Instance.new("ScrollingFrame")
Container.Size = UDim2.new(1, -20, 1, -20)
Container.Position = UDim2.new(0, 10, 0, 10)
Container.BackgroundTransparency = 1
Container.CanvasSize = UDim2.new(0, 0, 0, 550)
Container.ScrollBarThickness = 4
Container.Parent = MainFrame

local UIList = Instance.new("UIListLayout")
UIList.SortOrder = Enum.SortOrder.LayoutOrder
UIList.Padding = UDim.new(0, 12)
UIList.Parent = Container

-- Helper function to create Section Cards
local function createSection(titleText)
    local section = Instance.new("Frame")
    section.Size = UDim2.new(1, 0, 0, 180)
    section.BackgroundColor3 = Color3.fromRGB(26, 26, 33)
    section.BorderSizePixel = 0
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = section
    
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -20, 0, 35)
    title.Position = UDim2.new(0, 12, 0, 5)
    title.BackgroundTransparency = 1
    title.Text = titleText
    title.TextColor3 = Color3.fromRGB(240, 240, 255)
    title.TextSize = 16
    title.Font = Enum.Font.GothamBold
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = section
    
    local innerList = Instance.new("UIListLayout")
    innerList.SortOrder = Enum.SortOrder.LayoutOrder
    innerList.Padding = UDim.new(0, 10)
    innerList.Parent = section
    
    return section
end

-- ==================== SECTION 1: BOOST ====================
local BoostSection = createSection("🚀 Boost")
BoostSection.Size = UDim2.new(1, 0, 0, 150)
BoostSection.Parent = Container

-- Speed Slider Label
local SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Size = UDim2.new(1, -24, 0, 20)
SpeedLabel.Position = UDim2.new(0, 12, 0, 40)
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Text = "Speed Boost: 18.9/200"
SpeedLabel.TextColor3 = Color3.fromRGB(180, 180, 200)
SpeedLabel.TextSize = 13
SpeedLabel.Font = Enum.Font.GothamMedium
SpeedLabel.TextXAlignment = Enum.TextXAlignment.Left
SpeedLabel.Parent = BoostSection

-- Speed Slider Track
local SpeedBar = Instance.new("Frame")
SpeedBar.Size = UDim2.new(1, -24, 0, 10)
SpeedBar.Position = UDim2.new(0, 12, 0, 65)
SpeedBar.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
SpeedBar.BorderSizePixel = 0
SpeedBar.Parent = BoostSection

local SpeedBarCorner = Instance.new("UICorner")
SpeedBarCorner.CornerRadius = UDim.new(1, 0)
SpeedBarCorner.Parent = SpeedBar

local SpeedFill = Instance.new("Frame")
SpeedFill.Size = UDim2.new(18.9/200, 0, 1, 0)
SpeedFill.BackgroundColor3 = Color3.fromRGB(139, 92, 246)
SpeedFill.BorderSizePixel = 0
SpeedFill.Parent = SpeedBar

local SpeedFillCorner = Instance.new("UICorner")
SpeedFillCorner.CornerRadius = UDim.new(1, 0)
SpeedFillCorner.Parent = SpeedFill

-- Interactive Slider Button for Speed
local SpeedBtn = Instance.new("TextButton")
SpeedBtn.Size = UDim2.new(1, 0, 1, 0)
SpeedBtn.BackgroundTransparency = 1
SpeedBtn.Text = ""
SpeedBtn.Parent = SpeedBar

SpeedBtn.MouseButton1Down:Connect(function()
    local connection
    connection = RunService.RenderStepped:Connect(function()
        if UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) or UserInputService:GetTouchPositions()[1] then
            local mouseLoc = UserInputService:GetMouseLocation()
            local absPos = SpeedBar.AbsolutePosition
            local absSize = SpeedBar.AbsoluteSize
            local pos = math.clamp((mouseLoc.X - absPos.X) / absSize.X, 0, 1)
            
            Config.SpeedValue = math.floor((pos * 200) * 10) / 10
            if Config.SpeedValue < 1 then Config.SpeedValue = 1 end
            
            SpeedFill.Size = UDim2.new(Config.SpeedValue/200, 0, 1, 0)
            SpeedLabel.Text = "Speed Boost: " .. tostring(Config.SpeedValue) .. "/200"
        else
            connection:Disconnect()
        end
    end)
end)

-- Speed Toggle
local SpeedToggleContainer = Instance.new("Frame")
SpeedToggleContainer.Size = UDim2.new(1, -24, 0, 30)
SpeedToggleContainer.Position = UDim2.new(0, 12, 0, 95)
SpeedToggleContainer.BackgroundTransparency = 1
SpeedToggleContainer.Parent = BoostSection

local SpeedToggleLabel = Instance.new("TextLabel")
SpeedToggleLabel.Size = UDim2.new(0.8, 0, 1, 0)
SpeedToggleLabel.BackgroundTransparency = 1
SpeedToggleLabel.Text = "Activate Speed Boost"
SpeedToggleLabel.TextColor3 = Color3.fromRGB(220, 220, 240)
SpeedToggleLabel.TextSize = 14
SpeedToggleLabel.Font = Enum.Font.Gotham
SpeedToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
SpeedToggleLabel.Parent = SpeedToggleContainer

local SpeedToggleBtn = Instance.new("TextButton")
SpeedToggleBtn.Size = UDim2.new(0, 46, 0, 24)
SpeedToggleBtn.Position = UDim2.new(1, -46, 0.5, -12)
SpeedToggleBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 75)
SpeedToggleBtn.Text = ""
SpeedToggleBtn.Parent = SpeedToggleContainer

local SpeedToggleCorner = Instance.new("UICorner")
SpeedToggleCorner.CornerRadius = UDim.new(1, 0)
SpeedToggleCorner.Parent = SpeedToggleBtn

local SpeedToggleCircle = Instance.new("Frame")
SpeedToggleCircle.Size = UDim2.new(0, 20, 0, 20)
SpeedToggleCircle.Position = UDim2.new(0, 2, 0.5, -10)
SpeedToggleCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
SpeedToggleCircle.Parent = SpeedToggleBtn

local CircleCorner1 = Instance.new("UICorner")
CircleCorner1.CornerRadius = UDim.new(1, 0)
CircleCorner1.Parent = SpeedToggleCircle

SpeedToggleBtn.MouseButton1Click:Connect(function()
    Config.SpeedBoostEnabled = not Config.SpeedBoostEnabled
    local targetPos = Config.SpeedBoostEnabled and UDim2.new(1, -22, 0.5, -10) or UDim2.new(0, 2, 0.5, -10)
    local targetColor = Config.SpeedBoostEnabled and Color3.fromRGB(139, 92, 246) or Color3.fromRGB(60, 60, 75)
    
    TweenService:Create(SpeedToggleCircle, TweenInfo.new(0.2), {Position = targetPos}):Play()
    TweenService:Create(SpeedToggleBtn, TweenInfo.new(0.2), {BackgroundColor3 = targetColor}):Play()
end)


-- ==================== SECTION 2: HITBOX ====================
local HitboxSection = createSection("❤️ Hitbox")
HitboxSection.Size = UDim2.new(1, 0, 0, 230)
HitboxSection.Parent = Container

-- Helper to create toggles
local function createToggle(name, defaultState, callback)
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, -24, 0, 28)
    container.BackgroundTransparency = 1
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.8, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = name
    label.TextColor3 = Color3.fromRGB(220, 220, 240)
    label.TextSize = 14
    label.Font = Enum.Font.Gotham
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = container
    
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 46, 0, 24)
    btn.Position = UDim2.new(1, -46, 0.5, -12)
    btn.BackgroundColor3 = defaultState and Color3.fromRGB(139, 92, 246) or Color3.fromRGB(60, 60, 75)
    btn.Text = ""
    btn.Parent = container
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(1, 0)
    corner.Parent = btn
    
    local circle = Instance.new("Frame")
    circle.Size = UDim2.new(0, 20, 0, 20)
    circle.Position = defaultState and UDim2.new(1, -22, 0.5, -10) or UDim2.new(0, 2, 0.5, -10)
    circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    circle.Parent = btn
    
    local cCorner = Instance.new("UICorner")
    cCorner.CornerRadius = UDim.new(1, 0)
    cCorner.Parent = circle
    
    local state = defaultState
    btn.MouseButton1Click:Connect(function()
        state = not state
        local targetPos = state and UDim2.new(1, -22, 0.5, -10) or UDim2.new(0, 2, 0.5, -10)
        local targetColor = state and Color3.fromRGB(139, 92, 246) or Color3.fromRGB(60, 60, 75)
        
        TweenService:Create(circle, TweenInfo.new(0.2), {Position = targetPos}):Play()
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = targetColor}):Play()
        
        callback(state)
    end)
    
    return container
end

-- Toggle 1: Hitbox Expander
local hbToggle = createToggle("Hitbox Expander", false, function(state)
    Config.HitboxEnabled = state
end)
hbToggle.Position = UDim2.new(0, 12, 0, 40)
hbToggle.Parent = HitboxSection

-- Toggle 2: Show Hitbox
local showToggle = createToggle("Show Hitbox", false, function(state)
    Config.ShowHitbox = state
end)
showToggle.Position = UDim2.new(0, 12, 0, 75)
showToggle.Parent = HitboxSection

-- Hitbox Size Slider
local SizeLabel = Instance.new("TextLabel")
SizeLabel.Size = UDim2.new(1, -24, 0, 20)
SizeLabel.Position = UDim2.new(0, 12, 0, 110)
SizeLabel.BackgroundTransparency = 1
SizeLabel.Text = "Hitbox Size: 20/100"
SizeLabel.TextColor3 = Color3.fromRGB(180, 180, 200)
SizeLabel.TextSize = 13
SizeLabel.Font = Enum.Font.GothamMedium
SizeLabel.TextXAlignment = Enum.TextXAlignment.Left
SizeLabel.Parent = HitboxSection

local SizeBar = Instance.new("Frame")
SizeBar.Size = UDim2.new(1, -24, 0, 10)
SizeBar.Position = UDim2.new(0, 12, 0, 135)
SizeBar.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
SizeBar.BorderSizePixel = 0
SizeBar.Parent = HitboxSection

local SizeBarCorner = Instance.new("UICorner")
SizeBarCorner.CornerRadius = UDim.new(1, 0)
SizeBarCorner.Parent = SizeBar

local SizeFill = Instance.new("Frame")
SizeFill.Size = UDim2.new(20/100, 0, 1, 0)
SizeFill.BackgroundColor3 = Color3.fromRGB(139, 92, 246)
SizeFill.BorderSizePixel = 0
SizeFill.Parent = SizeBar

local SizeFillCorner = Instance.new("UICorner")
SizeFillCorner.CornerRadius = UDim.new(1, 0)
SizeFillCorner.Parent = SizeFill

local SizeBtn = Instance.new("TextButton")
SizeBtn.Size = UDim2.new(1, 0, 1, 0)
SizeBtn.BackgroundTransparency = 1
SizeBtn.Text = ""
SizeBtn.Parent = SizeBar

SizeBtn.MouseButton1Down:Connect(function()
    local connection
    connection = RunService.RenderStepped:Connect(function()
        if UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) or UserInputService:GetTouchPositions()[1] then
            local mouseLoc = UserInputService:GetMouseLocation()
            local absPos = SizeBar.AbsolutePosition
            local absSize = SizeBar.AbsoluteSize
            local pos = math.clamp((mouseLoc.X - absPos.X) / absSize.X, 0, 1)
            
            Config.HitboxSize = math.floor(pos * 100)
            if Config.HitboxSize < 1 then Config.HitboxSize = 1 end
            
            SizeFill.Size = UDim2.new(Config.HitboxSize/100, 0, 1, 0)
            SizeLabel.Text = "Hitbox Size: " .. tostring(Config.HitboxSize) .. "/100"
        else
            connection:Disconnect()
        end
    end)
end)

-- Hitbox Transparency Slider
local TransLabel = Instance.new("TextLabel")
TransLabel.Size = UDim2.new(1, -24, 0, 20)
TransLabel.Position = UDim2.new(0, 12, 0, 155)
TransLabel.BackgroundTransparency = 1
TransLabel.Text = "Hitbox Transparency: 0.7/1"
TransLabel.TextColor3 = Color3.fromRGB(180, 180, 200)
TransLabel.TextSize = 13
TransLabel.Font = Enum.Font.GothamMedium
TransLabel.TextXAlignment = Enum.TextXAlignment.Left
TransLabel.Parent = HitboxSection

local TransBar = Instance.new("Frame")
TransBar.Size = UDim2.new(1, -24, 0, 10)
TransBar.Position = UDim2.new(0, 12, 0, 180)
TransBar.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
TransBar.BorderSizePixel = 0
TransBar.Parent = HitboxSection

local TransBarCorner = Instance.new("UICorner")
TransBarCorner.CornerRadius = UDim.new(1, 0)
TransBarCorner.Parent = TransBar

local TransFill = Instance.new("Frame")
TransFill.Size = UDim2.new(0.7, 0, 1, 0)
TransFill.BackgroundColor3 = Color3.fromRGB(139, 92, 246)
TransFill.BorderSizePixel = 0
TransFill.Parent = TransBar

local TransFillCorner = Instance.new("UICorner")
TransFillCorner.CornerRadius = UDim.new(1, 0)
TransFillCorner.Parent = TransFill

local TransBtn = Instance.new("TextButton")
TransBtn.Size = UDim2.new(1, 0, 1, 0)
TransBtn.BackgroundTransparency = 1
TransBtn.Text = ""
TransBtn.Parent = TransBar

TransBtn.MouseButton1Down:Connect(function()
    local connection
    connection = RunService.RenderStepped:Connect(function()
        if UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) or UserInputService:GetTouchPositions()[1] then
            local mouseLoc = UserInputService:GetMouseLocation()
            local absPos = TransBar.AbsolutePosition
            local absSize = TransBar.AbsoluteSize
            local pos = math.clamp((mouseLoc.X - absPos.X) / absSize.X, 0, 1)
            
            Config.HitboxTransparency = math.floor((pos * 1) * 10) / 10
            
            TransFill.Size = UDim2.new(Config.HitboxTransparency, 0, 1, 0)
            TransLabel.Text = "Hitbox Transparency: " .. tostring(Config.HitboxTransparency) .. "/1"
        else
            connection:Disconnect()
        end
    end)
end)


-- ==================== CORE EXECUTION LOOPS ====================
RunService.RenderStepped:Connect(function()
    -- Speed Boost Logic
    if Config.SpeedBoostEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = Config.SpeedValue
    end
    
    -- Hitbox Expander Logic
    if Config.HitboxEnabled then
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                local hrp = player.Character.HumanoidRootPart
                hrp.Size = Vector3.new(Config.HitboxSize, Config.HitboxSize, Config.HitboxSize)
                hrp.CanCollide = false
                if Config.ShowHitbox then
                    hrp.Transparency = Config.HitboxTransparency
                    hrp.Color = Color3.fromRGB(139, 92, 246)
                else
                    hrp.Transparency = 1
                end
            end
        end
    end
end)

print("✅ UI Successfully Loaded & Ready!")
