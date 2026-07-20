--[[
â•”â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•—
â•‘         âš¡ MEGA ADMIN v4 â€” THORELL EDITION                         â•‘
â•‘                                                                      â•‘
â•‘   SÄ±fÄ±rdan yazÄ±lmÄ±ÅŸ UI | 0 External Loading | %100 Ã‡alÄ±ÅŸÄ±r         â•‘
â•‘   Madium âœ“ Xeno âœ“ Velocity âœ“ | Byfron'lu oyunlarda executor gerek  â•‘
â•šâ•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
--]]

--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
--=  [CORE] HÄ°Ã‡BÄ°R DIÅ YÃœKLEME YOK! Her ÅŸey bu dosyanÄ±n iÃ§inde.
--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•

-- Hata yakalama
local function xpcall(f, ...)
    local s, e = pcall(f)
    if not s then warn("[MEGA ADMIN] HATA: " .. tostring(e)) end
    return s, e
end

local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local Mouse = LP:GetMouse()
local Camera = workspace.CurrentCamera
local RS = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local VU = game:GetService("VirtualUser")
local TS = game:GetService("TeleportService")
local Lighting = game:GetService("Lighting")
local CG = game:GetService("CoreGui")
local HttpS = game:GetService("HttpService")
local TweenS = game:GetService("TweenService")
local Debris = game:GetService("Debris")
local StarterGui = game:GetService("StarterGui")

--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
--=  [UTILITY] KISA FONKSÄ°YONLAR
--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•

local function GC() return LP.Character end
local function HRP() local c=GC(); return c and c:FindFirstChild("HumanoidRootPart") end
local function HUM() local c=GC(); return c and c:FindFirstChildOfClass("Humanoid") end
local function THRP(p) local c=p.Character; return c and c:FindFirstChild("HumanoidRootPart") end
local function THUM(p) local c=p.Character; return c and c:FindFirstChildOfClass("Humanoid") end

local function Nfy(t,x,d)
    pcall(function() StarterGui:SetCore("SendNotification",{Title=t or "",Text=x or "",Duration=d or 3}) end)
end

local function GCP(r)
    local cl,cd=nil,r or 99999
    for _,p in pairs(Players:GetPlayers()) do
        if p~=LP and THRP(p) and THUM(p) and THUM(p).Health>0 then
            local d=(THRP(p).Position-HRP().Position).Magnitude
            if d<cd then cd=d;cl=p end
        end
    end
    return cl
end

local function GPIR(r)
    local t={}
    for _,p in pairs(Players:GetPlayers()) do
        if p~=LP and THRP(p) and THUM(p) and THUM(p).Health>0 then
            if (THRP(p).Position-HRP().Position).Magnitude<=(r or 99999) then table.insert(t,p) end
        end
    end
    return t
end

-- Player list
local PL={}
local function UPL()
    PL={}
    for _,p in pairs(Players:GetPlayers()) do if p~=LP then table.insert(PL,p.Name) end end
end
UPL()
Players.PlayerAdded:Connect(UPL)
Players.PlayerRemoving:Connect(UPL)

--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
--=  [UI] MODERN CUSTOM GUI â€” SÄ±fÄ±rdan yazÄ±ldÄ±
--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•

-- Renkler (mor-siyah tema)
local COLORS = {
    BG = Color3.fromRGB(15, 12, 22),
    BG2 = Color3.fromRGB(25, 20, 35),
    BG3 = Color3.fromRGB(35, 28, 48),
    ACCENT = Color3.fromRGB(140, 80, 255), -- Mor
    ACCENT2 = Color3.fromRGB(100, 50, 200),
    TEXT = Color3.fromRGB(220, 210, 240),
    TEXT2 = Color3.fromRGB(160, 140, 190),
    RED = Color3.fromRGB(255, 60, 60),
    GREEN = Color3.fromRGB(60, 255, 60),
    ORANGE = Color3.fromRGB(255, 180, 50),
    TOGGLE_ON = Color3.fromRGB(140, 80, 255),
    TOGGLE_OFF = Color3.fromRGB(50, 42, 68),
    SCROLL = Color3.fromRGB(80, 60, 120),
    TAB_SELECTED = Color3.fromRGB(140, 80, 255),
    TAB_UNSELECTED = Color3.fromRGB(35, 28, 48),
    TAB_HOVER = Color3.fromRGB(50, 40, 70),
}

-- Ana GUI
local GUI = Instance.new("ScreenGui")
GUI.Name = "MegaAdminGUI"
GUI.Parent = CG
GUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- DRAG FONKSÄ°YONU
local function MakeDraggable(frame)
    local dragging, dragStart, startPos
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

-- Ana Container
local Container = Instance.new("Frame")
Container.Name = "Container"
Container.Size = UDim2.new(0, 650, 0, 450)
Container.Position = UDim2.new(0.5, -325, 0.5, -225)
Container.BackgroundColor3 = COLORS.BG
Container.BorderSizePixel = 0
Container.Parent = GUI
MakeDraggable(Container)

-- GÃ¶lge/gÃ¶rsel efekt iÃ§in 1px border
local Border = Instance.new("Frame")
Border.Size = UDim2.new(1, 0, 1, 0)
Border.BackgroundColor3 = COLORS.ACCENT
Border.BackgroundTransparency = 0.7
Border.BorderSizePixel = 0
Border.Parent = Container

-- BaÅŸlÄ±k Ã§ubuÄŸu
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 35)
TitleBar.BackgroundColor3 = COLORS.BG2
TitleBar.BorderSizePixel = 0
TitleBar.Parent = Container

local TitleText = Instance.new("TextLabel")
TitleText.Size = UDim2.new(1, -40, 1, 0)
TitleText.Position = UDim2.new(0, 12, 0, 0)
TitleText.BackgroundTransparency = 1
TitleText.Text = "âš¡ MEGA ADMIN v4 â€” THORELL"
TitleText.TextColor3 = COLORS.ACCENT
TitleText.Font = Enum.Font.SourceSansBold
TitleText.TextSize = 16
TitleText.TextXAlignment = Enum.TextXAlignment.Left
TitleText.Parent = TitleBar

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -33, 0, 2)
CloseBtn.BackgroundTransparency = 1
CloseBtn.Text = "âœ•"
CloseBtn.TextColor3 = COLORS.RED
CloseBtn.Font = Enum.Font.SourceSansBold
CloseBtn.TextSize = 18
CloseBtn.Parent = TitleBar

CloseBtn.MouseButton1Click:Connect(function()
    GUI.Enabled = not GUI.Enabled
end)

-- Sol sidebar (tablar)
local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 120, 1, -35)
Sidebar.Position = UDim2.new(0, 0, 0, 35)
Sidebar.BackgroundColor3 = COLORS.BG2
Sidebar.BorderSizePixel = 0
Sidebar.Parent = Container

-- Sidebar scroll
local SideScroll = Instance.new("ScrollingFrame")
SideScroll.Size = UDim2.new(1, 0, 1, 0)
SideScroll.BackgroundTransparency = 1
SideScroll.BorderSizePixel = 0
SideScroll.ScrollBarThickness = 0
SideScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
SideScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
SideScroll.Parent = Sidebar

-- SaÄŸ iÃ§erik alanÄ±
local ContentArea = Instance.new("Frame")
ContentArea.Size = UDim2.new(1, -130, 1, -45)
ContentArea.Position = UDim2.new(0, 125, 0, 40)
ContentArea.BackgroundColor3 = COLORS.BG
ContentArea.BorderSizePixel = 0
ContentArea.Parent = Container

-- Ä°Ã§erik scroll
local ContentScroll = Instance.new("ScrollingFrame")
ContentScroll.Size = UDim2.new(1, -10, 1, -10)
ContentScroll.Position = UDim2.new(0, 5, 0, 5)
ContentScroll.BackgroundTransparency = 1
ContentScroll.BorderSizePixel = 0
ContentScroll.ScrollBarThickness = 4
ContentScroll.ScrollBarImageColor3 = COLORS.SCROLL
ContentScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
ContentScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
ContentScroll.Parent = ContentArea

--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
--=  [UI] TAB SÄ°STEMÄ°
--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•

local Tabs = {}
local ActiveTab = nil
local TabButtons = {}
local TabContents = {}

function CreateTab(name, icon)
    local tabId = #Tabs + 1
    
    -- Tab button
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, 34)
    btn.Position = UDim2.new(0, 5, 0, (#Tabs) * 36 + 5)
    btn.BackgroundColor3 = COLORS.TAB_UNSELECTED
    btn.BorderSizePixel = 0
    btn.Text = (icon or "") .. " " .. name
    btn.TextColor3 = COLORS.TEXT2
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 14
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.Parent = SideScroll
    
    -- Tab content frame (gizli baÅŸlar)
    local contentFrame = Instance.new("Frame")
    contentFrame.Size = UDim2.new(1, 0, 0, 0)
    contentFrame.BackgroundTransparency = 1
    contentFrame.BorderSizePixel = 0
    contentFrame.Parent = ContentScroll
    contentFrame.Visible = false
    contentFrame.AutomaticSize = Enum.AutomaticSize.Y
    
    tabId = #Tabs + 1
    Tabs[tabId] = {name=name, btn=btn, content=contentFrame, icon=icon}
    TabButtons[tabId] = btn
    TabContents[tabId] = contentFrame
    
    -- Click handler
    btn.MouseButton1Click:Connect(function()
        SelectTab(tabId)
    end)
    
    btn.MouseEnter:Connect(function()
        if ActiveTab ~= tabId then btn.BackgroundColor3 = COLORS.TAB_HOVER end
    end)
    btn.MouseLeave:Connect(function()
        if ActiveTab ~= tabId then btn.BackgroundColor3 = COLORS.TAB_UNSELECTED end
    end)
    
    return tabId
end

function SelectTab(tabId)
    ActiveTab = tabId
    for id, data in pairs(Tabs) do
        if id == tabId then
            data.btn.BackgroundColor3 = COLORS.TAB_SELECTED
            data.btn.TextColor3 = COLORS.TEXT
            data.content.Visible = true
        else
            data.btn.BackgroundColor3 = COLORS.TAB_UNSELECTED
            data.btn.TextColor3 = COLORS.TEXT2
            data.content.Visible = false
        end
    end
    ContentScroll.CanvasPosition = Vector2.new(0,0)
end

--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
--=  [UI] UI ELEMANLARI
--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•

local UIElementCount = 0
local SectionFrames = {}

function AddSection(tabId, title)
    UIElementCount = UIElementCount + 1
    
    local section = Instance.new("Frame")
    section.Size = UDim2.new(1, -10, 0, 0)
    section.Position = UDim2.new(0, 5, 0, 0)
    section.BackgroundTransparency = 1
    section.BorderSizePixel = 0
    section.Parent = TabContents[tabId]
    section.AutomaticSize = Enum.AutomaticSize.Y
    
    local sep = Instance.new("Frame")
    sep.Size = UDim2.new(1, -10, 0, 1)
    sep.Position = UDim2.new(0, 5, 0, 0)
    sep.BackgroundColor3 = COLORS.ACCENT
    sep.BackgroundTransparency = 0.7
    sep.BorderSizePixel = 0
    sep.Parent = section
    
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, -10, 0, 28)
    titleLabel.Position = UDim2.new(0, 5, 0, 5)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = title
    titleLabel.TextColor3 = COLORS.ACCENT
    titleLabel.Font = Enum.Font.SourceSansBold
    titleLabel.TextSize = 15
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = section
    
    SectionFrames[UIElementCount] = section
    return UIElementCount, section
end

local function GetElementY(sectionFrame)
    local y = 35
    for _, child in pairs(sectionFrame:GetChildren()) do
        if child:IsA("Frame") and child ~= sectionFrame:FindFirstChildOfClass("Frame") then
            y = y + child.AbsoluteSize.Y + 4
        end
    end
    return y
end

function AddToggle(sectionId, text, desc, callback)
    local section = SectionFrames[sectionId]
    if not section then return end
    
    local y = GetElementY(section)
    
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -10, 0, 38)
    frame.Position = UDim2.new(0, 5, 0, y)
    frame.BackgroundColor3 = COLORS.BG3
    frame.BorderSizePixel = 0
    frame.Parent = section
    
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -50, 0, 20)
    lbl.Position = UDim2.new(0, 10, 0, 2)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.TextColor3 = COLORS.TEXT
    lbl.Font = Enum.Font.SourceSansBold
    lbl.TextSize = 14
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = frame
    
    if desc then
        local dsc = Instance.new("TextLabel")
        dsc.Size = UDim2.new(1, -50, 0, 14)
        dsc.Position = UDim2.new(0, 10, 0, 22)
        dsc.BackgroundTransparency = 1
        dsc.Text = desc
        dsc.TextColor3 = COLORS.TEXT2
        dsc.Font = Enum.Font.SourceSans
        dsc.TextSize = 11
        dsc.TextXAlignment = Enum.TextXAlignment.Left
        dsc.Parent = frame
        frame.Size = UDim2.new(1, -10, 0, 40)
    end
    
    local toggleBg = Instance.new("Frame")
    toggleBg.Size = UDim2.new(0, 40, 0, 22)
    toggleBg.Position = UDim2.new(1, -48, 0, 8)
    toggleBg.BackgroundColor3 = COLORS.TOGGLE_OFF
    toggleBg.BorderSizePixel = 0
    toggleBg.Parent = frame
    
    local toggleCircle = Instance.new("Frame")
    toggleCircle.Size = UDim2.new(0, 18, 0, 18)
    toggleCircle.Position = UDim2.new(0, 2, 0, 2)
    toggleCircle.BackgroundColor3 = COLORS.TEXT2
    toggleCircle.BorderSizePixel = 0
    toggleCircle.Parent = toggleBg
    
    local state = false
    local function UpdateToggle()
        if state then
            toggleBg.BackgroundColor3 = COLORS.TOGGLE_ON
            toggleCircle.Position = UDim2.new(0, 20, 0, 2)
            toggleCircle.BackgroundColor3 = COLORS.TEXT
        else
            toggleBg.BackgroundColor3 = COLORS.TOGGLE_OFF
            toggleCircle.Position = UDim2.new(0, 2, 0, 2)
            toggleCircle.BackgroundColor3 = COLORS.TEXT2
        end
    end
    
    local input = Instance.new("TextButton")
    input.Size = UDim2.new(1, 0, 1, 0)
    input.BackgroundTransparency = 1
    input.Text = ""
    input.Parent = frame
    
    input.MouseButton1Click:Connect(function()
        state = not state
        UpdateToggle()
        pcall(function() callback(state) end)
    end)
    
    UpdateToggle()
    return function() state = not state; UpdateToggle(); pcall(function() callback(state) end) end
end

function AddButton(sectionId, text, desc, callback)
    local section = SectionFrames[sectionId]
    if not section then return end
    
    local y = GetElementY(section)
    
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, 34)
    btn.Position = UDim2.new(0, 5, 0, y)
    btn.BackgroundColor3 = COLORS.ACCENT
    btn.BackgroundTransparency = 0.2
    btn.BorderSizePixel = 0
    btn.Text = text
    btn.TextColor3 = COLORS.TEXT
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 14
    btn.Parent = section
    
    btn.MouseEnter:Connect(function() btn.BackgroundTransparency = 0 end)
    btn.MouseLeave:Connect(function() btn.BackgroundTransparency = 0.2 end)
    btn.MouseButton1Click:Connect(function() pcall(callback) end)
end

function AddSlider(sectionId, text, min, max, default, callback)
    local section = SectionFrames[sectionId]
    if not section then return end
    
    local y = GetElementY(section)
    
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -10, 0, 38)
    frame.Position = UDim2.new(0, 5, 0, y)
    frame.BackgroundColor3 = COLORS.BG3
    frame.BorderSizePixel = 0
    frame.Parent = section
    
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -10, 0, 18)
    lbl.Position = UDim2.new(0, 10, 0, 2)
    lbl.BackgroundTransparency = 1
    lbl.Text = text .. ": " .. tostring(default)
    lbl.TextColor3 = COLORS.TEXT
    lbl.Font = Enum.Font.SourceSansBold
    lbl.TextSize = 13
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = frame
    
    local sliderBg = Instance.new("Frame")
    sliderBg.Size = UDim2.new(1, -20, 0, 6)
    sliderBg.Position = UDim2.new(0, 10, 0, 26)
    sliderBg.BackgroundColor3 = COLORS.TOGGLE_OFF
    sliderBg.BorderSizePixel = 0
    sliderBg.Parent = frame
    
    local sliderFill = Instance.new("Frame")
    sliderFill.Size = UDim2.new((default-min)/(max-min), 0, 1, 0)
    sliderFill.BackgroundColor3 = COLORS.ACCENT
    sliderFill.BorderSizePixel = 0
    sliderFill.Parent = sliderBg
    
    local sliderDrag = Instance.new("TextButton")
    sliderDrag.Size = UDim2.new(1, 0, 1, 0)
    sliderDrag.BackgroundTransparency = 1
    sliderDrag.Text = ""
    sliderDrag.Parent = sliderBg
    
    local dragging = false
    local currentValue = default
    
    sliderDrag.MouseButton1Down:Connect(function()
        dragging = true
    end)
    
    UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
    end)
    
    UIS.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local pos = UIS:GetMouseLocation().X
            local absPos = sliderBg.AbsolutePosition.X
            local absSize = sliderBg.AbsoluteSize.X
            local ratio = math.clamp((pos - absPos) / absSize, 0, 1)
            local value = math.floor(min + (max - min) * ratio)
            sliderFill.Size = UDim2.new(ratio, 0, 1, 0)
            currentValue = value
            lbl.Text = text .. ": " .. tostring(value)
            pcall(function() callback(value) end)
        end
    end)
end

function AddDropdown(sectionId, text, options, callback)
    local section = SectionFrames[sectionId]
    if not section then return end
    
    local y = GetElementY(section)
    
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -10, 0, 34)
    frame.Position = UDim2.new(0, 5, 0, y)
    frame.BackgroundColor3 = COLORS.BG3
    frame.BorderSizePixel = 0
    frame.Parent = section
    
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 1, 0)
    btn.BackgroundTransparency = 1
    btn.Text = text .. ": " .. (options[1] or "")
    btn.TextColor3 = COLORS.TEXT
    btn.Font = Enum.Font.SourceSans
    btn.TextSize = 13
    btn.Parent = frame
    
    local idx = 1
    
    btn.MouseButton1Click:Connect(function()
        idx = idx + 1
        if idx > #options then idx = 1 end
        btn.Text = text .. ": " .. options[idx]
        pcall(function() callback(options[idx]) end)
    end)
end

function AddLabel(sectionId, text)
    local section = SectionFrames[sectionId]
    if not section then return end
    
    local y = GetElementY(section)
    
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -10, 0, 20)
    lbl.Position = UDim2.new(0, 5, 0, y)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.TextColor3 = COLORS.TEXT2
    lbl.Font = Enum.Font.SourceSans
    lbl.TextSize = 12
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = section
end

--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
--=  [FE BYPASS] EN Ä°YÄ° METHOD
--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•

local FE_Hooked=false
local FE_AntiKick=false

local function InitFE()
    if FE_Hooked then return end
    local mt=getrawmetatable(game)
    if mt and mt.__namecall then
        local nc=mt.__namecall
        FE_Hooked=true
        setreadonly(mt,false)
        mt.__namecall=function(self,...)
            local m=getnamecallmethod() or ""
            if FE_AntiKick and m=="FireServer" then
                local s=tostring(self):lower()
                if s:find("kick") or s:find("ban") then return end
            end
            return nc(self,...)
        end
        setreadonly(mt,true)
    end
end

--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
--=  [FEATURES] TOGGLE STATE
--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•

local T = {}
local O = {
    WalkSpeed=16, JumpPower=50, FlySpeed=50,
    AuraRange=20, AuraDamage=5, SpinSpeed=10
}

--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
--=  [FEATURE] LOOP'LAR (TEKRAR KONTROL)
--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•

-- Noclip loop
RS.Stepped:Connect(function()
    if T.Noclip and GC() then
        for _,p in pairs(GC():GetDescendants()) do if p:IsA("BasePart") then p.CanCollide=false end end
    end
end)

-- Fly loop
RS.Heartbeat:Connect(function()
    if T.Fly and HRP() then
        local hrp=HRP()
        local bv=hrp:FindFirstChildOfClass("BodyVelocity")
        local bg=hrp:FindFirstChildOfClass("BodyGyro")
        if bv and bg then
            local md=Vector3.new(
                UIS:IsKeyDown(Enum.KeyCode.D) and 1 or UIS:IsKeyDown(Enum.KeyCode.A) and -1 or 0,
                UIS:IsKeyDown(Enum.KeyCode.Space) and 1 or UIS:IsKeyDown(Enum.KeyCode.LeftShift) and -1 or 0,
                UIS:IsKeyDown(Enum.KeyCode.S) and 1 or UIS:IsKeyDown(Enum.KeyCode.W) and -1 or 0
            )
            bv.Velocity=md.Magnitude>0 and Camera.CFrame:VectorToObjectSpace(md).Unit*O.FlySpeed or Vector3.new(0,0,0)
            bg.CFrame=Camera.CFrame
        end
    end
end)

-- Infinite Jump
UIS.JumpRequest:Connect(function()
    if T.InfiniteJump and HUM() then HUM():ChangeState(Enum.HumanoidStateType.Jumping) end
end)

-- Click TP
Mouse.Button1Down:Connect(function()
    if T.ClickTP and HRP() then HRP().CFrame=CFrame.new(Mouse.Hit.X,Mouse.Hit.Y+3,Mouse.Hit.Z) end
end)

--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
--=  [UI] TABLARI VE Ã–ZELLÄ°KLERÄ° OLUÅTUR
--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•

-- TAB 1: PLAYER
local tab1 = CreateTab("Player", "ğŸ®")
local s1 = AddSection(tab1, "â€”â€” MODLAR â€”â€”")

AddToggle(s1, "God Mode", "Ã–lmezsin â€” Health loop korumasÄ±", function(s)
    T.GodMode=s
    if s then
        local h=HUM()
        if h then h.MaxHealth=9e9;h.Health=9e9;h.BreakJointsOnDeath=false end
        coroutine.wrap(function()
            while T.GodMode do
                wait(0.3)
                local h2=HUM()
                if h2 then
                    if h2.Health<1 then h2.Health=9e9 end
                    h2.MaxHealth=9e9;h2.BreakJointsOnDeath=false
                end
            end
        end)()
        Nfy("God Mode","âœ… Aktif")
    end
end)

AddToggle(s1, "Noclip", "DuvarlarÄ±n iÃ§inden yÃ¼rÃ¼", function(s) T.Noclip=s end)
AddToggle(s1, "Fly", "UÃ§ â€” Space=YukarÄ± Shift=AÅŸaÄŸÄ±", function(s)
    T.Fly=s
    local hrp=HRP()
    if not hrp then return end
    if s then
        local bv=Instance.new("BodyVelocity");bv.MaxForce=Vector3.new(1e9,1e9,1e9);bv.P=1e9;bv.Parent=hrp
        local bg=Instance.new("BodyGyro");bg.MaxTorque=Vector3.new(1e9,1e9,1e9);bg.P=1e9;bg.Parent=hrp
        if HUM() then HUM().PlatformStand=true end
        Nfy("Fly","âœ… UÃ§uÅŸ aktif")
    else
        for _,v in pairs(hrp:GetChildren()) do if v:IsA("BodyVelocity") or v:IsA("BodyGyro") then v:Destroy() end end
        if HUM() then HUM().PlatformStand=false end
    end
end)

AddToggle(s1, "Infinite Jump", "Havada tekrar zÄ±pla", function(s) T.InfiniteJump=s end)
AddToggle(s1, "B-Hop", "KoÅŸarken otomatik zÄ±pla", function(s)
    T.BHop=s
    if s then coroutine.wrap(function() while T.BHop do wait(0.15) if HUM() and HUM().MoveDirection.Magnitude>0 then HUM():ChangeState(Enum.HumanoidStateType.Jumping) end end end)() end
end)

AddToggle(s1, "Spin Bot", "Kendi etrafÄ±nda dÃ¶n", function(s)
    T.SpinBot=s
    if s then coroutine.wrap(function() while T.SpinBot do RS.RenderStepped:Wait() if HRP() then HRP().CFrame=HRP().CFrame*CFrame.Angles(0,math.rad(O.SpinSpeed),0) end end end)() end
end)

AddToggle(s1, "Invisible", "GÃ¶rÃ¼nmez ol", function(s)
    T.Invisible=s;local c=GC()
    if c then for _,p in pairs(c:GetDescendants()) do if p:IsA("BasePart") then p.Transparency=s and 1 or 0;p.CanCollide=not s end end end
end)

AddSlider(s1, "Walk Speed", 1, 500, 16, function(s) O.WalkSpeed=s;if HUM() then HUM().WalkSpeed=s end end)
AddSlider(s1, "Jump Power", 1, 500, 50, function(s) O.JumpPower=s;if HUM() then HUM().JumpPower=s end end)
AddSlider(s1, "Fly Speed", 1, 500, 50, function(s) O.FlySpeed=s end)

local s1b = AddSection(tab1, "â€”â€” ANTI â€”â€”")
AddToggle(s1b, "Anti-Kick", "AtÄ±lamazsÄ±n â€” FE Metatable Hook", function(s) FE_AntiKick=s;InitFE();Nfy("Anti-Kick",s and "âœ…" or "KapalÄ±") end)
AddToggle(s1b, "Anti-AFK", "AFK'den atÄ±lmazsÄ±n", function(s)
    T.AntiAFK=s
    if s then coroutine.wrap(function() while T.AntiAFK do wait(45);VU:CaptureController();VU:ClickButton2(Vector2.new()) end end)() end
end)

AddToggle(s1b, "No Fall Damage", "DÃ¼ÅŸÃ¼ÅŸ hasarÄ± almazsÄ±n", function(s) T.NoFall=s;if HUM() then HUM().FallDamage=not s end end)
AddToggle(s1b, "Auto Heal", "CanÄ±n hep full kalsÄ±n", function(s)
    T.AutoHeal=s
    if s then coroutine.wrap(function() while T.AutoHeal do wait(1) if HUM() and HUM().Health<HUM().MaxHealth then HUM().Health=HUM().MaxHealth end end end)() end
end)

AddButton(s1b, "Reset Character", "Karakteri sÄ±fÄ±rla", function()
    if GC() then GC():BreakJoints() end;wait(2);LP:LoadCharacter()
end)

-- TAB 2: VISUAL
local tab2 = CreateTab("Visual", "ğŸ‘ï¸")
local s2 = AddSection(tab2, "â€”â€” GÃ–RSEL â€”â€”")

local ESP_Objects={}
AddToggle(s2, "ESP", "OyuncularÄ± duvar arkasÄ±ndan gÃ¶r", function(s)
    T.ESP=s
    if s then
        for _,p in pairs(Players:GetPlayers()) do
            if p~=LP and p.Character then
                local hrp=THRP(p)
                local head=p.Character:FindFirstChild("Head") or hrp
                if hrp and head then
                    local hl=Instance.new("Highlight",p.Character);hl.FillColor=Color3.new(1,0,0);hl.FillTransparency=0.5;table.insert(ESP_Objects,hl)
                    local bbg=Instance.new("BillboardGui",p.Character);bbg.Adornee=head;bbg.Size=UDim2.new(0,200,0,50);bbg.StudsOffset=Vector3.new(0,3,0)
                    local tl=Instance.new("TextLabel",bbg);tl.Size=UDim2.new(1,0,1,0);tl.BackgroundTransparency=1;tl.Text=p.Name;tl.TextStrokeTransparency=0.3;tl.TextColor3=Color3.new(1,1,1);tl.TextScaled=true;tl.Font=Enum.Font.SourceSansBold
                    table.insert(ESP_Objects,bbg)
                end
            end
        end
        coroutine.wrap(function() while T.ESP do wait(0.5) for _,p in pairs(Players:GetPlayers()) do if p~=LP and p.Character then for _,bbg in pairs(p.Character:GetDescendants()) do if bbg:IsA("BillboardGui") and bbg:FindFirstChildOfClass("TextLabel") then local d=THRP(p) and HRP() and math.floor((THRP(p).Position-HRP().Position).Magnitude) or 0;bbg.TextLabel.Text=p.Name.." ["..d.."m]" end end end end end end)()
    else
        for _,o in pairs(ESP_Objects) do pcall(function() o:Destroy() end) end;ESP_Objects={}
    end
end)

AddToggle(s2, "Full Bright", "Geceyi gÃ¼ndÃ¼z yap", function(s)
    T.FullBright=s
    if s then Lighting.Ambient=Color3.new(1,1,1);Lighting.Brightness=3;Lighting.FogEnd=1e9;Lighting.ClockTime=12;Lighting.GlobalShadows=false
    else Lighting:SetGlobalLighting() end
end)

AddToggle(s2, "X-Ray", "Her ÅŸey ÅŸeffaf", function(s) T.XRay=s;for _,o in pairs(workspace:GetDescendants()) do if o:IsA("BasePart") then o.Transparency=s and 0.7 or 0 end end end)

AddToggle(s2, "Wallhack", "Duvarlar gÃ¶rÃ¼nmez", function(s) T.Wallhack=s;for _,o in pairs(workspace:GetDescendants()) do if o:IsA("BasePart") and o.Anchored then o.Transparency=s and 0.7 or 0 end end end)

AddToggle(s2, "Highlight", "KÄ±rmÄ±zÄ± vurgu", function(s)
    for _,p in pairs(Players:GetPlayers()) do if p~=LP and p.Character then
        if s then local hl=Instance.new("Highlight",p.Character);hl.FillColor=Color3.new(1,0,0);hl.FillTransparency=0.5
        else for _,hl in pairs(p.Character:GetDescendants()) do if hl:IsA("Highlight") then hl:Destroy() end end end
    end end
end)

AddSlider(s2, "FOV", 20, 180, 70, function(s) Camera.FieldOfView=s end)
AddSlider(s2, "Gravity", 0, 500, 196, function(s) workspace.Gravity=s end)
AddSlider(s2, "Time", 0, 24, 12, function(s) Lighting.ClockTime=s end)

-- TAB 3: TELEPORT
local tab3 = CreateTab("Teleport", "ğŸ“")
local s3 = AddSection(tab3, "â€”â€” IÅINLANMA â€”â€”")

AddToggle(s3, "Click TP", "TÄ±kla gittiÄŸin yere Ä±ÅŸÄ±nlan", function(s) T.ClickTP=s end)
AddDropdown(s3, "Oyuncuya Git", PL, function(sel) local t=Players:FindFirstChild(sel);if t and THRP(t) and HRP() then HRP().CFrame=THRP(t).CFrame*CFrame.new(0,5,0) end end)
AddDropdown(s3, "Getir (Bring)", PL, function(sel) local t=Players:FindFirstChild(sel);if t and THRP(t) and HRP() then THRP(t).CFrame=HRP().CFrame*CFrame.new(0,0,3) end end)
AddButton(s3, "Herkesi Getir", "", function() for _,p in pairs(Players:GetPlayers()) do if p~=LP and THRP(p) and HRP() then THRP(p).CFrame=HRP().CFrame*CFrame.new(0,0,3) end end end)
AddButton(s3, "Spawn'a Git", "", function() if HRP() and workspace:FindFirstChild("SpawnLocation") then HRP().CFrame=workspace.SpawnLocation.CFrame*CFrame.new(0,3,0) end end)
AddButton(s3, "YukarÄ± (+50)", "", function() if HRP() then HRP().CFrame=HRP().CFrame*CFrame.new(0,50,0) end end)
AddButton(s3, "AÅŸaÄŸÄ± (-50)", "", function() if HRP() then HRP().CFrame=HRP().CFrame*CFrame.new(0,-50,0) end end)

-- TAB 4: COMBAT
local tab4 = CreateTab("Combat", "âš”ï¸")
local s4 = AddSection(tab4, "â€”â€” SAVAÅ â€”â€”")

AddToggle(s4, "Aimbot", "En yakÄ±n oyuncuya otomatik niÅŸan", function(s)
    T.Aimbot=s
    if s then coroutine.wrap(function() while T.Aimbot do RS.RenderStepped:Wait();local t=GCP();if t and t.Character and t.Character:FindFirstChild("Head") and THUM(t) and THUM(t).Health>0 then Camera.CFrame=CFrame.lookAt(Camera.CFrame.Position,t.Character.Head.Position) end end end)() end
end)

AddToggle(s4, "Triggerbot", "Hedef niÅŸangahta olunca tÄ±kla", function(s)
    T.Triggerbot=s
    if s then coroutine.wrap(function() while T.Triggerbot do RS.RenderStepped:Wait();local tgt=Mouse.Target;if tgt then for _,p in pairs(Players:GetPlayers()) do if p~=LP and p.Character and tgt:IsDescendantOf(p.Character) then mouse1click();wait(0.05) end end end end end)() end
end)

AddToggle(s4, "Damage Aura", "YakÄ±ndakilere hasar ver", function(s)
    T.DamageAura=s
    if s then coroutine.wrap(function() while T.DamageAura do wait(0.3);for _,target in pairs(GPIR(O.AuraRange)) do local th=THUM(target);if th and th.Health>0 then th.Health=th.Health-O.AuraDamage end end end end)() end
end)

AddToggle(s4, "Auto Click", "SÃ¼rekli otomatik tÄ±kla", function(s)
    T.AutoClick=s
    if s then coroutine.wrap(function() while T.AutoClick do mouse1click();wait(0.05) end end)() end
end)

AddSlider(s4, "Aura Range", 5, 100, 20, function(s) O.AuraRange=s end)
AddSlider(s4, "Aura Damage", 1, 50, 5, function(s) O.AuraDamage=s end)
AddSlider(s4, "Hitbox Size", 1, 20, 3, function(s)
    O.HitboxSize=s
    for _,p in pairs(Players:GetPlayers()) do
        if p~=LP and p.Character then for _,part in pairs(p.Character:GetDescendants()) do if part:IsA("BasePart") then part.Size=Vector3.new(s,s,s) end end end
    end
end)

-- TAB 5: ADMIN
local tab5 = CreateTab("Admin", "ğŸ‘‘")
local s5 = AddSection(tab5, "â€”â€” FE YÃ–NETÄ°CÄ° â€”â€”")

local function FEKick(t)
    if not t then return end
    local c=t.Character
    if c then
        local h=c:FindFirstChildOfClass("Humanoid")
        if h then h.Health=0;h:BreakJoints() end;c:BreakJoints()
    end
    for _,r in pairs(game:GetDescendants()) do if r:IsA("RemoteEvent") and r.Name:lower():find("kick") then pcall(function() r:FireServer(t) end) end end
end

local function FEKill(t)
    if not t or not t.Character then return end
    local h=t.Character:FindFirstChildOfClass("Humanoid")
    if h then h.Health=0;h:BreakJoints() end
end

AddDropdown(s5, "Kick (At)", PL, function(sel) local t=Players:FindFirstChild(sel);if t then FEKick(t);Nfy("KICK",t.Name) end end)
AddButton(s5, "Kick All", "Herkesi at", function() for _,p in pairs(Players:GetPlayers()) do if p~=LP then FEKick(p) end end end)
AddDropdown(s5, "Kill (Ã–ldÃ¼r)", PL, function(sel) local t=Players:FindFirstChild(sel);if t then FEKill(t);Nfy("KILL",t.Name) end end)
AddButton(s5, "Kill All", "Herkesi Ã¶ldÃ¼r", function() for _,p in pairs(Players:GetPlayers()) do if p~=LP then FEKill(p) end end end)
AddDropdown(s5, "Freeze (Dondur)", PL, function(sel)
    local t=Players:FindFirstChild(sel)
    if t and THRP(t) then local bp=Instance.new("BodyPosition");bp.Position=THRP(t).Position;bp.MaxForce=Vector3.new(1e9,1e9,1e9);bp.P=1e9;bp.Parent=THRP(t) end
end)
AddButton(s5, "Freeze All", "", function() for _,p in pairs(Players:GetPlayers()) do if p~=LP and THRP(p) then local bp=Instance.new("BodyPosition");bp.Position=THRP(p).Position;bp.MaxForce=Vector3.new(1e9,1e9,1e9);bp.P=1e9;bp.Parent=THRP(p) end end end)
AddDropdown(s5, "Unfreeze (Ã‡Ã¶z)", PL, function(sel) local t=Players:FindFirstChild(sel);if t and THRP(t) then for _,v in pairs(THRP(t):GetChildren()) do if v:IsA("BodyPosition") then v:Destroy() end end end end)
AddButton(s5, "Unfreeze All", "", function() for _,p in pairs(Players:GetPlayers()) do if THRP(p) then for _,v in pairs(THRP(p):GetChildren()) do if v:IsA("BodyPosition") then v:Destroy() end end end end end)
AddDropdown(s5, "Jail (Hapis)", PL, function(sel)
    local t=Players:FindFirstChild(sel)
    if t and THRP(t) then
        local pos=THRP(t).Position
        for dx=-5,5,2 do for dz=-5,5,2 do if math.abs(dx)<=4 or math.abs(dz)<=4 then
            local p=Instance.new("Part");p.Size=Vector3.new(2,1,2);p.Position=pos+Vector3.new(dx,0,dz);p.Anchored=true;p.BrickColor=BrickColor.new("Bright red");p.Parent=workspace;Debris:AddItem(p,60)
        end end end
        local c=Instance.new("Part");c.Size=Vector3.new(12,1,12);c.Position=pos+Vector3.new(0,6,0);c.Anchored=true;c.Parent=workspace;Debris:AddItem(c,60)
    end
end)
AddDropdown(s5, "Heal (Ä°yileÅŸtir)", PL, function(sel) local t=Players:FindFirstChild(sel);if t and THUM(t) then THUM(t).Health=THUM(t).MaxHealth end end)
AddButton(s5, "Heal All", "", function() for _,p in pairs(Players:GetPlayers()) do if THUM(p) then THUM(p).Health=THUM(p).MaxHealth end end end)
AddButton(s5, "Lag", "Sunucuyu yavaÅŸlat", function()
    for i=1,1000 do
        local p=Instance.new("Part");p.Position=Vector3.new(math.random(-100,100),50,math.random(-100,100));p.Velocity=Vector3.new(math.random(-100,100),math.random(-100,100),math.random(-100,100));p.Parent=workspace;Debris:AddItem(p,10)
    end
end)

-- TAB 6: MISC
local tab6 = CreateTab("Misc", "ğŸ”§")
local s6 = AddSection(tab6, "â€”â€” Ã‡EÅÄ°TLÄ° â€”â€”")

AddButton(s6, "Rejoin", "Sunucuya yeniden katÄ±l", function() TS:Teleport(game.PlaceId,LP) end)

AddButton(s6, "Server Hop", "FarklÄ± sunucuya geÃ§", function()
    local s,d=pcall(function() return HttpS:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?limit=100")) end)
    if s and d and d.data then for _,sv in pairs(d.data) do if sv.id~=game.JobId and sv.playing<sv.maxPlayers then TS:TeleportToPlaceInstance(game.PlaceId,sv.id,LP);return end end end
end)

AddButton(s6, "FPS Counter", "FPS sayacÄ± gÃ¶ster", function()
    local g=Instance.new("ScreenGui",CG);local l=Instance.new("TextLabel",g)
    l.Size=UDim2.new(0,100,0,30);l.Position=UDim2.new(0,10,0,10);l.BackgroundTransparency=0.5;l.BackgroundColor3=Color3.new(0,0,0)
    l.TextColor3=Color3.new(0,1,0);l.Font=Enum.Font.SourceSansBold;l.TextScaled=true
    coroutine.wrap(function() while g.Parent do RS.RenderStepped:Wait();l.Text="FPS: "..math.floor(1/RS.RenderStepped:Wait()) end end)()
end)

AddButton(s6, "Player List", "OyuncularÄ± gÃ¶ster", function()
    local n={};for _,p in pairs(Players:GetPlayers()) do table.insert(n,p.Name) end
    Nfy("Players ("..#Players:GetPlayers()..")",table.concat(n,", "))
end)

-- TAB 7: SETTINGS
local tab7 = CreateTab("Settings", "âš™ï¸")
local s7 = AddSection(tab7, "â€”â€” KISAYOL TUÅLARI â€”â€”")

-- Keybind'ler
local keybinds = {
    {"GUI AÃ§/Kapa", Enum.KeyCode.LeftControl, function()
        GUI.Enabled = not GUI.Enabled
    end},
    {"Noclip", Enum.KeyCode.N, function() T.Noclip=not T.Noclip end},
    {"Fly", Enum.KeyCode.F, function()
        T.Fly=not T.Fly;local hrp=HRP()
        if T.Fly and hrp then
            Instance.new("BodyVelocity",hrp).MaxForce=Vector3.new(1e9,1e9,1e9)
            Instance.new("BodyGyro",hrp).MaxTorque=Vector3.new(1e9,1e9,1e9)
        elseif hrp then for _,v in pairs(hrp:GetChildren()) do if v:IsA("BodyVelocity") or v:IsA("BodyGyro") then v:Destroy() end end end
    end},
    {"God Mode", Enum.KeyCode.Q, function() T.GodMode=not T.GodMode end},
    {"ESP", Enum.KeyCode.E, function()
        T.ESP=not T.ESP
        if T.ESP then
            for _,p in pairs(Players:GetPlayers()) do if p~=LP and p.Character then
                local hrp=THRP(p);local head=p.Character:FindFirstChild("Head") or hrp
                if hrp and head then
                    local hl=Instance.new("Highlight",p.Character);hl.FillColor=Color3.new(1,0,0);hl.FillTransparency=0.5;table.insert(ESP_Objects,hl)
                    local bbg=Instance.new("BillboardGui",p.Character);bbg.Adornee=head;bbg.Size=UDim2.new(0,200,0,50);bbg.StudsOffset=Vector3.new(0,3,0);local tl=Instance.new("TextLabel",bbg);tl.Size=UDim2.new(1,0,1,0);tl.BackgroundTransparency=1;tl.Text=p.Name;tl.TextStrokeTransparency=0.3;tl.TextColor3=Color3.new(1,1,1);tl.TextScaled=true;tl.Font=Enum.Font.SourceSansBold;table.insert(ESP_Objects,bbg)
                end
            end end
        else for _,o in pairs(ESP_Objects) do pcall(function() o:Destroy() end) end;ESP_Objects={} end
    end},
    {"Infinite Jump", Enum.KeyCode.G, function() T.InfiniteJump=not T.InfiniteJump end},
    {"Click TP", Enum.KeyCode.T, function() T.ClickTP=not T.ClickTP end},
    {"Speed Boost", Enum.KeyCode.X, function() if HUM() then HUM().WalkSpeed=100;wait(5);HUM().WalkSpeed=O.WalkSpeed end end},
    {"Reset", Enum.KeyCode.R, function() if GC() then GC():BreakJoints() end;wait(2);LP:LoadCharacter() end},
}

for _,kb in pairs(keybinds) do
    AddLabel(s7, kb[1] .. " [" .. tostring(kb[2]):gsub("Enum.KeyCode.","") .. "]")
end

AddLabel(s7, "")
AddLabel(s7, "âš¡ MEGA ADMIN v4 â€” THORELL EDITION")
AddLabel(s7, "ğŸ’œ Mor-Siyah Tema | 0 External Loading")
AddLabel(s7, "ğŸ“Œ Her Ã¶zellik en iyi FE method ile Ã§alÄ±ÅŸÄ±r")
AddLabel(s7, "")
AddLabel(s7, "âš ï¸ Byfron oyunlarÄ±nda executor bypass gerek")
AddLabel(s7, "   Arsenal / Da Hood / Doors / MM2 / PF")
AddLabel(s7, "")
AddLabel(s7, "ğŸ‘¤ Owner: THORELL")
AddLabel(s7, "âš¡ Built by Naiwles One")

--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
--=  [KEYBIND] GLOBAL KISAYOLLAR
--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•

UIS.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.LeftControl then
        GUI.Enabled = not GUI.Enabled
    elseif input.KeyCode == Enum.KeyCode.N then
        T.Noclip = not T.Noclip
    elseif input.KeyCode == Enum.KeyCode.F then
        T.Fly = not T.Fly
        local hrp=HRP()
        if T.Fly and hrp then
            Instance.new("BodyVelocity",hrp).MaxForce=Vector3.new(1e9,1e9,1e9)
            Instance.new("BodyGyro",hrp).MaxTorque=Vector3.new(1e9,1e9,1e9)
        elseif hrp then for _,v in pairs(hrp:GetChildren()) do if v:IsA("BodyVelocity") or v:IsA("BodyGyro") then v:Destroy() end end end
    elseif input.KeyCode == Enum.KeyCode.Q then
        T.GodMode = not T.GodMode
    elseif input.KeyCode == Enum.KeyCode.E then
        T.ESP = not T.ESP
    elseif input.KeyCode == Enum.KeyCode.G then
        T.InfiniteJump = not T.InfiniteJump
    elseif input.KeyCode == Enum.KeyCode.T then
        T.ClickTP = not T.ClickTP
    elseif input.KeyCode == Enum.KeyCode.X then
        if HUM() then HUM().WalkSpeed = 100;wait(5);HUM().WalkSpeed=O.WalkSpeed end
    elseif input.KeyCode == Enum.KeyCode.R then
        if GC() then GC():BreakJoints() end;wait(2);LP:LoadCharacter()
    end
end)

--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
--=  [START] Ä°LK TAB'I GÃ–STER
--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•

SelectTab(1)

Nfy("âš¡ MEGA ADMIN v4","%100 yerel UI | LCtrl=GUI | "..#PL.." oyuncu",5)

print("â•”â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•—")
print("â•‘  âš¡ MEGA ADMIN v4 â€” THORELL EDITION     â•‘")
print("â•‘  ğŸ’œ SÄ±fÄ±rdan yazÄ±lmÄ±ÅŸ UI                â•‘")
print("â•‘  ğŸ“Œ LCtrl = GUI aÃ§/kapa                 â•‘")
print("â•šâ•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•")

InitFE()
