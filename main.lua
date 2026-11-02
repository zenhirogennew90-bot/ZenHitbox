
-- ============================================================
-- FLOATING BUTTONS ENHANCED
-- Lock Position + 4 Finger Touch + Persistent Positions
-- ============================================================

local floatingButtons = {}
local floatingPositions = {}

EmoteFlingConfig.FloatingButtonsLocked =
    EmoteFlingConfig.FloatingButtonsLocked or false

local MAX_TOUCHES = 4
local activeTouches = {}

local function SaveFloatingPositions()
    for _, fab in ipairs(floatingButtons) do
        local instance = fab.Instance

        if instance and instance.Parent then
            floatingPositions[fab._key] = {
                XScale = instance.Position.X.Scale,
                XOffset = instance.Position.X.Offset,
                YScale = instance.Position.Y.Scale,
                YOffset = instance.Position.Y.Offset
            }
        end
    end
end

local function GetSavedPosition(key)
    local pos = floatingPositions[key]

    if pos then
        return UDim2.new(
            pos.XScale,
            pos.XOffset,
            pos.YScale,
            pos.YOffset
        )
    end

    return nil
end

local function destroyFloatingButtons()
    SaveFloatingPositions()

    for _, fab in ipairs(floatingButtons) do
        if fab.Instance then
            pcall(function()
                fab.Instance:Destroy()
            end)
        end
    end

    table.clear(floatingButtons)
end

local function createFloatingButtons()
    if #floatingButtons > 0 then return end

    local scale = EmoteFlingConfig.FloatingButtonScale
    local buttonSize = math.max(44, math.floor(48 * scale))
    local gap = math.floor(8 * scale)
    local padding = math.floor(80 * scale)

    local buttonInfos = {}

    for _, name in ipairs(PresetNames) do
        table.insert(buttonInfos, {
            Text = name,
            ID = PresetAnimations[name]
        })
    end

    table.insert(buttonInfos, {
        Text = "Custom animID",
        ID = nil
    })

    for index, info in ipairs(buttonInfos) do
        local callback

        if info.ID then
            callback = function()
                Notify({
                    Title = "Floating Button",
                    Content = info.Text .. " selected",
                    Duration = 2,
                    Icon = "check"
                })
            end
        else
            callback = function()
                Notify({
                    Title = "Floating Button",
                    Content = "Custom Animation selected",
                    Duration = 2,
                    Icon = "check"
                })
            end
        end

        local fab = uiWindow:CreateFloatingButton({
            Text = info.Text,
            Icon = "hand-metal",
            Size = buttonSize,
            Position = UDim2.new(1, -150, 0, 0),
            ClickCallback = callback,

            DragEnabled = not EmoteFlingConfig.FloatingButtonsLocked,
            DragThreshold = 4,
            SnapToEdges = false,
            PulseOnClick = false,
            ZIndex = 100
        })

        fab._key = info.Text

        table.insert(floatingButtons, fab)

        task.defer(function()
            local instance = fab.Instance

            if not instance or not instance.Parent then
                return
            end

            local saved = GetSavedPosition(info.Text)

            if saved then
                fab:SetPosition(saved)
            else
                local width = instance.AbsoluteSize.X
                local yOffset =
                    padding + (index - 1) * (buttonSize + gap)

                fab:SetPosition(
                    UDim2.new(1, -padding - width, 0, yOffset)
                )
            end
        end)
    end
end

-- ============================================================
-- FOUR FINGER TOUCH TRACKER
-- ============================================================

local function CountTouches()
    local count = 0

    for _ in pairs(activeTouches) do
        count += 1
    end

    return count
end

local touchStarted = UserInputService.TouchStarted:Connect(
    function(input, gameProcessed)
        if gameProcessed then return end

        if CountTouches() >= MAX_TOUCHES then
            return
        end

        activeTouches[input] = true
    end
)

local touchEnded = UserInputService.TouchEnded:Connect(
    function(input)
        activeTouches[input] = nil
    end
)

RegisterConnection("FloatingTouchStarted", touchStarted)
RegisterConnection("FloatingTouchEnded", touchEnded)

-- ============================================================
-- UI CONTROLS
-- ============================================================

flingTab:CreateSection("Floating Buttons")

flingTab:CreateToggle({
    Name = "Show Floating Buttons",
    CurrentValue = EmoteFlingConfig.FloatingButtonsEnabled,

    Callback = function(state)
        EmoteFlingConfig.FloatingButtonsEnabled = state

        if state then
            createFloatingButtons()
        else
            destroyFloatingButtons()
        end

        SaveConfig()
    end
})

flingTab:CreateToggle({
    Name = "Lock All Button Positions",
    CurrentValue = EmoteFlingConfig.FloatingButtonsLocked,

    Callback = function(state)
        SaveFloatingPositions()

        EmoteFlingConfig.FloatingButtonsLocked = state

        if EmoteFlingConfig.FloatingButtonsEnabled then
            destroyFloatingButtons()
            createFloatingButtons()
        end

        SaveConfig()

        Notify({
            Title = "Position Lock",
            Content = state
                and "All positions locked"
                or "All positions unlocked",
            Duration = 2,
            Icon = state and "lock" or "unlock"
        })
    end
})

flingTab:CreateSlider({
    Name = "Floating Button Scale",
    Range = {0.5, 3.0},
    Increment = 0.1,
    CurrentValue = EmoteFlingConfig.FloatingButtonScale,

    Callback = function(value)
        SaveFloatingPositions()

        EmoteFlingConfig.FloatingButtonScale =
            math.clamp(value, 0.5, 3.0)

        if EmoteFlingConfig.FloatingButtonsEnabled then
            destroyFloatingButtons()
            createFloatingButtons()
        end

        SaveConfig()
    end
})
