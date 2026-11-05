-- Services
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Bersihkan UI lama agar tidak duplikat
if playerGui:FindFirstChild("ZendropkickHitboxMenu") then
    playerGui.ZendropkickHitboxMenu:Destroy()
end

-- ScreenGui Utama
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ZendropkickHitboxMenu"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = playerGui

-- Tombol Toggle Mengambang (Floating Button)
local toggleBtn = Instance.new("TextButton")
toggleBtn.Name = "ToggleBtn"
toggleBtn.Size = UDim2.new(0, 50, 0, 50)
toggleBtn.Position = UDim2.new(0, 20, 0, 150)
toggleBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleBtn.Text = "⚡"
toggleBtn.TextSize = 22
toggleBtn.Font = Enum.Font.GothamBold
toggleBtn.Parent = screenGui

local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(1, 0)
btnCorner.Parent = toggleBtn

local btnStroke = Instance.new("UIStroke")
btnStroke.Color = Color3.fromRGB(140, 80, 255)
btnStroke.Thickness = 2
btnStroke.Parent = toggleBtn

-- Frame Menu Utama
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 340, 0, 460)
mainFrame.Position = UDim2.new(0.5, -170, 0.5, -230)
mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 22)
mainFrame.BorderSizePixel = 0
mainFrame.Visible = false
mainFrame.Parent = screenGui

local frameCorner = Instance.new("UICorner")
frameCorner.CornerRadius = UDim.new(0, 12)
frameCorner.Parent = mainFrame

local frameStroke = Instance.new("UIStroke")
frameStroke.Color = Color3.fromRGB(55, 45, 80)
frameStroke.Thickness = 1.5
frameStroke.Parent = mainFrame

-- Header Menu (Drag Area)
local header = Instance.new("Frame")
header.Name = "Header"
header.Size = UDim2.new(1, 0, 0, 45)
header.BackgroundColor3 = Color3.fromRGB(22, 22, 32)
header.BorderSizePixel = 0
header.Parent = mainFrame

local headerCorner = Instance.new("UICorner")
headerCorner.CornerRadius = UDim.new(0, 12)
headerCorner.Parent = header

local fixHeader = Instance.new("Frame")
fixHeader.Size = UDim2.new(1, 0, 0, 10)
fixHeader.Position = UDim2.new(0, 0, 1, -10)
fixHeader.BackgroundColor3 = Color3.fromRGB(22, 22, 32)
fixHeader.BorderSizePixel = 0
fixHeader.Parent = header

local titleText = Instance.new("TextLabel")
titleText.Size = UDim2.new(1, -20, 1, 0)
titleText.Position = UDim2.new(0, 15, 0, 0)
titleText.BackgroundTransparency = 1
titleText.TextColor3 = Color3.fromRGB(230, 220, 255)
titleText.Text = "Zendropkick | Hitbox & Color Panel"
titleText.TextSize = 13
titleText.Font = Enum.Font.GothamBold
titleText.TextXAlignment = Enum.TextXAlignment.Left
titleText.Parent = header

-- Scrolling Container
local scrollContainer = Instance.new("ScrollingFrame")
scrollContainer.Size = UDim2.new(1, -16, 1, -60)
scrollContainer.Position = UDim2.new(0, 8, 0, 52)
scrollContainer.BackgroundTransparency = 1
scrollContainer.BorderSizePixel = 0
scrollContainer.ScrollBarThickness = 3
scrollContainer.ScrollBarImageColor3 = Color3.fromRGB(140, 80, 255)
scrollContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
scrollContainer.Parent = mainFrame

local uiLayout = Instance.new("UIListLayout")
uiLayout.SortOrder = Enum.SortOrder.LayoutOrder
uiLayout.Padding = UDim.new(0, 10)
uiLayout.Parent = scrollContainer

uiLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    scrollContainer.CanvasSize = UDim2.new(0, 0, 0, uiLayout.AbsoluteContentSize.Y + 15)
end)

-- Fungsi Tombol Standar
local function createButton(name, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 40)
    btn.BackgroundColor3 = Color3.fromRGB(25, 25, 38)
    btn.TextColor3 = Color3.fromRGB(225, 225, 240)
    btn.Text = name
    btn.TextSize = 13
    btn.Font = Enum.Font.Medium
    btn.Parent = scrollContainer

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = btn

    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(50, 45, 70)
    stroke.Thickness = 1
    stroke.Parent = btn

    btn.MouseButton1Click:Connect(function()
        local tweenClick = TweenService:Create(btn, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(110, 60, 220)})
        tweenClick:Play()
        tweenClick.Completed:Wait()
        TweenService:Create(btn, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(25, 25, 38)}):Play()
        
        if callback then callback() end
    end)
end

-- Fungsi Slider Akurat & Anti-Bug
local function createSlider(name, min, max, default, callback)
    local sliderFrame = Instance.new("Frame")
    sliderFrame.Size = UDim2.new(1, 0, 0, 55)
    sliderFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 38)
    sliderFrame.Parent = scrollContainer

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = sliderFrame

    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(50, 45, 70)
    stroke.Thickness = 1
    stroke.Parent = sliderFrame

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -20, 0, 20)
    label.Position = UDim2.new(0, 10, 0, 6)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.fromRGB(220, 220, 235)
    label.Text = name
    label.TextSize = 12
    label.Font = Enum.Font.Medium
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = sliderFrame

    local valueLabel = Instance.new("TextLabel")
    valueLabel.Size = UDim2.new(0, 60, 0, 20)
    valueLabel.Position = UDim2.new(1, -70, 0, 6)
    valueLabel.BackgroundTransparency = 1
    valueLabel.TextColor3 = Color3.fromRGB(180, 140, 255)
    valueLabel.Text = tostring(default)
    valueLabel.TextSize = 12
    valueLabel.Font = Enum.Font.Bold
    valueLabel.TextXAlignment = Enum.TextXAlignment.Right
    valueLabel.Parent = sliderFrame

    local sliderBar = Instance.new("Frame")
    sliderBar.Size = UDim2.new(1, -20, 0, 6)
    sliderBar.Position = UDim2.new(0, 10, 0, 36)
    sliderBar.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
    sliderBar.BorderSizePixel = 0
    sliderBar.Parent = sliderFrame

    local barCorner = Instance.new("UICorner")
    barCorner.CornerRadius = UDim.new(1, 0)
    barCorner.Parent = sliderBar

    local fill = Instance.new("Frame")
    fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    fill.BackgroundColor3 = Color3.fromRGB(140, 80, 255)
    fill.BorderSizePixel = 0
    fill.Parent = sliderBar

    local fillCorner = Instance.new("UICorner")
    fillCorner.CornerRadius = UDim.new(1, 0)
    fillCorner.Parent = fill

    local dragging = false

    local function updateValue(input)
        local barPos = sliderBar.AbsolutePosition.X
        local barSize = sliderBar.AbsoluteSize.X
        local percentage = math.clamp((input.Position.X - barPos) / barSize, 0, 1)
        local value = math.floor((min + (max - min) * percentage) * 10) / 10 -- Support desimal halus
        
        fill.Size = UDim2.new(percentage, 0, 1, 0)
        valueLabel.Text = tostring(value)
        
        if callback then callback(value) end
    end

    sliderBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            updateValue(input)
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            updateValue(input)
        end
    end)
end

-- Variabel State Hitbox & Warna
local hitboxEnabled = false
local hitboxSize = 5
local hitboxTransparency = 0.5
local hitboxColor = Color3.fromRGB(148, 0, 211) -- Default Ungu

-- Pilihan Warna Hitbox (Ungu, Pink, Biru, Merah)
local colors = {
    ["Ungu"] = Color3.fromRGB(148, 0, 211),
    ["Pink"] = Color3.fromRGB(255, 105, 180),
    ["Biru"] = Color3.fromRGB(0, 191, 255),
    ["Merah"] = Color3.fromRGB(255, 0, 0)
}

-- UI Container untuk Pilihan Warna
local colorFrame = Instance.new("Frame")
colorFrame.Size = UDim2.new(1, 0, 0, 50)
colorFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 38)
colorFrame.Parent = scrollContainer

local colorCorner = Instance.new("UICorner")
colorCorner.CornerRadius = UDim.new(0, 8)
colorCorner.Parent = colorFrame

local colorStroke = Instance.new("UIStroke")
colorStroke.Color = Color3.fromRGB(50, 45, 70)
colorStroke.Thickness = 1
colorStroke.Parent = colorFrame

local colorLayout = Instance.new("UIListLayout")
colorLayout.FillDirection = Enum.FillDirection.Horizontal
colorLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
colorLayout.VerticalAlignment = Enum.VerticalAlignment.Center
colorLayout.Padding = UDim.new(0, 8)
colorLayout.Parent = colorFrame

for name, col in pairs(colors) do
    local cBtn = Instance.new("TextButton")
    cBtn.Size = UDim2.new(0, 65, 0, 32)
    cBtn.BackgroundColor3 = col
    cBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    cBtn.Text = name
    cBtn.TextSize = 11
    cBtn.Font = Enum.Font.Bold
    cBtn.Parent = colorFrame

    local cCorner = Instance.new("UICorner")
    cCorner.CornerRadius = UDim.new(0, 6)
    cCorner.Parent = cBtn

    cBtn.MouseButton1Click:Connect(function()
        hitboxColor = col
        print("Hitbox Color changed to: " .. name)
    end)
end

-- Implementasi Fitur Tombol Toggle Hitbox
createButton("Toggle Hitbox (ON/OFF)", function()
    hitboxEnabled = not hitboxEnabled
    print("Hitbox Status: " .. tostring(hitboxEnabled))
end)

createSlider("Hitbox Size", 2, 20, 5, function(val)
    hitboxSize = val
end)

createSlider("Hitbox Transparency", 0, 1, 0.5, function(val)
    hitboxTransparency = val
end)

-- Loop Utama untuk Aplikasi Hitbox secara Real-time
RunService.RenderStepped:Connect(function()
    if not hitboxEnabled then return end
    
    for _, otherPlayer in ipairs(Players:GetPlayers()) do
        if otherPlayer ~= player and otherPlayer.Character then
            local rootPart = otherPlayer.Character:FindFirstChild("HumanoidRootPart")
            if rootPart then
                rootPart.Size = Vector3.new(hitboxSize, hitboxSize, hitboxSize)
                rootPart.Transparency = hitboxTransparency
                rootPart.Color = hitboxColor
                rootPart.Material = Enum.Material.ForceField
                rootPart.CanCollide = false
            end
        end
    end
end)

-- Animasi Buka/Tutup Menu
local isOpen = false
local tweenInfo = TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)

local function toggleMenu()
    isOpen = not isOpen
    if isOpen then
        mainFrame.Visible = true
        mainFrame.Size = UDim2.new(0, 0, 0, 0)
        mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
        
        TweenService:Create(mainFrame, tweenInfo, {
            Size = UDim2.new(0, 340, 0, 460),
            Position = UDim2.new(0.5, -170, 0.5, -230)
        }):Play()
        
        TweenService:Create(toggleBtn, tweenInfo, {Rotation = 180}):Play()
    else
        local closeTween = TweenService:Create(mainFrame, tweenInfo, {
            Size = UDim2.new(0, 0, 0, 0),
            Position = UDim2.new(0.5, 0, 0.5, 0)
        })
        closeTween:Play()
        TweenService:Create(toggleBtn, tweenInfo, {Rotation = 0}):Play()
        closeTween.Completed:Wait()
        mainFrame.Visible = false
    end
end

toggleBtn.MouseButton1Click:Connect(toggleMenu)

-- Sistem Dragging Header Menu
local draggingFrame, dragStart, startPos

header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        draggingFrame = true
        dragStart = input.Position
        startPos = mainFrame.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if draggingFrame and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(
            startPos.X.Scale, 
            startPos.X.Offset + delta.X, 
            startPos.Y.Scale, 
            startPos.Y.Offset + delta.Y
        )
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        draggingFrame = false
    end
end)
