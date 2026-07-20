--[[
â•”â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•—
â•‘         âš¡ MEGA ADMIN v5 â€” THORELL EDITION                                 â•‘
â•‘                                                                              â•‘
â•‘   TÃ¼m Ã¶zellikler modern | Font dÃ¼zeltildi | Oyuncu seÃ§me ekranÄ±            â•‘
â•‘   Silent Aim | Versiyon kontrol | 0 External Loading                       â•‘
â•šâ•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
--]]

--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
--=  VERSÄ°YON KONTROL â€” GÃœNCELLEME KONTROL
--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•

local SCRIPT_VERSION = "v5.5"
local GITHUB_RAW = "https://raw.githubusercontent.com/Naiwles/MegaAdmin/main/MEGA_ADMIN_v5.lua"
local GITHUB_PAGE = "https://github.com/Naiwles/MegaAdmin"

-- Arka planda versiyon kontrolÃ¼
coroutine.wrap(function()
    local succ, res = pcall(function()
        return game:HttpGet(GITHUB_RAW):match("SCRIPT_VERSION%s*=%s*\"([^\"]+)\"")
    end)
    if succ and res and res ~= SCRIPT_VERSION then
        warn("[MEGA ADMIN] Yeni sÃ¼rÃ¼m mevcut: " .. res .. " (sen: " .. SCRIPT_VERSION .. ")")
    end
end)()

--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
--=  CORE
--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•

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
local Debris = game:GetService("Debris")
local StarterGui = game:GetService("StarterGui")

--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
--=  UTILITY
--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•

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

local PL={}
local function UPL()
    PL={}
    for _,p in pairs(Players:GetPlayers()) do if p~=LP then table.insert(PL,p) end end
end
UPL()
Players.PlayerAdded:Connect(UPL)
Players.PlayerRemoving:Connect(UPL)

--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
--=  FE BYPASS
--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•

local FE_Hooked=false
local FE_AntiKick=false
local mt=getrawmetatable(game)
local __namecall=mt and mt.__namecall

local function InitFE()
    if FE_Hooked or not mt or not __namecall then return end
    FE_Hooked=true
    setreadonly(mt,false)
    mt.__namecall=function(self,...)
        local m=getnamecallmethod() or ""
        if FE_AntiKick and m=="FireServer" then
            local s=tostring(self):lower()
            if s:find("kick") or s:find("ban") then return end
        end
        return __namecall(self,...)
    end
    setreadonly(mt,true)
end

--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
--=  UI RENKLER & FONTLAR
--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•

local FONT = Enum.Font.GothamSemibold
local FONT2 = Enum.Font.Gotham

local C = {
    BG = Color3.fromRGB(15, 12, 22),
    BG2 = Color3.fromRGB(25, 20, 35),
    BG3 = Color3.fromRGB(38, 30, 52),
    MOR = Color3.fromRGB(140, 80, 255),
    MOR2 = Color3.fromRGB(100, 50, 200),
    MOR3 = Color3.fromRGB(60, 40, 100),
    TEXT = Color3.fromRGB(230, 220, 245),
    TEXT2 = Color3.fromRGB(170, 150, 200),
    KIRMIZI = Color3.fromRGB(255, 60, 60),
    YESIL = Color3.fromRGB(60, 255, 60),
    TURUNCU = Color3.fromRGB(255, 180, 50),
    MAVI = Color3.fromRGB(60, 150, 255),
    ACK_MOR = Color3.fromRGB(180, 140, 255),
}

--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
--=  UI â€” ANA MENÃœ
--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•

local GUI = Instance.new("ScreenGui")
GUI.Name = "MegaAdminV5"
GUI.Parent = CG
GUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local Container = Instance.new("Frame")
Container.Name = "Main"
Container.Size = UDim2.new(0, 680, 0, 480)
Container.Position = UDim2.new(0.5, -340, 0.5, -240)
Container.BackgroundColor3 = C.BG
Container.BorderSizePixel = 0
Container.Parent = GUI

local BorderLine = Instance.new("Frame")
BorderLine.Size = UDim2.new(1, 0, 1, 0)
BorderLine.BackgroundColor3 = C.MOR
BorderLine.BackgroundTransparency = 0.5
BorderLine.BorderSizePixel = 0
BorderLine.Parent = Container

-- SÃ¼rÃ¼kleme
local function MakeDrag(f)
    local d,s,p
    f.InputBegan:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.MouseButton1 then d=true;s=i.Position;p=f.Position end
    end)
    f.InputChanged:Connect(function(i)
        if d and i.UserInputType==Enum.UserInputType.MouseMovement then
            local delta=i.Position-s
            f.Position=UDim2.new(p.X.Scale,p.X.Offset+delta.X,p.Y.Scale,p.Y.Offset+delta.Y)
        end
    end)
    UIS.InputEnded:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.MouseButton1 then d=false end
    end)
end

-- BaÅŸlÄ±k
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 38)
TitleBar.BackgroundColor3 = C.BG2
TitleBar.BorderSizePixel = 0
TitleBar.Parent = Container
MakeDrag(TitleBar)

local TitleLbl = Instance.new("TextLabel")
TitleLbl.Size = UDim2.new(1, -45, 1, 0)
TitleLbl.Position = UDim2.new(0, 12, 0, 0)
TitleLbl.BackgroundTransparency = 1
TitleLbl.Text = "MEGA ADMIN " .. SCRIPT_VERSION
TitleLbl.TextColor3 = C.MOR
TitleLbl.Font = FONT
TitleLbl.TextSize = 17
TitleLbl.TextXAlignment = Enum.TextXAlignment.Left
TitleLbl.Parent = TitleBar

-- Versiyon gÃ¼ncelleme bildirimi
local UpdateBtn = Instance.new("TextButton")
UpdateBtn.Size = UDim2.new(0, 80, 0, 24)
UpdateBtn.Position = UDim2.new(1, -175, 0, 7)
UpdateBtn.BackgroundColor3 = C.BG3
UpdateBtn.BorderSizePixel = 0
UpdateBtn.Text = "Guncelle"
UpdateBtn.TextColor3 = C.TURUNCU
UpdateBtn.Font = FONT2
UpdateBtn.TextSize = 11
UpdateBtn.Visible = false
UpdateBtn.Parent = TitleBar

UpdateBtn.MouseButton1Click:Connect(function()
    pcall(function() setclipboard(GITHUB_RAW) end)
    Nfy("Github", GITHUB_PAGE)
end)

-- Versiyon kontrol
coroutine.wrap(function()
    local s,r=pcall(function() return game:HttpGet(GITHUB_RAW):match("SCRIPT_VERSION%s*=%s*\"([^\"]+)\"") end)
    if s and r and r~=SCRIPT_VERSION then
        UpdateBtn.Visible = true
        UpdateBtn.Text = "Guncelle: " .. r
    end
end)()

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -34, 0, 4)
CloseBtn.BackgroundTransparency = 1
CloseBtn.Text = "X"
CloseBtn.TextColor3 = C.KIRMIZI
CloseBtn.Font = FONT
CloseBtn.TextSize = 16
CloseBtn.Parent = TitleBar
CloseBtn.MouseButton1Click:Connect(function() GUI.Enabled = not GUI.Enabled end)

-- SIDEBAR
local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 130, 1, -38)
Sidebar.Position = UDim2.new(0, 0, 0, 38)
Sidebar.BackgroundColor3 = C.BG2
Sidebar.BorderSizePixel = 0
Sidebar.Parent = Container

local SideScroll = Instance.new("ScrollingFrame")
SideScroll.Size = UDim2.new(1, -5, 1, -5)
SideScroll.Position = UDim2.new(0, 3, 0, 3)
SideScroll.BackgroundTransparency = 1
SideScroll.BorderSizePixel = 0
SideScroll.ScrollBarThickness = 0
SideScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
SideScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
SideScroll.Parent = Sidebar

-- CONTENT
local ContentFrame = Instance.new("Frame")
ContentFrame.Size = UDim2.new(1, -140, 1, -48)
ContentFrame.Position = UDim2.new(0, 135, 0, 43)
ContentFrame.BackgroundColor3 = C.BG
ContentFrame.BorderSizePixel = 0
ContentFrame.Parent = Container

local ContentScroll = Instance.new("ScrollingFrame")
ContentScroll.Size = UDim2.new(1, -10, 1, -10)
ContentScroll.Position = UDim2.new(0, 5, 0, 5)
ContentScroll.BackgroundTransparency = 1
ContentScroll.BorderSizePixel = 0
ContentScroll.ScrollBarThickness = 4
ContentScroll.ScrollBarImageColor3 = C.MOR3
ContentScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
ContentScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
ContentScroll.Parent = ContentFrame

--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
--=  UI â€” TAB & ELEMAN SÄ°STEMÄ°
--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•

local Tabs = {}
local ActiveTab = 1

function NewTab(isim, ikon)
    local id = #Tabs + 1
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -5, 0, 32)
    btn.Position = UDim2.new(0, 3, 0, (id-1)*35 + 5)
    btn.BackgroundColor3 = C.BG2
    btn.BorderSizePixel = 0
    btn.Text = "[" .. ikon .. "] " .. isim
    btn.TextColor3 = C.TEXT2
    btn.Font = FONT2
    btn.TextSize = 13
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.Parent = SideScroll
    
    local icerik = Instance.new("Frame")
    icerik.Size = UDim2.new(1, 0, 0, 0)
    icerik.BackgroundTransparency = 1
    icerik.BorderSizePixel = 0
    icerik.Parent = ContentScroll
    icerik.Visible = false
    icerik.AutomaticSize = Enum.AutomaticSize.Y
    
    Tabs[id] = {btn=btn, icerik=icerik, isim=isim}
    
    btn.MouseButton1Click:Connect(function()
        ActiveTab = id
        for i,t in pairs(Tabs) do
            t.btn.BackgroundColor3 = (i==id) and C.MOR3 or C.BG2
            t.btn.TextColor3 = (i==id) and C.TEXT or C.TEXT2
            t.icerik.Visible = (i==id)
        end
        ContentScroll.CanvasPosition = Vector2.new(0,0)
    end)
    
    btn.MouseEnter:Connect(function()
        if ActiveTab~=id then btn.BackgroundColor3 = C.BG3 end
    end)
    btn.MouseLeave:Connect(function()
        if ActiveTab~=id then btn.BackgroundColor3 = C.BG2 end
    end)
    
    return id
end

function NewSection(tabId, baslik)
    local section = Instance.new("Frame")
    section.Size = UDim2.new(1, -10, 0, 0)
    section.Position = UDim2.new(0, 5, 0, 0)
    section.BackgroundTransparency = 1
    section.BorderSizePixel = 0
    section.Parent = Tabs[tabId].icerik
    section.AutomaticSize = Enum.AutomaticSize.Y
    
    local sep = Instance.new("Frame")
    sep.Size = UDim2.new(1, -10, 0, 1)
    sep.Position = UDim2.new(0, 5, 0, 0)
    sep.BackgroundColor3 = C.MOR
    sep.BackgroundTransparency = 0.6
    sep.BorderSizePixel = 0
    sep.Parent = section
    
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -10, 0, 26)
    lbl.Position = UDim2.new(0, 5, 0, 6)
    lbl.BackgroundTransparency = 1
    lbl.Text = "[ " .. baslik .. " ]"
    lbl.TextColor3 = C.ACK_MOR
    lbl.Font = FONT
    lbl.TextSize = 14
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = section
    
    local elemY = 36
    local elemSay = 0
    
    local fonk = {}
    
    function fonk.Toggle(yazi, aciklama, geri)
        elemSay=elemSay+1
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(1, -10, 0, 40)
        frame.Position = UDim2.new(0, 5, 0, elemY)
        frame.BackgroundColor3 = C.BG3
        frame.BorderSizePixel = 0
        frame.Parent = section
        elemY = elemY + 43
        
        local metin = Instance.new("TextLabel")
        metin.Size = UDim2.new(1, -55, 0, 20)
        metin.Position = UDim2.new(0, 10, 0, 2)
        metin.BackgroundTransparency = 1
        metin.Text = yazi
        metin.TextColor3 = C.TEXT
        metin.Font = FONT2
        metin.TextSize = 14
        metin.TextXAlignment = Enum.TextXAlignment.Left
        metin.Parent = frame
        
        if aciklama then
            local acik = Instance.new("TextLabel")
            acik.Size = UDim2.new(1, -55, 0, 14)
            acik.Position = UDim2.new(0, 10, 0, 22)
            acik.BackgroundTransparency = 1
            acik.Text = aciklama
            acik.TextColor3 = C.TEXT2
            acik.Font = FONT2
            acik.TextSize = 10
            acik.TextXAlignment = Enum.TextXAlignment.Left
            acik.Parent = frame
        end
        
        local toggleBg = Instance.new("Frame")
        toggleBg.Size = UDim2.new(0, 36, 0, 20)
        toggleBg.Position = UDim2.new(1, -44, 0, 10)
        toggleBg.BackgroundColor3 = C.BG2
        toggleBg.BorderSizePixel = 0
        toggleBg.Parent = frame
        
        local toggleCircle = Instance.new("Frame")
        toggleCircle.Size = UDim2.new(0, 16, 0, 16)
        toggleCircle.Position = UDim2.new(0, 2, 0, 2)
        toggleCircle.BackgroundColor3 = C.TEXT2
        toggleCircle.BorderSizePixel = 0
        toggleCircle.Parent = toggleBg
        
        local durum = false
        local function Guncelle()
            if durum then
                toggleBg.BackgroundColor3 = C.MOR
                toggleCircle.Position = UDim2.new(0, 18, 0, 2)
                toggleCircle.BackgroundColor3 = C.TEXT
            else
                toggleBg.BackgroundColor3 = C.BG2
                toggleCircle.Position = UDim2.new(0, 2, 0, 2)
                toggleCircle.BackgroundColor3 = C.TEXT2
            end
        end
        
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, 0, 1, 0)
        btn.BackgroundTransparency = 1
        btn.Text = ""
        btn.Parent = frame
        
        btn.MouseButton1Click:Connect(function()
            durum = not durum
            Guncelle()
            pcall(function() geri(durum) end)
        end)
        
        Guncelle()
        return function() durum=not durum;Guncelle();pcall(function() geri(durum) end) end
    end
    
    function fonk.Buton(yazi, geri)
        elemSay=elemSay+1
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, -10, 0, 32)
        btn.Position = UDim2.new(0, 5, 0, elemY)
        btn.BackgroundColor3 = C.MOR
        btn.BackgroundTransparency = 0.3
        btn.BorderSizePixel = 0
        btn.Text = yazi
        btn.TextColor3 = C.TEXT
        btn.Font = FONT2
        btn.TextSize = 13
        btn.Parent = section
        elemY = elemY + 36
        
        btn.MouseEnter:Connect(function() btn.BackgroundTransparency = 0.1 end)
        btn.MouseLeave:Connect(function() btn.BackgroundTransparency = 0.3 end)
        btn.MouseButton1Click:Connect(function() pcall(geri) end)
    end
    
    function fonk.Kaydirici(yazi, min, max, varsayilan, geri)
        elemSay=elemSay+1
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(1, -10, 0, 36)
        frame.Position = UDim2.new(0, 5, 0, elemY)
        frame.BackgroundColor3 = C.BG3
        frame.BorderSizePixel = 0
        frame.Parent = section
        elemY = elemY + 40
        
        local lbl = Instance.new("TextLabel")
        lbl.Size = UDim2.new(1, -10, 0, 16)
        lbl.Position = UDim2.new(0, 10, 0, 2)
        lbl.BackgroundTransparency = 1
        lbl.Text = yazi .. ": " .. tostring(varsayilan)
        lbl.TextColor3 = C.TEXT
        lbl.Font = FONT2
        lbl.TextSize = 13
        lbl.TextXAlignment = Enum.TextXAlignment.Left
        lbl.Parent = frame
        
        local sliderBg = Instance.new("Frame")
        sliderBg.Size = UDim2.new(1, -20, 0, 5)
        sliderBg.Position = UDim2.new(0, 10, 0, 24)
        sliderBg.BackgroundColor3 = C.BG2
        sliderBg.BorderSizePixel = 0
        sliderBg.Parent = frame
        
        local sliderFill = Instance.new("Frame")
        sliderFill.Size = UDim2.new((varsayilan-min)/(max-min), 0, 1, 0)
        sliderFill.BackgroundColor3 = C.MOR
        sliderFill.BorderSizePixel = 0
        sliderFill.Parent = sliderBg
        
        local surukle = false
        local deger = varsayilan
        
        local dragBtn = Instance.new("TextButton")
        dragBtn.Size = UDim2.new(1, 0, 1, 0)
        dragBtn.BackgroundTransparency = 1
        dragBtn.Text = ""
        dragBtn.Parent = sliderBg
        
        dragBtn.MouseButton1Down:Connect(function() surukle = true end)
        UIS.InputEnded:Connect(function(i)
            if i.UserInputType==Enum.UserInputType.MouseButton1 then surukle=false end
        end)
        UIS.InputChanged:Connect(function(i)
            if surukle and i.UserInputType==Enum.UserInputType.MouseMovement then
                local pos=UIS:GetMouseLocation().X
                local absPos=sliderBg.AbsolutePosition.X
                local absSize=sliderBg.AbsoluteSize.X
                local ratio=math.clamp((pos-absPos)/absSize,0,1)
                deger=math.floor(min+(max-min)*ratio)
                sliderFill.Size=UDim2.new(ratio,0,1,0)
                lbl.Text=yazi..": "..tostring(deger)
                pcall(function() geri(deger) end)
            end
        end)
    end
    
    function fonk.Dropdown(yazi, secenekler, geri)
        elemSay=elemSay+1
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, -10, 0, 30)
        btn.Position = UDim2.new(0, 5, 0, elemY)
        btn.BackgroundColor3 = C.BG3
        btn.BorderSizePixel = 0
        btn.Text = yazi .. ": " .. (secenekler[1] or "")
        btn.TextColor3 = C.TEXT
        btn.Font = FONT2
        btn.TextSize = 12
        btn.Parent = section
        elemY = elemY + 34
        
        local sira = 1
        btn.MouseButton1Click:Connect(function()
            sira = sira + 1
            if sira > #secenekler then sira = 1 end
            btn.Text = yazi .. ": " .. secenekler[sira]
            pcall(function() geri(secenekler[sira]) end)
        end)
    end
    
    function fonk.OyuncuSec(yazi, renk, geri)
        -- Dropdown ile oyuncu seÃ§ + iÅŸlem
        elemSay=elemSay+1
        local secBtn = Instance.new("TextButton")
        secBtn.Size = UDim2.new(1, -10, 0, 28)
        secBtn.Position = UDim2.new(0, 5, 0, elemY)
        secBtn.BackgroundColor3 = C.BG3
        secBtn.BorderSizePixel = 0
        secBtn.Text = yazi .. ": [ Oyuncu Sec ]"
        secBtn.TextColor3 = renk or C.TEXT
        secBtn.Font = FONT2
        secBtn.TextSize = 12
        secBtn.Parent = section
        elemY = elemY + 32
        
        local seciliOyuncu = nil
        local oyuncuSirasi = 1
        
        local function OyuncuGuncelle()
            if #PL == 0 then
                secBtn.Text = yazi .. ": [ Oyuncu Yok ]"
                seciliOyuncu = nil
                return
            end
            if oyuncuSirasi > #PL then oyuncuSirasi = 1 end
            seciliOyuncu = PL[oyuncuSirasi]
            secBtn.Text = yazi .. ": " .. seciliOyuncu.Name
        end
        OyuncuGuncelle()
        
        secBtn.MouseButton1Click:Connect(function()
            oyuncuSirasi = oyuncuSirasi + 1
            OyuncuGuncelle()
        end)
        
        -- Ä°ÅŸlem butonu
        local islemBtn = Instance.new("TextButton")
        islemBtn.Size = UDim2.new(1, -10, 0, 26)
        islemBtn.Position = UDim2.new(0, 5, 0, elemY)
        islemBtn.BackgroundColor3 = renk or C.MOR
        islemBtn.BackgroundTransparency = 0.3
        islemBtn.BorderSizePixel = 0
        islemBtn.Text = "[ ISLEM YAP ]"
        islemBtn.TextColor3 = C.TEXT
        islemBtn.Font = FONT
        islemBtn.TextSize = 12
        islemBtn.Visible = false
        islemBtn.Parent = section
        
        -- AsÄ±l iÅŸlem butonu
        local actionBtn = Instance.new("TextButton")
        actionBtn.Size = UDim2.new(1, -10, 0, 28)
        actionBtn.Position = UDim2.new(0, 5, 0, elemY + 30)
        actionBtn.BackgroundColor3 = renk or C.MOR
        actionBtn.BackgroundTransparency = 0.2
        actionBtn.BorderSizePixel = 0
        actionBtn.Text = yazi
        actionBtn.TextColor3 = C.TEXT
        actionBtn.Font = FONT
        actionBtn.TextSize = 13
        actionBtn.Parent = section
        elemY = elemY + 63
        
        actionBtn.MouseEnter:Connect(function() actionBtn.BackgroundTransparency = 0 end)
        actionBtn.MouseLeave:Connect(function() actionBtn.BackgroundTransparency = 0.2 end)
        actionBtn.MouseButton1Click:Connect(function()
            if seciliOyuncu then
                pcall(function() geri(seciliOyuncu) end)
            else
                Nfy("Hata", "Oyuncu secilmedi")
            end
        end)
        
        -- Update player list regularly
        coroutine.wrap(function()
            while wait(2) do
                if #PL > 0 then
                    if not seciliOyuncu or not table.find(PL, seciliOyuncu) then
                        oyuncuSirasi = 1
                        OyuncuGuncelle()
                    end
                end
            end
        end)()
    end
    
    function fonk.Yazi(metin)
        elemSay=elemSay+1
        local lbl = Instance.new("TextLabel")
        lbl.Size = UDim2.new(1, -10, 0, 18)
        lbl.Position = UDim2.new(0, 5, 0, elemY)
        lbl.BackgroundTransparency = 1
        lbl.Text = metin
        lbl.TextColor3 = C.TEXT2
        lbl.Font = FONT2
        lbl.TextSize = 11
        lbl.TextXAlignment = Enum.TextXAlignment.Left
        lbl.Parent = section
        elemY = elemY + 21
    end
    
    return fonk
end

--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
--=  TOGGLE & OPTIONS
--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•

local T = {}
local H = {Boyut=3, Gizli=false, SadeceBaskalari=true}
local O = {WS=16, JP=50, FS=50, AR=20, AD=5, HS=3, SS=10}

--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
--=  LOOP'LAR
--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•

RS.Stepped:Connect(function()
    if T.Noclip and GC() then
        for _,p in pairs(GC():GetDescendants()) do if p:IsA("BasePart") then p.CanCollide=false end end
    end
end)

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
            bv.Velocity=md.Magnitude>0 and Camera.CFrame:VectorToObjectSpace(md).Unit*O.FS or Vector3.new(0,0,0)
            bg.CFrame=Camera.CFrame
        end
    end
    
    if T.Aimbot then
        local t=GCP()
        if t and t.Character and t.Character:FindFirstChild("Head") and THUM(t) and THUM(t).Health>0 then
            Camera.CFrame=CFrame.lookAt(Camera.CFrame.Position,t.Character.Head.Position)
        end
    end
    
    if T.SpinBot and HRP() then
        HRP().CFrame=HRP().CFrame*CFrame.Angles(0,math.rad(O.SS),0)
    end
end)

UIS.JumpRequest:Connect(function()
    if T.InfiniteJump and HUM() then HUM():ChangeState(Enum.HumanoidStateType.Jumping) end
end)

Mouse.Button1Down:Connect(function()
    if T.ClickTP and HRP() then HRP().CFrame=CFrame.new(Mouse.Hit.X,Mouse.Hit.Y+3,Mouse.Hit.Z) end
end)

-- Silent Aim hook
local SilentAimActive = false
local oldIndex = mt and mt.__index
if oldIndex then
    setreadonly(mt, false)
    mt.__index = function(self, key)
        if SilentAimActive and key == "CFrame" and self:IsA("Tool") then
            local t = GCP()
            if t and t.Character and t.Character:FindFirstChild("HumanoidRootPart") then
                return CFrame.lookAt(self.Position, t.Character.HumanoidRootPart.Position)
            end
        end
        return oldIndex(self, key)
    end
    setreadonly(mt, true)
end

--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
--=  TAB 1: PLAYER
--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•

local t1 = NewTab("Player", "P")
local s1 = NewSection(t1, "MODLAR")

s1.Toggle("God Mode", "Olmezsin - Health loop", function(s)
    T.GodMode=s
    if s then
        local h=HUM()
        if h then h.MaxHealth=9e9;h.Health=9e9;h.BreakJointsOnDeath=false end
        coroutine.wrap(function()
            while T.GodMode do wait(0.3)
                local h2=HUM();if h2 then
                    if h2.Health<1 then h2.Health=9e9 end
                    h2.MaxHealth=9e9;h2.BreakJointsOnDeath=false
                end
            end
        end)()
        Nfy("God Mode","Aktif")
    end
end)

s1.Toggle("Noclip", "Duvarlardan gec", function(s) T.Noclip=s end)

s1.Toggle("Fly", "Uc - Space=Yukari Shift=Asagi", function(s)
    T.Fly=s;local hrp=HRP()
    if not hrp then return end
    if s then
        local bv=Instance.new("BodyVelocity");bv.MaxForce=Vector3.new(1e9,1e9,1e9);bv.P=1e9;bv.Parent=hrp
        local bg=Instance.new("BodyGyro");bg.MaxTorque=Vector3.new(1e9,1e9,1e9);bg.P=1e9;bg.Parent=hrp
        if HUM() then HUM().PlatformStand=true end
    else
        for _,v in pairs(hrp:GetChildren()) do if v:IsA("BodyVelocity") or v:IsA("BodyGyro") then v:Destroy() end end
        if HUM() then HUM().PlatformStand=false end
    end
end)

s1.Toggle("Infinite Jump", "Havada tekrar ziplayabilirsin", function(s) T.InfiniteJump=s end)
s1.Toggle("B-Hop", "Kosarken otomatik zipla", function(s)
    T.BHop=s
    if s then coroutine.wrap(function() while T.BHop do wait(0.15) if HUM() and HUM().MoveDirection.Magnitude>0 then HUM():ChangeState(Enum.HumanoidStateType.Jumping) end end end)() end
end)
s1.Toggle("Spin Bot", "Kendi etrafinda don", function(s) T.SpinBot=s end)
s1.Toggle("Invisible", "Gorunmez ol", function(s)
    T.Invisible=s;local c=GC()
    if c then for _,p in pairs(c:GetDescendants()) do if p:IsA("BasePart") then p.Transparency=s and 1 or 0;p.CanCollide=not s end end end
end)
s1.Toggle("Float", "Havada asili kal", function(s)
    T.Float=s;local hrp=HRP()
    if hrp then
        if s then local bv=Instance.new("BodyVelocity");bv.MaxForce=Vector3.new(0,5000,0);bv.Parent=hrp
        else for _,v in pairs(hrp:GetChildren()) do if v:IsA("BodyVelocity") then v:Destroy() end end end
    end
end)

s1.Kaydirici("Walk Speed", 1, 500, 16, function(s) O.WS=s;if HUM() then HUM().WalkSpeed=s end end)
s1.Kaydirici("Jump Power", 1, 500, 50, function(s) O.JP=s;if HUM() then HUM().JumpPower=s end end)
s1.Kaydirici("Fly Speed", 1, 500, 50, function(s) O.FS=s end)

local s1b = NewSection(t1, "ANTI")
s1b.Toggle("Anti-Kick", "Atilamazsin - FE Hook", function(s) FE_AntiKick=s;InitFE();Nfy("Anti-Kick",s and "Aktif" or "Kapali") end)
s1b.Toggle("Anti-AFK", "AFKden atilmazsin", function(s)
    T.AntiAFK=s
    if s then coroutine.wrap(function() while T.AntiAFK do wait(45);VU:CaptureController();VU:ClickButton2(Vector2.new()) end end)() end
end)
s1b.Toggle("No Fall Damage", "Dusus hasari almazsin", function(s) T.NoFall=s;if HUM() then HUM().FallDamage=not s end end)
s1b.Toggle("Auto Heal", "Canin hep full kalsin", function(s)
    T.AutoHeal=s
    if s then coroutine.wrap(function() while T.AutoHeal do wait(1) if HUM() and HUM().Health<HUM().MaxHealth then HUM().Health=HUM().MaxHealth end end end)() end
end)
s1b.Buton("Reset Character", function() if GC() then GC():BreakJoints() end;wait(2);LP:LoadCharacter() end)

--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
--=  TAB 2: VISUAL
--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•

local t2 = NewTab("Visual", "V")
local s2 = NewSection(t2, "GORSEL")

local ESP_O={}
-- ESP icin renk modu ve cesitli ayarlar
local ESP_Renk = Color3.new(1,0,0) -- Kirmizi
local ESP_Rainbow = false
local ESP_Tracer = false

s2.Toggle("ESP", "Oyunculari isaretle (isim+mesafe)", function(s)
    T.ESP=s;ESP_Temizle()
    if s then
        for _,p in pairs(Players:GetPlayers()) do
            if p~=LP and p.Character then ESP_Ekle(p) end
        end
        Players.PlayerAdded:Connect(function(p)
            p.CharacterAdded:Connect(function() wait(1);if T.ESP and p~=LP then ESP_Ekle(p) end end)
        end)
        -- Surekli guncelle
        coroutine.wrap(function()
            while T.ESP do wait(0.3)
                if ESP_Rainbow then
                    ESP_Renk = Color3.fromHSV(tick()%5/5,1,0.8)
                    for _,p in pairs(Players:GetPlayers()) do
                        if p~=LP and p.Character then
                            for _,hl in pairs(p.Character:GetDescendants()) do
                                if hl:IsA("Highlight") then hl.FillColor=ESP_Renk end
                            end
                        end
                    end
                end
                -- Mesafe guncelle
                for _,p in pairs(Players:GetPlayers()) do
                    if p~=LP and p.Character then
                        for _,bbg in pairs(p.Character:GetDescendants()) do
                            if bbg:IsA("BillboardGui") and bbg:FindFirstChildOfClass("TextLabel") then
                                local d=(THRP(p) and HRP()) and math.floor((THRP(p).Position-HRP().Position).Magnitude) or 0
                                bbg.TextLabel.Text=p.Name.." ["..d.."m]"
                            end
                        end
                    end
                end
            end
        end)()
        Nfy("ESP","Aktif - Renkli isaretleme")
    end
end)

local function ESP_Ekle(p)
    if not p.Character then return end
    local hrp=THRP(p);local head=p.Character:FindFirstChild("Head") or hrp
    if not hrp or not head then return end
    -- Highlight
    local hl=Instance.new("Highlight",p.Character)
    hl.FillColor=ESP_Renk;hl.FillTransparency=0.35;hl.OutlineColor=Color3.new(1,1,1)
    table.insert(ESP_O,hl)
    -- Isim etiketi
    local bbg=Instance.new("BillboardGui",p.Character)
    bbg.Adornee=head;bbg.Size=UDim2.new(0,200,0,50);bbg.StudsOffset=Vector3.new(0,3,0)
    local tl=Instance.new("TextLabel",bbg)
    tl.Size=UDim2.new(1,0,1,0);tl.BackgroundTransparency=1;tl.Text=p.Name
    tl.TextStrokeTransparency=0.2;tl.TextColor3=ESP_Renk;tl.TextScaled=true;tl.Font=FONT
    table.insert(ESP_O,bbg)
    -- Tracer (cizgi)
    if ESP_Tracer then
        local line=Drawing.new("Line");line.Visible=true;line.Color=ESP_Renk;line.Thickness=1.5;line.Transparency=0.5
        table.insert(ESP_O,line)
        coroutine.wrap(function()
            while T.ESP and p.Character and hrp do
                RS.RenderStepped:Wait()
                local sp,os=Camera:WorldToScreenPoint(hrp.Position)
                if os then
                    line.From=Vector2.new(sp.X,sp.Y);line.To=Vector2.new(Camera.ViewportSize.X/2,Camera.ViewportSize.Y)
                else line.Visible=false end
            end
        end)()
    end
end

local function ESP_Temizle()
    for _,o in pairs(ESP_O) do pcall(function() o:Destroy() end);pcall(function() o.Visible=false end) end
    ESP_O={}
end

s2.Toggle("Rainbow ESP", "Surenk degistiren ESP", function(s) ESP_Rainbow=s end)
s2.Toggle("ESP Tracer", "Oyunculara cizgi ciz (cizgi esp)", function(s)
    ESP_Tracer=s
    if T.ESP then
        ESP_Temizle()
        for _,p in pairs(Players:GetPlayers()) do if p~=LP and p.Character then ESP_Ekle(p) end end
    end
end)
s2.Dropdown("ESP Rengi", {"Kirmizi","Mavi","Yesil","Sari","Mor","Turuncu","Pembe"}, function(secim)
    local renkler={Kirmizi=Color3.new(1,0,0),Mavi=Color3.new(0,0.4,1),Yesil=Color3.new(0,1,0),Sari=Color3.new(1,1,0),Mor=Color3.new(0.6,0.2,1),Turuncu=Color3.new(1,0.5,0),Pembe=Color3.new(1,0.4,0.7)}
    ESP_Renk=renkler[secim] or Color3.new(1,0,0)
    if T.ESP then
        ESP_Temizle()
        for _,p in pairs(Players:GetPlayers()) do if p~=LP and p.Character then ESP_Ekle(p) end end
    end
end)

s2.Toggle("Full Bright", "Geceyi gunduz yap", function(s)
    T.FB=s
    if s then Lighting.Ambient=Color3.new(1,1,1);Lighting.Brightness=3;Lighting.FogEnd=1e9;Lighting.ClockTime=12;Lighting.GlobalShadows=false
    else Lighting:SetGlobalLighting() end
end)
s2.Toggle("X-Ray", "Her sey seffaf", function(s) for _,o in pairs(workspace:GetDescendants()) do if o:IsA("BasePart") then o.Transparency=s and 0.7 or 0 end end end)
s2.Toggle("Wallhack", "Duvarlar gorunmez", function(s) for _,o in pairs(workspace:GetDescendants()) do if o:IsA("BasePart") and o.Anchored then o.Transparency=s and 0.7 or 0 end end end)
s2.Toggle("Highlight", "Vurgu (oyuncu cevresinde isik)", function(s)
    T.Highlight=s
    for _,p in pairs(Players:GetPlayers()) do if p~=LP and p.Character then
        if s then
            local hl=Instance.new("Highlight",p.Character);hl.FillColor=C.KIRMIZI;hl.FillTransparency=0.4;hl.OutlineColor=Color3.new(1,1,1)
            -- Rainbow efekt
            if s then coroutine.wrap(function()
                while T.Highlight and hl.Parent do
                    RS.RenderStepped:Wait()
                    hl.FillColor=Color3.fromHSV(tick()%3/3,1,0.7)
                end
            end)() end
        else
            for _,hl in pairs(p.Character:GetDescendants()) do if hl:IsA("Highlight") then hl:Destroy() end end
        end
    end end
end)

s2.Kaydirici("FOV", 20, 180, 70, function(s) Camera.FieldOfView=s end)
s2.Kaydirici("Gravity", 0, 500, 196, function(s) workspace.Gravity=s end)
s2.Kaydirici("Time", 0, 24, 12, function(s) Lighting.ClockTime=s end)

--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
--=  TAB 3: TELEPORT
--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•

local t3 = NewTab("Teleport", "T")
local s3 = NewSection(t3, "ISINLANMA")

s3.Toggle("Click TP", "Tikla gittigin yere isinlan", function(s) T.ClickTP=s end)
s3.OyuncuSec("TP Git", C.MOR, function(oyuncu)
    if oyuncu and THRP(oyuncu) and HRP() then HRP().CFrame=THRP(oyuncu).CFrame*CFrame.new(0,5,0) end
end)
s3.OyuncuSec("Getir", C.MAVI, function(oyuncu)
    if oyuncu and THRP(oyuncu) and HRP() then THRP(oyuncu).CFrame=HRP().CFrame*CFrame.new(0,0,3) end
end)
s3.Buton("Herkesi Getir", function()
    for _,p in pairs(Players:GetPlayers()) do if p~=LP and THRP(p) and HRP() then THRP(p).CFrame=HRP().CFrame*CFrame.new(0,0,3) end end
end)
s3.Buton("Spawna Git", function()
    if HRP() and workspace:FindFirstChild("SpawnLocation") then HRP().CFrame=workspace.SpawnLocation.CFrame*CFrame.new(0,3,0) end
end)
s3.Buton("Yukari +50", function() if HRP() then HRP().CFrame=HRP().CFrame*CFrame.new(0,50,0) end end)
s3.Buton("Asagi -50", function() if HRP() then HRP().CFrame=HRP().CFrame*CFrame.new(0,-50,0) end end)

--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
--=  TAB 4: COMBAT
--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•

local t4 = NewTab("Combat", "C")
local s4 = NewSection(t4, "SAVAS")

-- Aimbot icin Ek ayarlar
local Aimbot_FOV=90
local Aimbot_Smooth=0.3
local Aimbot_WallCheck=false

s4.Toggle("Aimbot", "En yakin oyuncuya otomatik nisan", function(s)
    T.Aimbot=s
    if s then Nfy("Aimbot","Aktif - FOV:"..Aimbot_FOV) end
end)

-- Aimbot Ana Loop (FOV ve Smooth ile)
coroutine.wrap(function()
    while wait() do
        if T.Aimbot then
            local t=GCP(Aimbot_FOV*3)
            if t and t.Character and t.Character:FindFirstChild("Head") and THUM(t) and THUM(t).Health>0 then
                -- Wall check
                if Aimbot_WallCheck then
                    local ray=Ray.new(Camera.CFrame.Position, t.Character.Head.Position-Camera.CFrame.Position)
                    local hit=workspace:FindPartOnRay(ray)
                    if hit then
                        local owner=hit:IsDescendantOf(t.Character)
                        if not owner then return end
                    end
                end
                Camera.CFrame=CFrame.lookAt(Camera.CFrame.Position,t.Character.Head.Position)
            end
        end
    end
end)()

s4.Kaydirici("Aimbot FOV", 10, 180, 90, function(s) Aimbot_FOV=s end)
s4.Toggle("Aimbot Wall Check", "Duvardan vurma", function(s) Aimbot_WallCheck=s end)

s4.Toggle("Silent Aim", "Vurmus gibi goster (FE - Metatable Hook)", function(s) SilentAimActive=s end)

-- Triggerbot icin hiz kontrolu
local Trigger_CPS=10
s4.Toggle("Triggerbot", "Hedef nisanga gelince otomatik tikla", function(s)
    T.Trig=s
    if s then coroutine.wrap(function()
        while T.Trig do
            RS.RenderStepped:Wait()
            local tgt=Mouse.Target
            if tgt then
                for _,p in pairs(Players:GetPlayers()) do
                    if p~=LP and p.Character and tgt:IsDescendantOf(p.Character) then
                        mouse1click()
                        wait(0.1/Trigger_CPS)
                    end
                end
            end
        end
    end)() end
end)
s4.Kaydirici("Trigger CPS", 1, 50, 10, function(s) Trigger_CPS=s end)

s4.Toggle("Damage Aura", "Yakindakilere otomatik hasar ver", function(s)
    T.DA=s
    if s then coroutine.wrap(function()
        while T.DA do
            wait(0.25)
            local say=0
            for _,tg in pairs(GPIR(O.AR)) do
                local th=THUM(tg)
                if th and th.Health>0 then
                    th.Health=th.Health-O.AD
                    say=say+1
                end
            end
            if say>0 then Nfy("Aura",say.." oyuncuya hasar verildi") end
        end
    end)() end
end)

-- Auto Click icin CPS kontrolu
local AutoClick_CPS=15
s4.Toggle("Auto Click", "Surekli otomatik tikla", function(s)
    T.AC=s
    if s then coroutine.wrap(function()
        while T.AC do
            mouse1click()
            wait(0.1/AutoClick_CPS)
        end
    end)() end
end)
s4.Kaydirici("Auto Click CPS", 1, 100, 15, function(s) AutoClick_CPS=s end)

s4.Kaydirici("Aura Range", 5, 100, 20, function(s) O.AR=s end)
s4.Kaydirici("Aura Damage", 1, 50, 5, function(s) O.AD=s end)
s4.Toggle("Hitbox Visible", "Hitboxlari gorunur yap", function(s) H.Gizli=not s;HitboxGuncelle() end)
s4.Toggle("Sadece Baskalari", "Kendine hitbox uygulama", function(s) H.SadeceBaskalari=s;HitboxGuncelle() end)
s4.Kaydirici("Hitbox Boyut", 1, 20, 3, function(s) H.Boyut=s;HitboxGuncelle() end)
s4.Buton("Hitbox Sifirla", "Herkesin hitboxini normale dondur", function()
    H.Boyut=3;H.Gizli=false
    for _,p in pairs(Players:GetPlayers()) do
        if p.Character then
            for _,part in pairs(p.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.Size = (part.Name=="Head") and Vector3.new(2,1,1) or Vector3.new(4,1,2)
                    part.Transparency=0
                    pcall(function() part.Material=Enum.Material.Plastic end)
                end
            end
        end
    end
    Nfy("Hitbox","Sifirlandi")
end)

-- Hitbox guncelleme fonksiyonu
local function HitboxGuncelle()
    for _,p in pairs(Players:GetPlayers()) do
        if p.Character and (not H.SadeceBaskalari or p~=LP) then
            for _,part in pairs(p.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.Transparency = H.Gizli and 1 or part.Transparency
                    -- Boyut uygula (Head farkli boyutlandirma)
                    if part.Name=="Head" then
                        part.Size=Vector3.new(H.Boyut*0.5, H.Boyut*0.5, H.Boyut*0.5)
                    else
                        part.Size=Vector3.new(H.Boyut, H.Boyut, H.Boyut)
                    end
                end
            end
        elseif p==LP and H.SadeceBaskalari and p.Character then
            -- Kendi hitboxini normale dondur
            for _,part in pairs(p.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.Size = (part.Name=="Head") and Vector3.new(2,1,1) or Vector3.new(4,1,2)
                end
            end
        end
    end
end

-- Aura ve Hitbox icin loop korumasi
coroutine.wrap(function()
    while wait(0.5) do
        if H.Boyut>3 then HitboxGuncelle() end
    end
end)()

--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
--=  TAB 5: ADMIN
--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•

local t5 = NewTab("Admin", "A")
local s5 = NewSection(t5, "FE YONETICI")

local FE_IslemSayisi=0

local function FKick(t)
    if not t then return end
    local c=t.Character
    if c then
        local h=c:FindFirstChildOfClass("Humanoid")
        if h then h.Health=0;h:BreakJoints() end;c:BreakJoints()
    end
    -- Remote event bulup kick dene
    for _,r in pairs(game:GetDescendants()) do
        if r:IsA("RemoteEvent") and (r.Name:lower():find("kick") or r.Name:lower():find("ban") or r.Name:lower():find("removeplayer")) then
            pcall(function() r:FireServer(t) end)
        end
    end
    FE_IslemSayisi=FE_IslemSayisi+1
end

local function FKill(t)
    if not t or not t.Character then return end
    local h=t.Character:FindFirstChildOfClass("Humanoid")
    if h then
        h.Health=0
        h:BreakJoints()
        -- Tum eklemleri kir
        for _,eklem in pairs(t.Character:GetDescendants()) do
            if eklem:IsA("JointInstance") then eklem:Destroy() end
        end
    end
    FE_IslemSayisi=FE_IslemSayisi+1
end

local function FJail(t, boyut)
    if not t or not THRP(t) then return end
    local pos=THRP(t).Position
    local b=boyut or 5
    -- Hapishane hucresi olustur
    for dx=-b,b,2 do
        for dz=-b,b,2 do
            if math.abs(dx)<=b-1 or math.abs(dz)<=b-1 then
                local p=Instance.new("Part");p.Size=Vector3.new(2,1,2);p.Position=pos+Vector3.new(dx,0,dz)
                p.Anchored=true;p.BrickColor=BrickColor.new("Bright red");p.Material=Enum.Material.SmoothPlastic;p.Parent=workspace;Debris:AddItem(p,120)
            end
        end
    end
    -- Tavan
    local tavan=Instance.new("Part");tavan.Size=Vector3.new(b*2+2,1,b*2+2);tavan.Position=pos+Vector3.new(0,8,0)
    tavan.Anchored=true;tavan.BrickColor=BrickColor.new("Bright red");tavan.Material=Enum.Material.Neon;tavan.Parent=workspace;Debris:AddItem(tavan,120)
    -- Taban
    local taban=Instance.new("Part");taban.Size=Vector3.new(b*2+2,1,b*2+2);taban.Position=pos+Vector3.new(0,-3,0)
    taban.Anchored=true;taban.BrickColor=BrickColor.new("Dark stone grey");taban.Parent=workspace;Debris:AddItem(taban,120)
    -- Ozel efekt: isiklandirma
    local spot=Instance.new("SpotLight",tavan);spot.Brightness=2;spot.Range=15;spot.Angle=180;spot.Color=Color3.new(1,0,0)
end

-- Oyuncu seÃ§meli kick/kill
s5.OyuncuSec("Kick (At)", C.KIRMIZI, function(oyuncu) if oyuncu then FKick(oyuncu);Nfy("KICK",oyuncu.Name) end end)
s5.OyuncuSec("Kill (Oldur)", C.KIRMIZI, function(oyuncu) if oyuncu then FKill(oyuncu);Nfy("KILL",oyuncu.Name) end end)
s5.OyuncuSec("Freeze (Dondur)", C.MAVI, function(oyuncu)
    if oyuncu and THRP(oyuncu) then
        local bp=Instance.new("BodyPosition");bp.Position=THRP(oyuncu).Position;bp.MaxForce=Vector3.new(1e9,1e9,1e9);bp.P=1e9;bp.Parent=THRP(oyuncu)
    end
end)
s5.OyuncuSec("Unfreeze (Coz)", C.MAVI, function(oyuncu)
    if oyuncu and THRP(oyuncu) then
        for _,v in pairs(THRP(oyuncu):GetChildren()) do if v:IsA("BodyPosition") then v:Destroy() end end
    end
end)
s5.OyuncuSec("Jail (Hapis)", C.TURUNCU, function(oyuncu)
    if oyuncu and THRP(oyuncu) then
        local pos=THRP(oyuncu).Position
        for dx=-5,5,2 do for dz=-5,5,2 do if math.abs(dx)<=4 or math.abs(dz)<=4 then
            local p=Instance.new("Part");p.Size=Vector3.new(2,1,2);p.Position=pos+Vector3.new(dx,0,dz);p.Anchored=true;p.BrickColor=BrickColor.new("Bright red");p.Parent=workspace;Debris:AddItem(p,60)
        end end end
        local c=Instance.new("Part");c.Size=Vector3.new(12,1,12);c.Position=pos+Vector3.new(0,6,0);c.Anchored=true;c.Parent=workspace;Debris:AddItem(c,60)
    end
end)
s5.OyuncuSec("Heal (Iyilestir)", C.YESIL, function(oyuncu) if oyuncu and THUM(oyuncu) then THUM(oyuncu).Health=THUM(oyuncu).MaxHealth end end)

s5.Buton("Kick All", function() for _,p in pairs(Players:GetPlayers()) do if p~=LP then FKick(p) end end end)
s5.Buton("Kill All", function() for _,p in pairs(Players:GetPlayers()) do if p~=LP then FKill(p) end end end)
s5.Buton("Freeze All", function()
    for _,p in pairs(Players:GetPlayers()) do if p~=LP and THRP(p) then local bp=Instance.new("BodyPosition");bp.Position=THRP(p).Position;bp.MaxForce=Vector3.new(1e9,1e9,1e9);bp.P=1e9;bp.Parent=THRP(p) end end
end)
s5.Buton("Unfreeze All", function()
    for _,p in pairs(Players:GetPlayers()) do if THRP(p) then for _,v in pairs(THRP(p):GetChildren()) do if v:IsA("BodyPosition") then v:Destroy() end end end end
end)
s5.Buton("Heal All", function() for _,p in pairs(Players:GetPlayers()) do if THUM(p) then THUM(p).Health=THUM(p).MaxHealth end end end)
s5.Buton("Lag", "Sunucuyu yavaslat", function()
    for i=1,1000 do
        local p=Instance.new("Part");p.Position=Vector3.new(math.random(-100,100),50,math.random(-100,100))
        p.Velocity=Vector3.new(math.random(-100,100),math.random(-100,100),math.random(-100,100));p.Parent=workspace;Debris:AddItem(p,10)
    end
end)

--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
--=  TAB 6: MISC
--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•

local t6 = NewTab("Misc", "M")
local s6 = NewSection(t6, "CESITLI")

s6.Buton("Rejoin", "Sunucuya yeniden katil", function() TS:Teleport(game.PlaceId,LP) end)
s6.Buton("Server Hop", "Farkli sunucu", function()
    local s,d=pcall(function() return HttpS:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?limit=100")) end)
    if s and d and d.data then for _,sv in pairs(d.data) do if sv.id~=game.JobId and sv.playing<sv.maxPlayers then TS:TeleportToPlaceInstance(game.PlaceId,sv.id,LP);return end end end
end)
s6.Buton("FPS Counter", function()
    local g=Instance.new("ScreenGui",CG);local l=Instance.new("TextLabel",g)
    l.Size=UDim2.new(0,100,0,30);l.Position=UDim2.new(0,10,0,10);l.BackgroundTransparency=0.5;l.BackgroundColor3=Color3.new(0,0,0)
    l.TextColor3=C.YESIL;l.Font=FONT;l.TextScaled=true
    coroutine.wrap(function() while g.Parent do RS.RenderStepped:Wait();l.Text="FPS: "..math.floor(1/RS.RenderStepped:Wait()) end end)()
end)
s6.Buton("Player List", function()
    local n={};for _,p in pairs(Players:GetPlayers()) do table.insert(n,p.Name..(p==LP and " (SEN)" or "")) end
    Nfy("Players ("..#Players:GetPlayers()..")",table.concat(n,", "))
end)

--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
--=  TAB 7: SETTINGS
--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•

local t7 = NewTab("Settings", "S")
local s7 = NewSection(t7, "KISAYOL TUSLARI")

s7.Yazi("LCtrl = Menu Ac/Kapa")
s7.Yazi("N = Noclip")
s7.Yazi("F = Fly")
s7.Yazi("Q = God Mode")
s7.Yazi("E = ESP")
s7.Yazi("G = Infinite Jump")
s7.Yazi("T = Click TP")
s7.Yazi("X = Speed Boost")
s7.Yazi("R = Reset Character")

local s7b = NewSection(t7, "VERSIYON & GUNCELLEME")
s7b.Yazi("MEGA ADMIN "..SCRIPT_VERSION.." â€” THOREL EDITION")
s7b.Yazi("Guncel surum kontrolu aktif")
s7b.Yazi("")
s7b.Yazi("Github: " .. GITHUB_PAGE)

--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
--=  KEYBINDLER
--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•

UIS.InputBegan:Connect(function(i)
    if i.KeyCode==Enum.KeyCode.LeftControl then GUI.Enabled=not GUI.Enabled
    elseif i.KeyCode==Enum.KeyCode.N then T.Noclip=not T.Noclip
    elseif i.KeyCode==Enum.KeyCode.F then
        T.Fly=not T.Fly;local hrp=HRP()
        if T.Fly and hrp then Instance.new("BodyVelocity",hrp).MaxForce=Vector3.new(1e9,1e9,1e9);Instance.new("BodyGyro",hrp).MaxTorque=Vector3.new(1e9,1e9,1e9)
        elseif hrp then for _,v in pairs(hrp:GetChildren()) do if v:IsA("BodyVelocity") or v:IsA("BodyGyro") then v:Destroy() end end end
    elseif i.KeyCode==Enum.KeyCode.Q then T.GodMode=not T.GodMode
    elseif i.KeyCode==Enum.KeyCode.E then T.ESP=not T.ESP
    elseif i.KeyCode==Enum.KeyCode.G then T.InfiniteJump=not T.InfiniteJump
    elseif i.KeyCode==Enum.KeyCode.T then T.ClickTP=not T.ClickTP
    elseif i.KeyCode==Enum.KeyCode.X then if HUM() then HUM().WalkSpeed=100;wait(5);HUM().WalkSpeed=O.WS end
    elseif i.KeyCode==Enum.KeyCode.R then if GC() then GC():BreakJoints() end;wait(2);LP:LoadCharacter()
    end
end)

--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
--=  START
--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•

-- Ä°lk tab'Ä± seÃ§
for i,t in pairs(Tabs) do
    if i==1 then
        t.btn.BackgroundColor3=C.MOR3;t.btn.TextColor3=C.TEXT;t.icerik.Visible=true
    else
        t.icerik.Visible=false
    end
end

Nfy("MEGA ADMIN "..SCRIPT_VERSION, "LCtrl=Menu | "..#PL.." oyuncu", 4)

print("â•”â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•—")
print("â•‘  MEGA ADMIN "..SCRIPT_VERSION.."              â•‘")
print("â•‘  THORELL EDITION                        â•‘")
print("â•‘  LCtrl = Menu | "..#PL.." players        â•‘")
print("â•šâ•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•")

InitFE()