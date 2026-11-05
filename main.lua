-- =================================================================
-- [[ ELITE PREMIUM HITBOX MASTER V3 - NYXAR VANE ARCHITECTURE ]]
-- [[ Optimized for Mobile Delta Executor - Compact, Square & Responsive ]]
-- =================================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer

-- Konfigurasi State Hitbox
local HBConfig = {
    Enabled = false,
    Size = 10,
    Transparency = 0.5,
    Color = Color3.fromRGB(138, 43, 226), -- Default Ungu Premium
    ColorName = "Ungu",
    VisualVisible = true
}

-- Hapus UI lama jika ada agar tidak duplikat
if CoreGui:FindFirstChild("NyxarCompactHitboxUI") then
    CoreGui.NyxarCompactHitboxUI:Destroy()
end

-- Main ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "NyxarCompactHitboxUI"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- =================================================================
-- 1. FLOATING TRIGGER BUTTON (Tombol Mengambang)
-- =================================================================
local FloatingBtn = Instance.new("TextButton")
FloatingBtn.Name = "FloatingTrigger"
FloatingBtn.Size = UDim2.new(0, 50, 0, 50)
FloatingBtn.Position = UDim2.new(0, 20, 0.35, 0)
FloatingBtn.BackgroundColor3 = Color3.fromRGB(15, 15, 22)
FloatingBtn.Font = Enum.Font.GothamBold
FloatingBtn.Text = "⚡"
FloatingBtn.TextColor3 = Color3.fromRGB(240, 240, 255)
FloatingBtn.TextSize = 22
FloatingBtn.Active = true
FloatingBtn.Draggable = true
FloatingBtn.Parent = ScreenGui

Instance.new("UICorner", FloatingBtn).CornerRadius = UDim.new(1, 0)

local FloatStroke = Instance.new("UIStroke")
FloatStroke.Color = Color3.fromRGB(138, 43, 226)
FloatStroke.Thickness = 2.2
FloatStroke.Parent = FloatingBtn

-- =================================================================
-- 2. MAIN MENU PANEL (Persegi, Compact, Dilengkapi Scrolling)
-- =================================================================
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainPanel"
MainFrame.Size = UDim2.new(0, 300, 0, 360) -- Ukuran lebih kecil & persegi
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -180)
MainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 26)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Visible = false
MainFrame.Parent = ScreenGui

Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 14)

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(60, 60, 80)
MainStroke.Thickness = 1.5
MainStroke.Parent = MainFrame

-- Header Menu
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 45)
Header.BackgroundTransparency = 1
Header.Parent = MainFrame

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, -40, 1, 0)
TitleLabel.Position = UDim2.new(0, 14, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.Text = "⚡ Hitbox Master"
TitleLabel.TextColor3 = Color3.fromRGB(245, 245, 255)
TitleLabel.TextSize = 16
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = Header

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -38, 0.5, -15)
CloseBtn.BackgroundColor3 = Color3.fromRGB(28, 28, 40)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(200, 200, 220)
CloseBtn.TextSize = 13
CloseBtn.Parent = Header
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 6)

-- Scrolling Container (Agar rapi dan tidak overflow)
local Container = Instance.new("ScrollingFrame")
Container.Size = UDim2.new(1, -16, 1, -55)
Container.Position = UDim2.new(0, 8, 0, 50)
Container.BackgroundTransparency = 1
Container.BorderSizePixel = 0
Container.CanvasSize = UDim2.new(0, 0, 0, 440) -- Tinggi konten di dalam scroll
Container.ScrollBarThickness = 3
Container.ScrollBarImageColor3 = Color3.fromRGB(138, 43, 226)
Container.Parent = MainFrame

-- Logika Buka/Tutup Menu
local menuIsOpen = false
FloatingBtn.MouseButton1Click:Connect(function()
    menuIsOpen = not menuIsOpen
    MainFrame.Visible = menuIsOpen
    FloatStroke.Color = menuIsOpen and Color3.fromRGB(80, 255, 120) or Color3.fromRGB(138, 43, 226)
end)

CloseBtn.MouseButton1Click:Connect(function()
    menuIsOpen = false
    MainFrame.Visible = false
    FloatStroke.Color = Color3.fromRGB(138, 43, 226)
end)

-- Helper Fungsi Judul Bagian
local function createSectionHeader(text, posY)
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, 0, 0, 20)
    lbl.Position = UDim2.new(0, 0, 0, posY)
    lbl.BackgroundTransparency = 1
    lbl.Font = Enum.Font.GothamSemibold
    lbl.Text = text
    lbl.TextColor3 = Color3.fromRGB(160, 160, 185)
    lbl.TextSize = 11
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = Container
    return lbl
end

-- =================================================================
-- 3. KOMPONEN UI DI DALAM CONTAINER
-- =================================================================

-- A. Status Hitbox Toggle
createSectionHeader("STATUS EKSEKUSI", 5)
local MasterToggle = Instance.new("TextButton")
MasterToggle.Size = UDim2.new(1, 0, 0, 38)
MasterToggle.Position = UDim2.new(0, 0, 0, 26)
MasterToggle.BackgroundColor3 = Color3.fromRGB(26, 26, 36)
MasterToggle.Font = Enum.Font.GothamBold
MasterToggle.Text = "OFF"
MasterToggle.TextColor3 = Color3.fromRGB(255, 80, 80)
MasterToggle.TextSize, MasterToggle.Parent = 13, Container
Instance.new("UICorner", MasterToggle).CornerRadius = UDim.new(0, 8)

MasterToggle.MouseButton1Click:Connect(function()
    HBConfig.Enabled = not HBConfig.Enabled
    if HBConfig.Enabled then
        MasterToggle.Text = "ACTIVE [ON]"
        MasterToggle.TextColor3 = Color3.fromRGB(80, 255, 120)
        MasterToggle.BackgroundColor3 = Color3.fromRGB(20, 45, 30)
    else
        MasterToggle.Text = "OFF"
        MasterToggle.TextColor3 = Color3.fromRGB(255, 80, 80)
        MasterToggle.BackgroundColor3 = Color3.fromRGB(26, 26, 36)
    end
end)

-- B. Visual Tampilkan/Sembunyikan Hitbox
createSectionHeader("TAMPILAN VISUAL", 72)
local VisualToggle = Instance.new("TextButton")
VisualToggle.Size = UDim2.new(1, 0, 0, 36)
VisualToggle.Position = UDim2.new(0, 0, 0, 93)
VisualToggle.BackgroundColor3 = Color3.fromRGB(22, 30, 45)
VisualToggle.Font = Enum.Font.GothamSemibold
VisualToggle.Text = "Visual: ON (Terlihat)"
VisualToggle.TextColor3 = Color3.fromRGB(100, 180, 255)
VisualToggle.TextSize, VisualToggle.Parent = 12, Container
Instance.new("UICorner", VisualToggle).CornerRadius = UDim.new(0, 8)

VisualToggle.MouseButton1Click:Connect(function()
    HBConfig.VisualVisible = not HBConfig.VisualVisible
    if HBConfig.VisualVisible then
        VisualToggle.Text = "Visual: ON (Terlihat)"
        VisualToggle.TextColor3 = Color3.fromRGB(100, 180, 255)
    else
        VisualToggle.Text = "Visual: OFF (Hidden / Fungsi Aktif)"
        VisualToggle.TextColor3 = Color3.fromRGB(170, 170, 170)
    end
end)

-- C. Pilihan Warna Hitbox (Ungu, Biru, Merah)
createSectionHeader("WARNA HITBOX", 137)
local ColorContainer = Instance.new("Frame")
ColorContainer.Size = UDim2.new(1, 0, 0, 36)
ColorContainer.Position = UDim2.new(0, 0, 0, 158)
ColorContainer.BackgroundTransparency = 1
ColorContainer.Parent = Container

local colors = {
    {Name = "Ungu", Color = Color3.fromRGB(138, 43, 226)},
    {Name = "Biru", Color = Color3.fromRGB(0, 140, 255)},
    {Name = "Merah", Color = Color3.fromRGB(255, 45, 45)}
}
local colorButtons = {}

for i, col in ipairs(colors) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.31, 0, 1, 0)
    btn.Position = UDim2.new((i-1)*0.345, 0, 0, 0)
    btn.BackgroundColor3 = col.Color
    btn.Font = Enum.Font.GothamBold
    btn.Text = col.Name
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 12
    btn.Parent = ColorContainer
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 7)
    
    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(255, 255, 255)
    stroke.Thickness = (col.Name == "Ungu") and 2 or 0
    stroke.Parent = btn
    
    btn.MouseButton1Click:Connect(function()
        HBConfig.Color = col.Color
        HBConfig.ColorName = col.Name
        for _, b in pairs(colorButtons) do
            b.UIStroke.Thickness = 0
        end
        stroke.Thickness = 2
    end)
    btn.UIStroke = stroke
    table.insert(colorButtons, btn)
end

-- D. Slider Ukuran Hitbox
local SizeHeader = createSectionHeader("UKURAN HITBOX [Studs: 10]", 202)
local SizeBg = Instance.new("Frame")
SizeBg.Size = UDim2.new(1, 0, 0, 22)
SizeBg.Position = UDim2.new(0, 0, 0, 223)
SizeBg.BackgroundColor3 = Color3.fromRGB(26, 26, 36)
SizeBg.Parent = Container
Instance.new("UICorner", SizeBg).CornerRadius = UDim.new(0, 6)

local SizeFill = Instance.new("Frame")
SizeFill.Size = UDim2.new(0.3, 0, 1, 0)
SizeFill.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
SizeFill.Parent = SizeBg
Instance.new("UICorner", SizeFill).CornerRadius = UDim.new(0, 6)

-- E. Slider Transparansi Hitbox (Diperbaiki & Dioptimalkan agar bekerja akurat)
local TransHeader = createSectionHeader("TRANSPARANSI VISUAL [0.5]", 255)
local TransBg = Instance.new("Frame")
TransBg.Size = UDim2.new(1, 0, 0, 22)
TransBg.Position = UDim2.new(0, 0, 0, 276)
TransBg.BackgroundColor3 = Color3.fromRGB(26, 26, 36)
TransBg.Parent = Container
Instance.new("UICorner", TransBg).CornerRadius = UDim.new(0, 6)

local TransFill = Instance.new("Frame")
TransFill.Size = UDim2.new(0.5, 0, 1, 0)
TransFill.BackgroundColor3 = Color3.fromRGB(100, 180, 255)
TransFill.Parent = TransBg
Instance.new("UICorner", TransFill).CornerRadius = UDim.new(0, 6)

-- =================================================================
-- 4. ROBUST TOUCH SLIDER LOGIC (Fix Slider Transparansi & Ukuran)
-- =================================================================
local activeSizeInput = nil
local activeTransInput = nil

SizeBg.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        activeSizeInput = input
    end
end)

TransBg.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        activeTransInput = input
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input == activeSizeInput then activeSizeInput = nil end
    if input == activeTransInput then activeTransInput = nil end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == activeSizeInput then
        local relativeX = math.clamp((input.Position.X - SizeBg.AbsolutePosition.X) / SizeBg.AbsoluteSize.X, 0, 1)
        SizeFill.Size = UDim2.new(relativeX, 0, 1, 0)
        HBConfig.Size = math.floor(2 + (relativeX * 28))
        SizeHeader.Text = "UKURAN HITBOX [Studs: " .. HBConfig.Size .. "]"
    elseif input == activeTransInput then
        local relativeX = math.clamp((input.Position.X - TransBg.AbsolutePosition.X) / TransBg.AbsoluteSize.X, 0, 1)
        TransFill.Size = UDim2.new(relativeX, 0, 1, 0)
        HBConfig.Transparency = math.floor(relativeX * 10) / 10
        TransHeader.Text = "TRANSPARANSI VISUAL [" .. HBConfig.Transparency .. "]"
    end
end)

-- =================================================================
-- 5. CORE ENGINE LOOP (Eksekusi Hitbox & Transparansi Akurat)
-- =================================================================
RunService.RenderStepped:Connect(function()
    pcall(function()
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                local char = player.Character
                local hrp = char:FindFirstChild("HumanoidRootPart")
                local hum = char:FindFirstChildOfClass("Humanoid")
                
                if hrp and hum and hum.Health > 0 then
                    if HBConfig.Enabled then
                        hrp.Size = Vector3.new(HBConfig.Size, HBConfig.Size, HBConfig.Size)
                        hrp.CanCollide = false
                        
                        if HBConfig.VisualVisible then
                            hrp.Transparency = HBConfig.Transparency
                            hrp.Color = HBConfig.Color
                            hrp.Material = Enum.Material.Neon
                        else
                            hrp.Transparency = 1 -- Hitbox jalan, visual tersembunyi total
                        end
                    else
                        hrp.Size = Vector3.new(2, 2, 1)
                        hrp.Transparency = 1
                    end
                end
            end
        end
    end)
end)

print("⚡ Elite Compact Hitbox Master V3 Loaded Successfully!")
