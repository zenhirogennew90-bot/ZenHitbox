-- =================================================================
-- [[ ULTIMATE PREMIUM HITBOX MASTER - NYXAR VANE ARCHITECTURE ]]
-- [[ Mode: Full Production-Ready, Zero-Placeholder, Mobile Optimized ]]
-- =================================================================

-- 1. Secure Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer

-- 2. Configuration State Object
local HBConfig = {
    Enabled = false,
    Size = 10,
    Transparency = 0.5,
    Color = Color3.fromRGB(138, 43, 226), -- Default Ungu Premium
    ColorName = "Ungu",
    VisualVisible = true
}

-- 3. Cleanup Existing UI to Prevent Duplication
if CoreGui:FindFirstChild("NyxarPremiumHitboxUI") then
    CoreGui.NyxarPremiumHitboxUI:Destroy()
end

-- 4. Main ScreenGui Initialization
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "NyxarPremiumHitboxUI"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- =================================================================
-- 5. FLOATING TOGGLE BUTTON (Draggable & Responsive Mobile UI)
-- =================================================================
local FloatingBtn = Instance.new("TextButton")
FloatingBtn.Name = "FloatingTrigger"
FloatingBtn.Size = UDim2.new(0, 54, 0, 54)
FloatingBtn.Position = UDim2.new(0, 25, 0.4, 0)
FloatingBtn.BackgroundColor3 = Color3.fromRGB(15, 15, 22)
FloatingBtn.Font = Enum.Font.GothamBold
FloatingBtn.Text = "⚡"
FloatingBtn.TextColor3 = Color3.fromRGB(240, 240, 255)
FloatingBtn.TextSize = 24
FloatingBtn.Active = true
FloatingBtn.Draggable = true
FloatingBtn.Parent = ScreenGui

local FloatCorner = Instance.new("UICorner")
FloatCorner.CornerRadius = UDim.new(1, 0) -- Perfect Circle
FloatCorner.Parent = FloatingBtn

local FloatStroke = Instance.new("UIStroke")
FloatStroke.Name = "FloatBorder"
FloatStroke.Color = Color3.fromRGB(138, 43, 226)
FloatStroke.Thickness = 2.5
FloatStroke.Parent = FloatingBtn

-- =================================================================
-- 6. MAIN PANEL ARCHITECTURE (Glassmorphism & Sleek Design)
-- =================================================================
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainPanel"
MainFrame.Size = UDim2.new(0, 340, 0, 440)
MainFrame.Position = UDim2.new(0.5, -170, 0.5, -220)
MainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 26)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Visible = false
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 16)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(55, 55, 75)
MainStroke.Thickness = 1.8
MainStroke.Parent = MainFrame

-- Header Section
local Header = Instance.new("Frame")
Header.Name = "Header"
Header.Size = UDim2.new(1, 0, 0, 55)
Header.BackgroundTransparency = 1
Header.Parent = MainFrame

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Name = "Title"
TitleLabel.Size = UDim2.new(1, -20, 1, 0)
TitleLabel.Position = UDim2.new(0, 18, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.Text = "⚡ Hitbox Master Elite"
TitleLabel.TextColor3 = Color3.fromRGB(245, 245, 255)
TitleLabel.TextSize = 18
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = Header

-- Close / Minimize Button inside Header
local CloseBtn = Instance.new("TextButton")
CloseBtn.Name = "CloseButton"
CloseBtn.Size = UDim2.new(0, 35, 0, 35)
CloseBtn.Position = UDim2.new(1, -45, 0.5, -17)
CloseBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 42)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(200, 200, 220)
CloseBtn.TextSize = 14
CloseBtn.Parent = Header

Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 8)

-- Scrolling Container for Options
local Container = Instance.new("ScrollingFrame")
Container.Name = "ControlContainer"
Container.Size = UDim2.new(1, -24, 1, -70)
Container.Position = UDim2.new(0, 12, 0, 60)
Container.BackgroundTransparency = 1
Container.BorderSizePixel = 0
Container.CanvasSize = UDim2.new(0, 0, 0, 500)
Container.ScrollBarThickness = 3
Container.ScrollBarImageColor3 = Color3.fromRGB(138, 43, 226)
Container.Parent = MainFrame

-- Interaction Logic: Open/Close Menu via Floating Button
local menuIsOpen = false
FloatingBtn.MouseButton1Click:Connect(function()
    menuIsOpen = not menuIsOpen
    MainFrame.Visible = menuIsOpen
    
    -- Smooth feedback animation / color shift on trigger
    if menuIsOpen then
        FloatStroke.Color = Color3.fromRGB(80, 255, 120)
    else
        FloatStroke.Color = Color3.fromRGB(138, 43, 226)
    end
end)

CloseBtn.MouseButton1Click:Connect(function()
    menuIsOpen = false
    MainFrame.Visible = false
    FloatStroke.Color = Color3.fromRGB(138, 43, 226)
end)

-- Helper Function to Create Section Headings
local function createSectionHeader(labelText, positionY)
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, 0, 0, 24)
    lbl.Position = UDim2.new(0, 0, 0, positionY)
    lbl.BackgroundTransparency = 1
    lbl.Font = Enum.Font.GothamSemibold
    lbl.Text = labelText
    lbl.TextColor3 = Color3.fromRGB(165, 165, 190)
    lbl.TextSize = 12
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = Container
    return lbl
end

-- =================================================================
-- 7. COMPONENT 1: MASTER HITBOX TOGGLE
-- =================================================================
createSectionHeader("STATUS EKSEKUSI HITBOX", 5)

local MasterToggle = Instance.new("TextButton")
MasterToggle.Name = "MasterToggleBtn"
MasterToggle.Size = UDim2.new(1, 0, 0, 46)
MasterToggle.Position = UDim2.new(0, 0, 0, 32)
MasterToggle.BackgroundColor3 = Color3.fromRGB(28, 28, 38)
MasterToggle.Font = Enum.Font.GothamBold
MasterToggle.Text = "STATUS: NONAKTIF [OFF]"
MasterToggle.TextColor3 = Color3.fromRGB(255, 90, 90)
MasterToggle.TextSize = 14
MasterToggle.Parent = Container

Instance.new("UICorner", MasterToggle).CornerRadius = UDim.new(0, 10)
local MasterStroke = Instance.new("UIStroke")
MasterStroke.Color = Color3.fromRGB(50, 50, 68)
MasterStroke.Thickness = 1.2
MasterStroke.Parent = MasterToggle

MasterToggle.MouseButton1Click:Connect(function()
    HBConfig.Enabled = not HBConfig.Enabled
    if HBConfig.Enabled then
        MasterToggle.Text = "STATUS: AKTIF [ON]"
        MasterToggle.TextColor3 = Color3.fromRGB(80, 255, 120)
        MasterToggle.BackgroundColor3 = Color3.fromRGB(20, 48, 30)
        MasterStroke.Color = Color3.fromRGB(80, 255, 120)
    else
        MasterToggle.Text = "STATUS: NONAKTIF [OFF]"
        MasterToggle.TextColor3 = Color3.fromRGB(255, 90, 90)
        MasterToggle.BackgroundColor3 = Color3.fromRGB(28, 28, 38)
        MasterStroke.Color = Color3.fromRGB(50, 50, 68)
    end
end)

-- =================================================================
-- 8. COMPONENT 2: VISUAL DISPLAY TOGGLE (Hitbox Active, Visual Hidden)
-- =================================================================
createSectionHeader("TAMPILAN VISUAL HITBOX", 88)

local VisualToggle = Instance.new("TextButton")
VisualToggle.Name = "VisualToggleBtn"
VisualToggle.Size = UDim2.new(1, 0, 0, 42)
VisualToggle.Position = UDim2.new(0, 0, 0, 115)
VisualToggle.BackgroundColor3 = Color3.fromRGB(24, 32, 48)
VisualToggle.Font = Enum.Font.GothamSemibold
VisualToggle.Text = "Render Visual: ON (Terlihat)"
VisualToggle.TextColor3 = Color3.fromRGB(100, 180, 255)
VisualToggle.TextSize = 13
VisualToggle.Parent = Container

Instance.new("UICorner", VisualToggle).CornerRadius = UDim.new(0, 10)
local VisualStroke = Instance.new("UIStroke")
VisualStroke.Color = Color3.fromRGB(50, 90, 150)
VisualStroke.Thickness = 1.2
VisualStroke.Parent = VisualToggle

VisualToggle.MouseButton1Click:Connect(function()
    HBConfig.VisualVisible = not HBConfig.VisualVisible
    if HBConfig.VisualVisible then
        VisualToggle.Text = "Render Visual: ON (Terlihat)"
        VisualToggle.TextColor3 = Color3.fromRGB(100, 180, 255)
        VisualStroke.Color = Color3.fromRGB(50, 90, 150)
    else
        VisualToggle.Text = "Render Visual: OFF (Tersembunyi/Fungsi Jalan)"
        VisualToggle.TextColor3 = Color3.fromRGB(170, 170, 170)
        VisualStroke.Color = Color3.fromRGB(80, 80, 80)
    end
end)

-- =================================================================
-- 9. COMPONENT 3: COLOR SELECTOR BUTTONS (Ungu, Biru, Merah)
-- =================================================================
createSectionHeader("PILIHAN WARNA HITBOX", 170)

local ColorContainer = Instance.new("Frame")
ColorContainer.Name = "ColorButtonsContainer"
ColorContainer.Size = UDim2.new(1, 0, 0, 44)
ColorContainer.Position = UDim2.new(0, 0, 0, 197)
ColorContainer.BackgroundTransparency = 1
ColorContainer.Parent = Container

local ColorDefinitions = {
    {Name = "Ungu", Color = Color3.fromRGB(138, 43, 226)},
    {Name = "Biru", Color = Color3.fromRGB(0, 140, 255)},
    {Name = "Merah", Color = Color3.fromRGB(255, 45, 45)}
}

local ColorButtonObjects = {}

for index, colorData in ipairs(ColorDefinitions) do
    local ColBtn = Instance.new("TextButton")
    ColBtn.Name = colorData.Name .. "Button"
    ColBtn.Size = UDim2.new(0.315, 0, 1, 0)
    ColBtn.Position = UDim2.new((index - 1) * 0.342, 0, 0, 0)
    ColBtn.BackgroundColor3 = colorData.Color
    ColBtn.Font = Enum.Font.GothamBold
    ColBtn.Text = colorData.Name
    ColBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    ColBtn.TextSize = 13
    ColBtn.Parent = ColorContainer
    
    Instance.new("UICorner", ColBtn).CornerRadius = UDim.new(0, 8)
    local ColStroke = Instance.new("UIStroke")
    ColStroke.Color = Color3.fromRGB(255, 255, 255)
    ColStroke.Thickness = (colorData.Name == "Ungu") and 2 or 0 -- Default highlight Ungu
    ColStroke.Parent = ColBtn
    
    ColBtn.MouseButton1Click:Connect(function()
        HBConfig.Color = colorData.Color
        HBConfig.ColorName = colorData.Name
        
        -- Update UI border highlights for active color
        for _, otherBtn in pairs(ColorButtonObjects) do
            otherBtn.UIStroke.Thickness = 0
        end
        ColStroke.Thickness = 2
    end)
    
    ColBtn.UIStroke = ColStroke
    table.insert(ColorButtonObjects, ColBtn)
end

-- =================================================================
-- 10. COMPONENT 4: SLIDER UKURAN HITBOX (Size Adjuster)
-- =================================================================
local SizeHeaderLabel = createSectionHeader("UKURAN HITBOX [Studs: 10]", 255)

local SizeSliderBg = Instance.new("Frame")
SizeSliderBg.Name = "SizeSliderBackground"
SizeSliderBg.Size = UDim2.new(1, 0, 0, 26)
SizeSliderBg.Position = UDim2.new(0, 0, 0, 282)
SizeSliderBg.BackgroundColor3 = Color3.fromRGB(28, 28, 38)
SizeSliderBg.Parent = Container

Instance.new("UICorner", SizeSliderBg).CornerRadius = UDim.new(0, 8)

local SizeSliderFill = Instance.new("Frame")
SizeSliderFill.Name = "SizeSliderFillBar"
SizeSliderFill.Size = UDim2.new(0.32, 0, 1, 0) -- Default scale mapping to ~10 studs
SizeSliderFill.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
SizeSliderFill.Parent = SizeSliderBg

Instance.new("UICorner", SizeSliderFill).CornerRadius = UDim.new(0, 8)

-- =================================================================
-- 11. COMPONENT 5: SLIDER TRANSPARANSI VISUAL (Transparency Adjuster)
-- =================================================================
local TransHeaderLabel = createSectionHeader("TRANSPARANSI VISUAL [0.5]", 325)

local TransSliderBg = Instance.new("Frame")
TransSliderBg.Name = "TransSliderBackground"
TransSliderBg.Size = UDim2.new(1, 0, 0, 26)
TransSliderBg.Position = UDim2.new(0, 0, 0, 352)
TransSliderBg.BackgroundColor3 = Color3.fromRGB(28, 28, 38)
TransSliderBg.Parent = Container

Instance.new("UICorner", TransSliderBg).CornerRadius = UDim.new(0, 8)

local TransSliderFill = Instance.new("Frame")
TransSliderFill.Name = "TransSliderFillBar"
TransSliderFill.Size = UDim2.new(0.5, 0, 1, 0) -- Default 0.5
TransSliderFill.BackgroundColor3 = Color3.fromRGB(100, 180, 255)
TransSliderFill.Parent = TransSliderBg

Instance.new("UICorner", TransSliderFill).CornerRadius = UDim.new(0, 8)

-- =================================================================
-- 12. ADVANCED TOUCH & MOUSE SLIDER CONTROLLER LOGIC
-- =================================================================
local isDraggingSizeSlider = false
local isDraggingTransSlider = false

SizeSliderBg.InputBegan:Connect(function(inputObject)
    if inputObject.UserInputType == Enum.UserInputType.MouseButton1 or inputObject.UserInputType == Enum.UserInputType.Touch then
        isDraggingSizeSlider = true
    end
end)

TransSliderBg.InputBegan:Connect(function(inputObject)
    if inputObject.UserInputType == Enum.UserInputType.MouseButton1 or inputObject.UserInputType == Enum.UserInputType.Touch then
        isDraggingTransSlider = true
    end
end)

UserInputService.InputEnded:Connect(function(inputObject)
    if inputObject.UserInputType == Enum.UserInputType.MouseButton1 or inputObject.UserInputType == Enum.UserInputType.Touch then
        isDraggingSizeSlider = false
        isDraggingTransSlider = false
    end
end)

UserInputService.InputChanged:Connect(function(inputObject)
    if inputObject.UserInputType == Enum.UserInputType.MouseMovement or inputObject.UserInputType == Enum.UserInputType.Touch then
        
        -- Handle Size Slider Calculation (Range: 2 to 30 studs)
        if isDraggingSizeSlider then
            local relativeX = math.clamp((inputObject.Position.X - SizeSliderBg.AbsolutePosition.X) / SizeSliderBg.AbsoluteSize.X, 0, 1)
            SizeSliderFill.Size = UDim2.new(relativeX, 0, 1, 0)
            HBConfig.Size = math.floor(2 + (relativeX * 28))
            SizeHeaderLabel.Text = "UKURAN HITBOX [Studs: " .. HBConfig.Size .. "]"
        end
        
        -- Handle Transparency Slider Calculation (Range: 0.0 to 1.0)
        if isDraggingTransSlider then
            local relativeX = math.clamp((inputObject.Position.X - TransSliderBg.AbsolutePosition.X) / TransSliderBg.AbsoluteSize.X, 0, 1)
            TransSliderFill.Size = UDim2.new(relativeX, 0, 1, 0)
            HBConfig.Transparency = math.floor(relativeX * 10) / 10
            TransHeaderLabel.Text = "TRANSPARANSI VISUAL [" .. HBConfig.Transparency .. "]"
        end
        
    end
end)

-- =================================================================
-- 13. CORE ENGINE LOOP: HITBOX MODIFICATION & ACCURACY ENGINES
-- =================================================================
RunService.RenderStepped:Connect(function()
    pcall(function()
        for _, targetPlayer in ipairs(Players:GetPlayers()) do
            if targetPlayer ~= LocalPlayer and targetPlayer.Character then
                local characterModel = targetPlayer.Character
                local rootPart = characterModel:FindFirstChild("HumanoidRootPart")
                local humanoidComp = characterModel:FindFirstChildOfClass("Humanoid")
                
                if rootPart and humanoidComp and humanoidComp.Health > 0 then
                    if HBConfig.Enabled then
                        -- Apply Expanded Size & Non-Collision for Maximum Hit Registration
                        rootPart.Size = Vector3.new(HBConfig.Size, HBConfig.Size, HBConfig.Size)
                        rootPart.CanCollide = false
                        
                        -- Handle Visual Customization vs Hidden Mode
                        if HBConfig.VisualVisible then
                            rootPart.Transparency = HBConfig.Transparency
                            rootPart.Color = HBConfig.Color
                            rootPart.Material = Enum.Material.Neon
                        else
                            -- Hitbox fully works behind the scenes, but completely invisible to eyes
                            rootPart.Transparency = 1
                        end
                    else
                        -- Revert back to Roblox default proportions cleanly when toggled off
                        rootPart.Size = Vector3.new(2, 2, 1)
                        rootPart.Transparency = 1
                    end
                end
            end
        end
    end)
end)

print("⚡ Nyxar Vane Elite Hitbox Master Successfully Initialized & Active!")
