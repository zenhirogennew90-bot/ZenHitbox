-- Pastikan Environment Mendukung
if not game:IsLoaded() then game.Loaded:Wait() end

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local LocalPlayer = Players.LocalPlayer

-- Konfigurasi Pengaturan Hitbox & Warna
local HitboxSettings = {
    Enabled = true,          -- Hitbox Expander (Toggle On)
    ShowHitbox = false,      -- Show Hitbox (Toggle Off)
    Size = 25,               -- Hitbox Size
    Transparency = 0.7,      -- Hitbox Transparency
    CurrentColorIndex = 1    -- Indeks warna aktif
}

-- Daftar Pilihan Warna (Ungu, Merah, Biru, Hijau, Kuning, Putih)
local ColorList = {
    {Name = "Ungu", Color = Color3.fromRGB(147, 51, 234)},
    {Name = "Merah", Color = Color3.fromRGB(239, 68, 68)},
    {Name = "Biru", Color = Color3.fromRGB(59, 130, 246)},
    {Name = "Hijau", Color = Color3.fromRGB(34, 197, 94)},
    {Name = "Kuning", Color = Color3.fromRGB(234, 179, 8)},
    {Name = "Putih", Color = Color3.fromRGB(255, 255, 255)}
}

-- Fungsi Utama untuk Memperbesar Hitbox Karakter Lain
local function applyHitbox(character)
    if not character then return end
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    
    if humanoidRootPart then
        if HitboxSettings.Enabled then
            humanoidRootPart.Size = Vector3.new(HitboxSettings.Size, HitboxSettings.Size, HitboxSettings.Size)
            
            if HitboxSettings.ShowHitbox then
                humanoidRootPart.Transparency = HitboxSettings.Transparency
                -- Menggunakan warna yang dipilih dari daftar
                humanoidRootPart.Color = ColorList[HitboxSettings.CurrentColorIndex].Color
                humanoidRootPart.Material = Enum.Material.Neon
            else
                humanoidRootPart.Transparency = 1
            end
            
            humanoidRootPart.CanCollide = false
        else
            humanoidRootPart.Size = Vector3.new(2, 2, 1)
            humanoidRootPart.Transparency = 1
        end
    end
end

-- Loop untuk Memantau Pemain Lain
RunService.RenderStepped:Connect(function()
    if not HitboxSettings.Enabled then return end
    
    pcall(function()
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                applyHitbox(player.Character)
            end
        end
    end)
end)

-- ==========================================
-- PEMBUATAN UI TEMA HITAM - UNGU (MODERN)
-- ==========================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "HitboxExpanderUI"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false

-- Diperbesar sedikit tingginya (320px) untuk menampung tombol ganti warna
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 320, 0, 310)
MainFrame.Position = UDim2.new(0.5, -160, 0.5, -155)
MainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 22) -- Hitam Elegan
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = MainFrame

-- Header Menu
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 40)
Header.BackgroundColor3 = Color3.fromRGB(26, 26, 33)
Header.BorderSizePixel = 0
Header.Parent = MainFrame

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 8)
HeaderCorner.Parent = Header

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -20, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "❤️ Hitbox Expander"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 15
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Header

-- Fungsi Pembuat Tombol Toggle
local function createToggle(name, defaultState, callback, yPos)
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0, 200, 0, 30)
    Label.Position = UDim2.new(0, 20, 0, yPos)
    Label.BackgroundTransparency = 1
    Label.Text = name
    Label.TextColor3 = Color3.fromRGB(210, 210, 210)
    Label.TextSize = 13
    Label.Font = Enum.Font.Gotham
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = MainFrame

    local ToggleBtn = Instance.new("TextButton")
    ToggleBtn.Size = UDim2.new(0, 44, 0, 22)
    ToggleBtn.Position = UDim2.new(1, -64, 0, yPos + 4)
    ToggleBtn.BackgroundColor3 = defaultState and Color3.fromRGB(147, 51, 234) or Color3.fromRGB(50, 50, 60)
    ToggleBtn.Text = ""
    ToggleBtn.AutoButtonColor = false
    ToggleBtn.Parent = MainFrame

    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(1, 0)
    BtnCorner.Parent = ToggleBtn

    local Circle = Instance.new("Frame")
    Circle.Size = UDim2.new(0, 16, 0, 16)
    Circle.Position = defaultState and UDim2.new(1, -19, 0.5, -8) or UDim2.new(0, 3, 0.5, -8)
    Circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Circle.Parent = ToggleBtn

    local CircleCorner = Instance.new("UICorner")
    CircleCorner.CornerRadius = UDim.new(1, 0)
    CircleCorner.Parent = Circle

    local active = defaultState
    ToggleBtn.MouseButton1Click:Connect(function()
        active = not active
        callback(active)
        
        if active then
            ToggleBtn.BackgroundColor3 = Color3.fromRGB(147, 51, 234)
            Circle:TweenPosition(UDim2.new(1, -19, 0.5, -8), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.15, true)
        else
            ToggleBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
            Circle:TweenPosition(UDim2.new(0, 3, 0.5, -8), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.15, true)
        end
    end)
end

-- Render Toggle 1 & 2
createToggle("Hitbox Expander", HitboxSettings.Enabled, function(state)
    HitboxSettings.Enabled = state
end, 55)

createToggle("Show Hitbox", HitboxSettings.ShowHitbox, function(state)
    HitboxSettings.ShowHitbox = state
end, 100)

-- Hitbox Size Controls
local SizeLabel = Instance.new("TextLabel")
SizeLabel.Size = UDim2.new(0, 200, 0, 20)
SizeLabel.Position = UDim2.new(0, 20, 0, 140)
SizeLabel.BackgroundTransparency = 1
SizeLabel.Text = "Hitbox Size: " .. HitboxSettings.Size
SizeLabel.TextColor3 = Color3.fromRGB(210, 210, 210)
SizeLabel.TextSize = 13
SizeLabel.Font = Enum.Font.Gotham
SizeLabel.TextXAlignment = Enum.TextXAlignment.Left
SizeLabel.Parent = MainFrame

local SizeBarBg = Instance.new("Frame")
SizeBarBg.Size = UDim2.new(1, -40, 0, 8)
SizeBarBg.Position = UDim2.new(0, 20, 0, 165)
SizeBarBg.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
SizeBarBg.BorderSizePixel = 0
SizeBarBg.Parent = MainFrame
Instance.new("UICorner", SizeBarBg).CornerRadius = UDim.new(1, 0)

local SizeBarFill = Instance.new("Frame")
SizeBarFill.Size = UDim2.new(HitboxSettings.Size / 100, 0, 1, 0)
SizeBarFill.BackgroundColor3 = Color3.fromRGB(147, 51, 234)
SizeBarFill.BorderSizePixel = 0
SizeBarFill.Parent = SizeBarBg
Instance.new("UICorner", SizeBarFill).CornerRadius = UDim.new(1, 0)

local BtnPlus = Instance.new("TextButton")
BtnPlus.Size = UDim2.new(0, 25, 0, 22)
BtnPlus.Position = UDim2.new(1, -45, 0, 138)
BtnPlus.BackgroundColor3 = Color3.fromRGB(147, 51, 234)
BtnPlus.Text = "+"
BtnPlus.TextColor3 = Color3.fromRGB(255, 255, 255)
BtnPlus.Font = Enum.Font.GothamBold
BtnPlus.Parent = MainFrame
Instance.new("UICorner", BtnPlus).CornerRadius = UDim.new(0, 4)

local BtnMin = Instance.new("TextButton")
BtnMin.Size = UDim2.new(0, 25, 0, 22)
BtnMin.Position = UDim2.new(1, -75, 0, 138)
BtnMin.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
BtnMin.Text = "-"
BtnMin.TextColor3 = Color3.fromRGB(255, 255, 255)
BtnMin.Font = Enum.Font.GothamBold
BtnMin.Parent = MainFrame
Instance.new("UICorner", BtnMin).CornerRadius = UDim.new(0, 4)

BtnPlus.MouseButton1Click:Connect(function()
    if HitboxSettings.Size < 100 then
        HitboxSettings.Size = HitboxSettings.Size + 5
        SizeLabel.Text = "Hitbox Size: " .. HitboxSettings.Size
        SizeBarFill.Size = UDim2.new(HitboxSettings.Size / 100, 0, 1, 0)
    end
end)

BtnMin.MouseButton1Click:Connect(function()
    if HitboxSettings.Size > 5 then
        HitboxSettings.Size = HitboxSettings.Size - 5
        SizeLabel.Text = "Hitbox Size: " .. HitboxSettings.Size
        SizeBarFill.Size = UDim2.new(HitboxSettings.Size / 100, 0, 1, 0)
    end
end)

-- ==========================================
-- FITUR BARU: TOMBOL GANTI WARNA HITBOX
-- ==========================================
local ColorLabel = Instance.new("TextLabel")
ColorLabel.Size = UDim2.new(0, 200, 0, 20)
ColorLabel.Position = UDim2.new(0, 20, 0, 195)
ColorLabel.BackgroundTransparency = 1
ColorLabel.Text = "Hitbox Color: " .. ColorList[HitboxSettings.CurrentColorIndex].Name
ColorLabel.TextColor3 = Color3.fromRGB(210, 210, 210)
ColorLabel.TextSize = 13
ColorLabel.Font = Enum.Font.Gotham
ColorLabel.TextXAlignment = Enum.TextXAlignment.Left
ColorLabel.Parent = MainFrame

local ChangeColorBtn = Instance.new("TextButton")
ChangeColorBtn.Size = UDim2.new(1, -40, 0, 32)
ChangeColorBtn.Position = UDim2.new(0, 20, 0, 225)
ChangeColorBtn.BackgroundColor3 = ColorList[HitboxSettings.CurrentColorIndex].Color
ChangeColorBtn.Text = "Ganti Warna (Klik)"
ChangeColorBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ChangeColorBtn.Font = Enum.Font.GothamBold
ChangeColorBtn.TextSize = 13
ChangeColorBtn.Parent = MainFrame
Instance.new("UICorner", ChangeColorBtn).CornerRadius = UDim.new(0, 6)

-- Event untuk siklus ganti warna saat tombol ditekan
ChangeColorBtn.MouseButton1Click:Connect(function()
    HitboxSettings.CurrentColorIndex = HitboxSettings.CurrentColorIndex + 1
    if HitboxSettings.CurrentColorIndex > #ColorList then
        HitboxSettings.CurrentColorIndex = 1 -- Kembali ke warna awal jika sudah di ujung list
    end
    
    local activeColorData = ColorList[HitboxSettings.CurrentColorIndex]
    ColorLabel.Text = "Hitbox Color: " .. activeColorData.Name
    ChangeColorBtn.BackgroundColor3 = activeColorData.Color
end)

print("Hitbox Script with Color Changer Loaded Successfully!")
