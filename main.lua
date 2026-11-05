-- [[ PREMIUM HITBOX EXPANDER - NYXAR VANE ARCHITECTURE ]]
-- [[ Compatible with Delta Executor & Mobile Touch ]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer

-- Konfigurasi State
local HBConfig = {
    Enabled = false,
    Size = 10,
    Transparency = 0.5,
    Color = Color3.fromRGB(138, 43, 226), -- Default Ungu
    ColorName = "Ungu",
    VisualVisible = true
}

-- Hapus UI lama jika ada
if CoreGui:FindFirstChild("PremiumHitboxUI") then
    CoreGui.PremiumHitboxUI:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PremiumHitboxUI"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 320, 0, 410)
MainFrame.Position = UDim2.new(0.5, -160, 0.5, -205)
MainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 16)
UICorner.Parent = MainFrame

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(60, 60, 80)
UIStroke.Thickness = 1.5
UIStroke.Parent = MainFrame

-- Header
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 50)
Header.BackgroundTransparency = 1
Header.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -20, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.Text = "⚡ Hitbox Master"
Title.TextColor3 = Color3.fromRGB(240, 240, 255)
Title.TextSize = 18
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Header

-- Container
local Container = Instance.new("ScrollingFrame")
Container.Size = UDim2.new(1, -20, 1, -65)
Container.Position = UDim2.new(0, 10, 0, 55)
Container.BackgroundTransparency = 1
Container.BorderSizePixel = 0
Container.CanvasSize = UDim2.new(0, 0, 0, 480)
Container.ScrollBarThickness = 4
Container.Parent = MainFrame

-- Fungsi Helper untuk Membuat Bagian Kontrol
local function createSectionTitle(text, posY)
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, 0, 0, 25)
    lbl.Position = UDim2.new(0, 0, 0, posY)
    lbl.BackgroundTransparency = 1
    lbl.Font = Enum.Font.GothamSemibold
    lbl.Text = text
    lbl.TextColor3 = Color3.fromRGB(160, 160, 185)
    lbl.TextSize = 13
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = Container
    return lbl
end

-- 1. Toggle Utama Hitbox
createSectionTitle("STATUS HITBOX", 5)
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(1, 0, 0, 44)
ToggleBtn.Position = UDim2.new(0, 0, 0, 32)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 48)
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.Text = "OFF"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
ToggleBtn.TextSize = 15
ToggleBtn.Parent = Container

Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(0, 10)

ToggleBtn.MouseButton1Click:Connect(function()
    HBConfig.Enabled = not HBConfig.Enabled
    if HBConfig.Enabled then
        ToggleBtn.Text = "ACTIVE"
        ToggleBtn.TextColor3 = Color3.fromRGB(80, 255, 120)
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(25, 55, 35)
    else
        ToggleBtn.Text = "OFF"
        ToggleBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 48)
    end
end)

-- 2. Toggle Tampilan Visual (Hitbox Tetap Aktif)
createSectionTitle("VISUAL HITBOX", 85)
local VisualToggleBtn = Instance.new("TextButton")
VisualToggleBtn.Size = UDim2.new(1, 0, 0, 40)
VisualToggleBtn.Position = UDim2.new(0, 0, 0, 112)
VisualToggleBtn.BackgroundColor3 = Color3.fromRGB(25, 35, 55)
VisualToggleBtn.Font = Enum.Font.GothamSemibold
VisualToggleBtn.Text = "Tampilkan Visual: ON"
VisualToggleBtn.TextColor3 = Color3.fromRGB(100, 180, 255)
VisualToggleBtn.TextSize = 14
VisualToggleBtn.Parent = Container

Instance.new("UICorner", VisualToggleBtn).CornerRadius = UDim.new(0, 10)

VisualToggleBtn.MouseButton1Click:Connect(function()
    HBConfig.VisualVisible = not HBConfig.VisualVisible
    if HBConfig.VisualVisible then
        VisualToggleBtn.Text = "Tampilkan Visual: ON"
        VisualToggleBtn.TextColor3 = Color3.fromRGB(100, 180, 255)
    else
        VisualToggleBtn.Text = "Tampilkan Visual: OFF (Tersembunyi)"
        VisualToggleBtn.TextColor3 = Color3.fromRGB(180, 180, 180)
    end
end)

-- 3. Pilihan Warna Hitbox (Ungu, Biru, Merah)
createSectionTitle("WARNA HITBOX", 165)
local colorContainer = Instance.new("Frame")
colorContainer.Size = UDim2.new(1, 0, 0, 42)
colorContainer.Position = UDim2.new(0, 0, 0, 192)
colorContainer.BackgroundTransparency = 1
colorContainer.Parent = Container

local colors = {
    {Name = "Ungu", Color = Color3.fromRGB(138, 43, 226)},
    {Name = "Biru", Color = Color3.fromRGB(0, 150, 255)},
    {Name = "Merah", Color = Color3.fromRGB(255, 50, 50)}
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
    btn.TextSize = 13
    btn.Parent = colorContainer
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
    
    btn.MouseButton1Click:Connect(function()
        HBConfig.Color = col.Color
        HBConfig.ColorName = col.Name
        for _, b in pairs(colorButtons) do
            b.BorderSizePixel = 0
        end
        btn.BorderSizePixel = 2
    end)
    table.insert(colorButtons, btn)
end

-- 4. Slider Ukuran Hitbox
createSectionTitle("UKURAN HITBOX (Studs: 10)", 245)
local sizeValLabel = Container:GetChildren()[#Container:GetChildren()] -- Label referensi

local sizeSliderBg = Instance.new("Frame")
sizeSliderBg.Size = UDim2.new(1, 0, 0, 24)
sizeSliderBg.Position = UDim2.new(0, 0, 0, 272)
sizeSliderBg.BackgroundColor3 = Color3.fromRGB(35, 35, 48)
sizeSliderBg.Parent = Container
Instance.new("UICorner", sizeSliderBg).CornerRadius = UDim.new(0, 6)

local sizeSliderFill = Instance.new("Frame")
sizeSliderFill.Size = UDim2.new(0.36, 0, 1, 0) -- Default (10 dari max 25)
sizeSliderFill.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
sizeSliderFill.Parent = sizeSliderBg
Instance.new("UICorner", sizeSliderFill).CornerRadius = UDim.new(0, 6)

-- Logika Slider Ukuran (Touch/Mouse Support)
local draggingSize = false
sizeSliderBg.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        draggingSize = true
    end
end)

game:GetService("UserInputService").InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        draggingSize = false
        draggingTrans = false
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if draggingSize and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local pos = math.clamp((input.Position.X - sizeSliderBg.AbsolutePosition.X) / sizeSliderBg.AbsoluteSize.X, 0, 1)
        sizeSliderFill.Size = UDim2.new(pos, 0, 1, 0)
        HBConfig.Size = math.floor(2 + (pos * 23)) -- Skala 2 sampai 25
        sizeValLabel.Text = "UKURAN HITBOX (Studs: " .. HBConfig.Size .. ")"
    end
    if draggingTrans and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local pos = math.clamp((input.Position.X - transSliderBg.AbsolutePosition.X) / transSliderBg.AbsoluteSize.X, 0, 1)
        transSliderFill.Size = UDim2.new(pos, 0, 1, 0)
        HBConfig.Transparency = math.floor(pos * 10) / 10 -- Skala 0.0 sampai 1.0
        transValLabel.Text = "TRANSPARANSI VISUAL (" .. HBConfig.Transparency .. ")"
    end
end)

-- 5. Slider Transparansi
createSectionTitle("TRANSPARANSI VISUAL (0.5)", 315)
local transValLabel = Container:GetChildren()[#Container:GetChildren()]

local transSliderBg = Instance.new("Frame")
transSliderBg.Size = UDim2.new(1, 0, 0, 24)
transSliderBg.Position = UDim2.new(0, 0, 0, 342)
transSliderBg.BackgroundColor3 = Color3.fromRGB(35, 35, 48)
transSliderBg.Parent = Container
Instance.new("UICorner", transSliderBg).CornerRadius = UDim.new(0, 6)

local transSliderFill = Instance.new("Frame")
transSliderFill.Size = UDim2.new(0.5, 0, 1, 0)
transSliderFill.BackgroundColor3 = Color3.fromRGB(100, 180, 255)
transSliderFill.Parent = transSliderBg
Instance.new("UICorner", transSliderFill).CornerRadius = UDim.new(0, 6)

local draggingTrans = false
transSliderBg.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        draggingTrans = true
    end
end)

-- Engine Hitbox Utama (Loop Aman & Optimal)
RunService.RenderStepped:Connect(function()
    pcall(function()
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                local hrp = player.Character.HumanoidRootPart
                local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
                
                if humanoid and humanoid.Health > 0 then
                    if HBConfig.Enabled then
                        hrp.Size = Vector3.new(HBConfig.Size, HBConfig.Size, HBConfig.Size)
                        hrp.CanCollide = false
                        
                        if HBConfig.VisualVisible then
                            hrp.Transparency = HBConfig.Transparency
                            hrp.Color = HBConfig.Color
                            hrp.Material = Enum.Material.Neon
                        else
                            hrp.Transparency = 1 -- Sembunyikan visual tapi hitbox tetap ada
                        end
                    else
                        -- Reset ke ukuran normal Roblox
                        hrp.Size = Vector3.new(2, 2, 1)
                        hrp.Transparency = 1
                    end
                end
            end
        end
    end)
end)

print("⚡ Premium Hitbox Master Loaded Successfully!")
