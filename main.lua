-- Pastikan Environment Mendukung
if not game:IsLoaded() then game.Loaded:Wait() end

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local LocalPlayer = Players.LocalPlayer

-- Nama File untuk Menyimpan Konfigurasi
local ConfigFileName = "HitboxExpander_Config.json"

-- Konfigurasi Default Hitbox (Maksimal Size ditingkatkan ke 200)
local HitboxSettings = {
    Enabled = true,
    ShowHitbox = false,
    Size = 50, -- Ukuran default disesuaikan proporsional
    Transparency = 0.7,
    CurrentColorIndex = 1
}

-- Fungsi untuk Menyimpan Config (Save)
local function SaveConfig()
    if writefile then
        local success, encoded = pcall(function()
            return string.format('{"Enabled":%s,"ShowHitbox":%s,"Size":%d,"Transparency":%f,"CurrentColorIndex":%d}',
                tostring(HitboxSettings.Enabled),
                tostring(HitboxSettings.ShowHitbox),
                HitboxSettings.Size,
                HitboxSettings.Transparency,
                HitboxSettings.CurrentColorIndex
            )
        end)
        if success then
            writefile(ConfigFileName, encoded)
        end
    end
end

-- Fungsi untuk Memuat Config (Load)
local function LoadConfig()
    if readfile and isfile and isfile(ConfigFileName) then
        local success, decoded = pcall(function()
            local content = readfile(ConfigFileName)
            local enabled = content:match('"Enabled":%s*(%a+)') == "true"
            local showHitbox = content:match('"ShowHitbox":%s*(%a+)') == "true"
            local size = tonumber(content:match('"Size":%s*(%d+)'))
            local transparency = tonumber(content:match('"Transparency":%s*([%d%.]+)'))
            local colorIndex = tonumber(content:match('"CurrentColorIndex":%s*(%d+)'))
            
            return {
                Enabled = enabled,
                ShowHitbox = showHitbox,
                Size = size,
                Transparency = transparency,
                CurrentColorIndex = colorIndex
            }
        end)
        if success and decoded then
            if decoded.Enabled ~= nil then HitboxSettings.Enabled = decoded.Enabled end
            if decoded.ShowHitbox ~= nil then HitboxSettings.ShowHitbox = decoded.ShowHitbox end
            if decoded.Size ~= nil then HitboxSettings.Size = decoded.Size end
            if decoded.Transparency ~= nil then HitboxSettings.Transparency = decoded.Transparency end
            if decoded.CurrentColorIndex ~= nil then HitboxSettings.CurrentColorIndex = decoded.CurrentColorIndex end
        end
    end
end

LoadConfig()

-- Daftar Pilihan Warna
local ColorList = {
    {Name = "Ungu", Color = Color3.fromRGB(147, 51, 234)},
    {Name = "Merah", Color = Color3.fromRGB(239, 68, 68)},
    {Name = "Biru", Color = Color3.fromRGB(59, 130, 246)},
    {Name = "Hijau", Color = Color3.fromRGB(34, 197, 94)},
    {Name = "Kuning", Color = Color3.fromRGB(234, 179, 8)},
    {Name = "Putih", Color = Color3.fromRGB(255, 255, 255)}
}

-- Fungsi Utama Hitbox
local function applyHitbox(character)
    if not character then return end
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    
    if humanoidRootPart then
        if HitboxSettings.Enabled then
            humanoidRootPart.Size = Vector3.new(HitboxSettings.Size, HitboxSettings.Size, HitboxSettings.Size)
            
            if HitboxSettings.ShowHitbox then
                humanoidRootPart.Transparency = HitboxSettings.Transparency
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
-- PEMBUATAN UI FLOATING (TEMA HITAM - UNGU)
-- ==========================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "HitboxExpanderUI"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 320, 0, 310)
MainFrame.Position = UDim2.new(0.5, -160, 0.5, -155)
MainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 8)

-- Header Menu
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 40)
Header.BackgroundColor3 = Color3.fromRGB(26, 26, 33)
Header.BorderSizePixel = 0
Header.Parent = MainFrame

Instance.new("UICorner", Header).CornerRadius = UDim.new(0, 8)

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -70, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "❤️ Hitbox Expander"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 15
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Header

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 26, 0, 26)
CloseBtn.Position = UDim2.new(1, -34, 0.5, -13)
CloseBtn.BackgroundColor3 = Color3.fromRGB(239, 68, 68)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 12
CloseBtn.Parent = Header
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 4)

local OpenButton = Instance.new("TextButton")
OpenButton.Size = UDim2.new(0, 45, 0, 45)
OpenButton.Position = UDim2.new(0, 20, 0, 200)
OpenButton.BackgroundColor3 = Color3.fromRGB(147, 51, 234)
OpenButton.Text = "UI"
OpenButton.TextColor3 = Color3.fromRGB(255, 255, 255)
OpenButton.Font = Enum.Font.GothamBold
OpenButton.TextSize = 14
OpenButton.Visible = false
OpenButton.Active = true
OpenButton.Draggable = true
OpenButton.Parent = ScreenGui
Instance.new("UICorner", OpenButton).CornerRadius = UDim.new(1, 0)

CloseBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    OpenButton.Visible = true
end)

OpenButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = true
    OpenButton.Visible = false
end)

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

    Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(1, 0)

    local Circle = Instance.new("Frame")
    Circle.Size = UDim2.new(0, 16, 0, 16)
    Circle.Position = defaultState and UDim2.new(1, -19, 0.5, -8) or UDim2.new(0, 3, 0.5, -8)
    Circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Circle.Parent = ToggleBtn

    Instance.new("UICorner", Circle).CornerRadius = UDim.new(1, 0)

    local active = defaultState
    ToggleBtn.MouseButton1Click:Connect(function()
        active = not active
        callback(active)
        SaveConfig()
        
        if active then
            ToggleBtn.BackgroundColor3 = Color3.fromRGB(147, 51, 234)
            Circle:TweenPosition(UDim2.new(1, -19, 0.5, -8), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.15, true)
        else
            ToggleBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
            Circle:TweenPosition(UDim2.new(0, 3, 0.5, -8), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.15, true)
        end
    end)
end

createToggle("Hitbox Expander", HitboxSettings.Enabled, function(state)
    HitboxSettings.Enabled = state
end, 55)

createToggle("Show Hitbox", HitboxSettings.ShowHitbox, function(state)
    HitboxSettings.ShowHitbox = state
end, 100)

-- Hitbox Size Controls (Maksimal 200)
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
-- Proporsi bar dibagi 200 agar akurat dengan batas maksimal baru
SizeBarFill.Size = UDim2.new(HitboxSettings.Size / 200, 0, 1, 0)
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
    if HitboxSettings.Size < 200 then
        HitboxSettings.Size = HitboxSettings.Size + 10 -- Naik 10 satuan per klik agar cepat
        SizeLabel.Text = "Hitbox Size: " .. HitboxSettings.Size
        SizeBarFill.Size = UDim2.new(HitboxSettings.Size / 200, 0, 1, 0)
        SaveConfig()
    end
end)

BtnMin.MouseButton1Click:Connect(function()
    if HitboxSettings.Size > 5 then
        HitboxSettings.Size = HitboxSettings.Size - 10
        SizeLabel.Text = "Hitbox Size: " .. HitboxSettings.Size
        SizeBarFill.Size = UDim2.new(HitboxSettings.Size / 200, 0, 1, 0)
        SaveConfig()
    end
end)

-- Tombol Ganti Warna Hitbox
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

ChangeColorBtn.MouseButton1Click:Connect(function()
    HitboxSettings.CurrentColorIndex = HitboxSettings.CurrentColorIndex + 1
    if HitboxSettings.CurrentColorIndex > #ColorList then
        HitboxSettings.CurrentColorIndex = 1
    end
    
    local activeColorData = ColorList[HitboxSettings.CurrentColorIndex]
    ColorLabel.Text = "Hitbox Color: " .. activeColorData.Name
    ChangeColorBtn.BackgroundColor3 = activeColorData.Color
    SaveConfig()
end)

print("Hitbox Script (Max Size 200) Loaded Successfully!")
