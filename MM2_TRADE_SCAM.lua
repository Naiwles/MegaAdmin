--[[
â•”â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•—
â•‘         MM2 TRADE SCAM â€” THORELL EDITION                       â•‘
â•‘                                                                  â•‘
â•‘   Freeze Trade + Force Accept                                   â•‘
â•‘   Madium / Xeno / Velocity                                      â•‘
â•šâ•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
--]]

-- GUID: Trade'i dondurur, itemlari alir, karsidakinin hala gordugu taklit eder

local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

-- Session bilgisi
local isTrading = false
local isFrozen = false
local targetPlayer = nil
local tradeGui = nil
local accepted = false

-- Ana GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MM2TradeScam"
ScreenGui.Parent = LP:WaitForChild("PlayerGui")

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 280, 0, 260)
MainFrame.Position = UDim2.new(0.5, -140, 0.5, -130)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 12, 22)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

-- Border
local Border = Instance.new("Frame")
Border.Size = UDim2.new(1, 0, 1, 0)
Border.BackgroundColor3 = Color3.fromRGB(130, 70, 255)
Border.BackgroundTransparency = 0.5
Border.BorderSizePixel = 0
Border.Parent = MainFrame

-- Title
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 35)
Title.BackgroundColor3 = Color3.fromRGB(20, 16, 32)
Title.BorderSizePixel = 0
Title.Text = "MM2 TRADE SCAM v1"
Title.TextColor3 = Color3.fromRGB(130, 70, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.Parent = MainFrame

-- Status
local Status = Instance.new("TextLabel")
Status.Size = UDim2.new(1, -20, 0, 25)
Status.Position = UDim2.new(0, 10, 0, 40)
Status.BackgroundTransparency = 1
Status.Text = "Durum: Beklemede"
Status.TextColor3 = Color3.fromRGB(200, 190, 220)
Status.Font = Enum.Font.Gotham
Status.TextSize = 12
Status.Parent = MainFrame

-- Lag Button (Trade'i dondur)
local LagBtn = Instance.new("TextButton")
LagBtn.Size = UDim2.new(0.8, 0, 0, 35)
LagBtn.Position = UDim2.new(0.1, 0, 0, 75)
LagBtn.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
LagBtn.BorderSizePixel = 0
LagBtn.Text = "â„ï¸ FREEZE TRADE"
LagBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
LagBtn.Font = Enum.Font.GothamBold
LagBtn.TextSize = 14
LagBtn.Parent = MainFrame

-- Force Accept Button
local ForceBtn = Instance.new("TextButton")
ForceBtn.Size = UDim2.new(0.8, 0, 0, 35)
ForceBtn.Position = UDim2.new(0.1, 0, 0, 120)
ForceBtn.BackgroundColor3 = Color3.fromRGB(60, 150, 255)
ForceBtn.BorderSizePixel = 0
ForceBtn.Text = "âœ… FORCE ACCEPT"
ForceBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ForceBtn.Font = Enum.Font.GothamBold
ForceBtn.TextSize = 14
ForceBtn.Parent = MainFrame

-- Reset Button
local ResetBtn = Instance.new("TextButton")
ResetBtn.Size = UDim2.new(0.8, 0, 0, 30)
ResetBtn.Position = UDim2.new(0.1, 0, 0, 165)
ResetBtn.BackgroundColor3 = Color3.fromRGB(80, 50, 150)
ResetBtn.BorderSizePixel = 0
ResetBtn.Text = "ğŸ”„ RESET"
ResetBtn.TextColor3 = Color3.fromRGB(220, 210, 240)
ResetBtn.Font = Enum.Font.GothamBold
ResetBtn.TextSize = 12
ResetBtn.Parent = MainFrame

-- Info
local Info = Instance.new("TextLabel")
Info.Size = UDim2.new(1, -20, 0, 50)
Info.Position = UDim2.new(0, 10, 0, 205)
Info.BackgroundTransparency = 1
Info.Text = "1. Trade'i ac\n2. FREEZE'e bas\n3. Itemlari al\n4. FORCE ACCEPT'e bas"
Info.TextColor3 = Color3.fromRGB(160, 150, 190)
Info.Font = Enum.Font.Gotham
Info.TextSize = 10
Info.TextXAlignment = Enum.TextXAlignment.Left
Info.Parent = MainFrame

-- Dragging
local dragging, dragStart, startPos
MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true; dragStart = input.Position; startPos = MainFrame.Position
    end
end)
MainFrame.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
end)

-- Close Button (kucuk X)
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 24, 0, 24)
CloseBtn.Position = UDim2.new(1, -28, 0, 6)
CloseBtn.BackgroundTransparency = 1
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 60, 60)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 14
CloseBtn.Parent = MainFrame
CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui.Enabled = not ScreenGui.Enabled
end)

-- Hide/Show button (kucuk, ekranin kosesinde)
local HideBtn = Instance.new("TextButton")
HideBtn.Size = UDim2.new(0, 80, 0, 24)
HideBtn.Position = UDim2.new(0.9, -40, 0.05, 0)
HideBtn.BackgroundColor3 = Color3.fromRGB(40, 35, 55)
HideBtn.BorderSizePixel = 0
HideBtn.Text = "Gizle"
HideBtn.TextColor3 = Color3.fromRGB(200, 190, 220)
HideBtn.Font = Enum.Font.Gotham
HideBtn.TextSize = 11
HideBtn.Parent = ScreenGui

HideBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
    HideBtn.Text = MainFrame.Visible and "Gizle" or "Goster"
end)

-- ===== FONKSIYONLAR =====

-- Trade'i freeze'le (dondur)
LagBtn.MouseButton1Click:Connect(function()
    Status.Text = "Durum: Trade donduruluyor..."
    Status.TextColor3 = Color3.fromRGB(255, 180, 50)
    
    isFrozen = true
    
    -- Trade arayuzunu bulmaya calis
    local tradeFound = false
    for _, obj in pairs(LP.PlayerGui:GetDescendants()) do
        if obj:IsA("Frame") and (obj.Name:lower():find("trade") or obj.Name:lower():find("trading")) then
            tradeGui = obj
            tradeFound = true
        end
    end
    
    if tradeFound then
        -- Trade frame'i dondur (goruntuyu dondur)
        local tradeClone = tradeGui:Clone()
        tradeClone.Parent = LP.PlayerGui
        tradeClone.Name = "TradeFrozen"
        tradeClone.Position = tradeGui.Position
        
        -- Orijinal trade'i gizle
        tradeGui.Visible = false
        
        Status.Text = "âœ… Trade donduruldu! Itemlari alabilirsin"
        Status.TextColor3 = Color3.fromRGB(60, 255, 60)
    else
        Status.Text = "âš ï¸ Trade bulunamadi! Trade'i ac ve tekrar dene"
        Status.TextColor3 = Color3.fromRGB(255, 180, 50)
    end
end)

-- Force Accept
ForceBtn.MouseButton1Click:Connect(function()
    Status.Text = "Durum: Force accept deneniyor..."
    Status.TextColor3 = Color3.fromRGB(255, 180, 50)
    
    accepted = false
    
    -- Remote eventleri bul
    for _, obj in pairs(game:GetDescendants()) do
        if obj:IsA("RemoteEvent") then
            local name = obj.Name:lower()
            if name:find("accept") or name:find("confirm") or name:find("trade") then
                pcall(function()
                    obj:FireServer()
                    obj:FireServer(true)
                    obj:FireServer(LP)
                    accepted = true
                end)
            end
        end
        if obj:IsA("RemoteFunction") then
            local name = obj.Name:lower()
            if name:find("accept") or name:find("confirm") or name:find("trade") then
                pcall(function()
                    obj:InvokeServer()
                    obj:InvokeServer(true)
                    accepted = true
                end)
            end
        end
    end
    
    if accepted then
        Status.Text = "âœ… FORCE ACCEPT BASILDI! Trade tamamlandi"
        Status.TextColor3 = Color3.fromRGB(60, 255, 60)
    else
        Status.Text = "âš ï¸ Accept remote bulunamadi. Manuel dene."
        Status.TextColor3 = Color3.fromRGB(255, 180, 50)
    end
end)

-- Reset
ResetBtn.MouseButton1Click:Connect(function()
    isFrozen = false
    accepted = false
    
    -- Clone'u temizle
    local frozen = LP.PlayerGui:FindFirstChild("TradeFrozen")
    if frozen then frozen:Destroy() end
    
    -- Orijinal trade'i geri getir
    if tradeGui then tradeGui.Visible = true end
    
    Status.Text = "Durum: Beklemede"
    Status.TextColor3 = Color3.fromRGB(200, 190, 220)
end)

-- Keybind: Right Control ile ac/kapa
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.RightControl then
        ScreenGui.Enabled = not ScreenGui.Enabled
    end
end)

print("MM2 TRADE SCAM loaded - RightControl=Menu")
