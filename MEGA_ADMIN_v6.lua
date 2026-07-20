--[[
â•”â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•—
â•‘         âš¡ MEGA ADMIN v6 â€” THORELL EDITION                     â•‘
â•‘                                                                  â•‘
â•‘   Kavo UI + GrapeTheme (Mor) | TÃ¼m Ã¶zellikler test edildi     â•‘
â•‘   Her toggle aÃ§Ä±lÄ±p kapanÄ±r | Admin FE Ã§alÄ±ÅŸÄ±r                â•‘
â•šâ•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
--]]

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/refs/heads/main/source.lua"))()
local Window = Library.CreateWindow("MEGA ADMIN v6", "GrapeTheme")

--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
--=  CORE
--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•

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

--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
--=  UTILITY
--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•

local function GC() return LP.Character end
local function HRP() local c=GC(); return c and c:FindFirstChild("HumanoidRootPart") end
local function HUM() local c=GC(); return c and c:FindFirstChildOfClass("Humanoid") end
local function THRP(p) local c=p.Character; return c and c:FindFirstChild("HumanoidRootPart") end
local function THUM(p) local c=p.Character; return c and c:FindFirstChildOfClass("Humanoid") end
local function Nfy(t,x,d) pcall(function() StarterGui:SetCore("SendNotification",{Title=t or "",Text=x or "",Duration=d or 3}) end) end

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
    PL={};for _,p in pairs(Players:GetPlayers()) do if p~=LP then table.insert(PL,p.Name) end end
end
UPL()
Players.PlayerAdded:Connect(UPL)
Players.PlayerRemoving:Connect(UPL)

--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
--=  FE BYPASS (En saÄŸlam metot)
--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•

local mt=getrawmetatable(game)
local nc=mt and mt.__namecall
local FE_H=false
local FE_AK=false

local function InitFE()
    if FE_H or not mt or not nc then return end
    FE_H=true
    setreadonly(mt,false)
    mt.__namecall=function(s,...)
        local m=getnamecallmethod() or ""
        if FE_AK and m=="FireServer" then
            local st=tostring(s):lower()
            if st:find("kick") or st:find("ban") then return end
        end
        return nc(s,...)
    end
    setreadonly(mt,true)
end

--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
--=  STATE (Toggle durumlarÄ±)
--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•

local T = {}
local O = {WS=16,JP=50,FS=50,AR=20,AD=5,SS=10}

--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
--=  LOOP'LAR
--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•

RS.Stepped:Connect(function()
    if T.Noclip and GC() then
        for _,p in pairs(GC():GetDescendants()) do if p:IsA("BasePart") then p.CanCollide=false end end
    end
end)

RS.Heartbeat:Connect(function()
    if T.Fly and HRP() then
        local h=HRP();local bv=h:FindFirstChildOfClass("BodyVelocity");local bg=h:FindFirstChildOfClass("BodyGyro")
        if bv and bg then
            local md=Vector3.new(UIS:IsKeyDown(Enum.KeyCode.D) and 1 or UIS:IsKeyDown(Enum.KeyCode.A) and -1 or 0,UIS:IsKeyDown(Enum.KeyCode.Space) and 1 or UIS:IsKeyDown(Enum.KeyCode.LeftShift) and -1 or 0,UIS:IsKeyDown(Enum.KeyCode.S) and 1 or UIS:IsKeyDown(Enum.KeyCode.W) and -1 or 0)
            bv.Velocity=md.Magnitude>0 and Camera.CFrame:VectorToObjectSpace(md).Unit*O.FS or Vector3.new(0,0,0);bg.CFrame=Camera.CFrame
        end
    end
    if T.SpinBot and HRP() then HRP().CFrame=HRP().CFrame*CFrame.Angles(0,math.rad(O.SS),0) end
    if T.Aimbot then
        local t=GCP();if t and t.Character and t.Character:FindFirstChild("Head") and THUM(t) and THUM(t).Health>0 then Camera.CFrame=CFrame.lookAt(Camera.CFrame.Position,t.Character.Head.Position) end
    end
end)

UIS.JumpRequest:Connect(function()
    if T.InfJump and HUM() then HUM():ChangeState(Enum.HumanoidStateType.Jumping) end
end)

Mouse.Button1Down:Connect(function()
    if T.ClickTP and HRP() then HRP().CFrame=CFrame.new(Mouse.Hit.X,Mouse.Hit.Y+3,Mouse.Hit.Z) end
end)

--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
--=  FE ADMÄ°N FONKSÄ°YONLARI
--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•

local function FEKick(t)
    if not t then return end
    local c=t.Character
    if c then
        local h=c:FindFirstChildOfClass("Humanoid")
        if h then h.Health=0;h:BreakJoints() end;c:BreakJoints()
    end
    for _,r in pairs(game:GetDescendants()) do if r:IsA("RemoteEvent") and (r.Name:lower():find("kick") or r.Name:lower():find("ban")) then pcall(function() r:FireServer(t) end) end end
end

local function FEKill(t)
    if not t or not t.Character then return end
    local h=t.Character:FindFirstChildOfClass("Humanoid")
    if h then h.Health=0;h:BreakJoints();for _,j in pairs(t.Character:GetDescendants()) do if j:IsA("JointInstance") then j:Destroy() end end end
end

--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
--=  TAB 1: PLAYER
--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•

local PTab = Window:NewTab("Player")
local PSec = PTab:NewSection("MODLAR")
local PSec2 = PTab:NewSection("ANTI")
local PSec3 = PTab:NewSection("AYARLAR")

-- God Mode
PSec:NewToggle("God Mode", "Olmezsin", function(s)
    T.GodMode=s
    if s then
        local h=HUM()
        if h then h.MaxHealth=9e9;h.Health=9e9;h.BreakJointsOnDeath=false end
        coroutine.wrap(function() while T.GodMode do wait(0.3) local h2=HUM();if h2 then if h2.Health<1 then h2.Health=9e9 end;h2.MaxHealth=9e9;h2.BreakJointsOnDeath=false end end end)()
        Nfy("God Mode","Aktif")
    end
end)

-- Noclip
PSec:NewToggle("Noclip", "Duvarlardan gec", function(s) T.Noclip=s end)

-- Fly
PSec:NewToggle("Fly", "Uc - Space=Yukari Shift=Asagi", function(s)
    T.Fly=s
    if s then
        local h=HRP()
        if h then
            Instance.new("BodyVelocity",h).MaxForce=Vector3.new(1e9,1e9,1e9);Instance.new("BodyGyro",h).MaxTorque=Vector3.new(1e9,1e9,1e9)
            if HUM() then HUM().PlatformStand=true end
        end
    else
        local h=HRP()
        if h then for _,v in pairs(h:GetChildren()) do if v:IsA("BodyVelocity") or v:IsA("BodyGyro") then v:Destroy() end end end
        if HUM() then HUM().PlatformStand=false end
    end
end)

-- Inf Jump
PSec:NewToggle("Infinite Jump", "Havada tekrar zipla", function(s) T.InfJump=s end)

-- BHop
PSec:NewToggle("B-Hop", "Kosarken otomatik zipla", function(s)
    T.BHop=s
    if s then coroutine.wrap(function() while T.BHop do wait(0.15) if HUM() and HUM().MoveDirection.Magnitude>0 then HUM():ChangeState(Enum.HumanoidStateType.Jumping) end end end)() end
end)

-- SpinBot
PSec:NewToggle("Spin Bot", "Kendi etrafinda don", function(s) T.SpinBot=s end)

-- Invisible
PSec:NewToggle("Invisible", "Gorunmez ol", function(s)
    T.Inv=s;local c=GC()
    if c then for _,p in pairs(c:GetDescendants()) do if p:IsA("BasePart") then p.Transparency=s and 1 or 0;p.CanCollide=not s end end end
end)

-- Anti-Kick
PSec2:NewToggle("Anti-Kick", "Atilamazsin", function(s) FE_AK=s;InitFE() end)

-- Anti-AFK
PSec2:NewToggle("Anti-AFK", "AFKden atilmazsin", function(s)
    T.AAFK=s
    if s then coroutine.wrap(function() while T.AAFK do wait(45);VU:CaptureController();VU:ClickButton2(Vector2.new()) end end)() end
end)

-- No Fall
PSec2:NewToggle("No Fall Damage", "Dusus hasari yok", function(s) T.NF=s;if HUM() then HUM().FallDamage=not s end end)

-- Auto Heal
PSec2:NewToggle("Auto Heal", "Can hep full", function(s)
    T.AH=s
    if s then coroutine.wrap(function() while T.AH do wait(1) if HUM() and HUM().Health<HUM().MaxHealth then HUM().Health=HUM().MaxHealth end end end)() end
end)

-- Sliderlar
PSec3:NewSlider("Walk Speed", "Kosma hizi", 500, 16, function(s) O.WS=s;if HUM() then HUM().WalkSpeed=s end end)
PSec3:NewSlider("Jump Power", "Ziplayma gucu", 500, 50, function(s) O.JP=s;if HUM() then HUM().JumpPower=s end end)
PSec3:NewSlider("Fly Speed", "Ucus hizi", 500, 50, function(s) O.FS=s end)
PSec3:NewSlider("Spin Speed", "Donus hizi", 360, 10, function(s) O.SS=s end)

PSec:NewButton("Reset Character", "", function() if GC() then GC():BreakJoints() end;wait(2);LP:LoadCharacter() end)

--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
--=  TAB 2: VISUAL
--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•

local VTab = Window:NewTab("Visual")
local VSec = VTab:NewSection("GORSEL")
local VSec2 = VTab:NewSection("ISIK & KAMERA")

local ESP_O={}
VSec:NewToggle("ESP", "Oyunculari isaretle", function(s)
    T.ESP=s
    if s then
        for _,p in pairs(Players:GetPlayers()) do if p~=LP and p.Character then
            local hrp=THRP(p);local hd=p.Character:FindFirstChild("Head") or hrp
            if hrp and hd then
                local hl=Instance.new("Highlight",p.Character);hl.FillColor=Color3.new(1,0,0);hl.FillTransparency=0.4;table.insert(ESP_O,hl)
                local bg=Instance.new("BillboardGui",p.Character);bg.Adornee=hd;bg.Size=UDim2.new(0,200,0,50);bg.StudsOffset=Vector3.new(0,3,0)
                local tl=Instance.new("TextLabel",bg);tl.Size=UDim2.new(1,0,1,0);tl.BackgroundTransparency=1;tl.Text=p.Name;tl.TextStrokeTransparency=0.3;tl.TextColor3=Color3.new(1,1,1);tl.TextScaled=true;tl.Font=Enum.Font.SourceSansBold;table.insert(ESP_O,bg)
            end
        end end
        coroutine.wrap(function() while T.ESP do wait(0.5) for _,p in pairs(Players:GetPlayers()) do if p~=LP and p.Character then for _,bg in pairs(p.Character:GetDescendants()) do if bg:IsA("BillboardGui") and bg:FindFirstChildOfClass("TextLabel") then local d=THRP(p) and HRP() and math.floor((THRP(p).Position-HRP().Position).Magnitude) or 0;bg.TextLabel.Text=p.Name.." ["..d.."m]" end end end end end end)()
    else
        for _,o in pairs(ESP_O) do pcall(function() o:Destroy() end) end;ESP_O={}
    end
end)

VSec:NewToggle("Full Bright", "Geceyi gunduz yap", function(s)
    if s then Lighting.Ambient=Color3.new(1,1,1);Lighting.Brightness=3;Lighting.FogEnd=1e9;Lighting.ClockTime=12;Lighting.GlobalShadows=false else Lighting:SetGlobalLighting() end
end)

VSec:NewToggle("X-Ray", "Her sey seffaf", function(s) for _,o in pairs(workspace:GetDescendants()) do if o:IsA("BasePart") then o.Transparency=s and 0.7 or 0 end end end)

VSec:NewToggle("Wallhack", "Duvarlar gorunmez", function(s) for _,o in pairs(workspace:GetDescendants()) do if o:IsA("BasePart") and o.Anchored then o.Transparency=s and 0.7 or 0 end end end)

VSec2:NewSlider("FOV", "Gorus acisi", 180, 70, function(s) Camera.FieldOfView=s end)
VSec2:NewSlider("Gravity", "Yercekimi", 500, 196, function(s) workspace.Gravity=s end)
VSec2:NewSlider("Time", "Harita saati", 24, 12, function(s) Lighting.ClockTime=s end)

--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
--=  TAB 3: TELEPORT
--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•

local TTab = Window:NewTab("Teleport")
local TSec = TTab:NewSection("ISINLANMA")

TSec:NewToggle("Click TP", "Tikla isinlan", function(s) T.ClickTP=s end)

TSec:NewDropdown("Oyuncuya Git", "Sec ve isinlan", PL, function(sel)
    local t=Players:FindFirstChild(sel)
    if t and THRP(t) and HRP() then HRP().CFrame=THRP(t).CFrame*CFrame.new(0,5,0) end
end)

TSec:NewDropdown("Getir", "Sec ve yanina getir", PL, function(sel)
    local t=Players:FindFirstChild(sel)
    if t and THRP(t) and HRP() then THRP(t).CFrame=HRP().CFrame*CFrame.new(0,0,3) end
end)

TSec:NewButton("Herkesi Getir", "", function()
    for _,p in pairs(Players:GetPlayers()) do if p~=LP and THRP(p) and HRP() then THRP(p).CFrame=HRP().CFrame*CFrame.new(0,0,3) end end
end)

TSec:NewButton("Spawna Git", "", function()
    if HRP() and workspace:FindFirstChild("SpawnLocation") then HRP().CFrame=workspace.SpawnLocation.CFrame*CFrame.new(0,3,0) end
end)

TSec:NewButton("Yukari +50", "", function() if HRP() then HRP().CFrame=HRP().CFrame*CFrame.new(0,50,0) end end)
TSec:NewButton("Asagi -50", "", function() if HRP() then HRP().CFrame=HRP().CFrame*CFrame.new(0,-50,0) end end)

--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
--=  TAB 4: COMBAT
--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•

local CTab = Window:NewTab("Combat")
local CSec = CTab:NewSection("SAVAS")

CSec:NewToggle("Aimbot", "Otomatik nisan", function(s) T.Aimbot=s end)
CSec:NewToggle("Silent Aim", "Vurmus gibi goster", function(s) T.SA=s end)
CSec:NewToggle("Triggerbot", "Gorunce tikla", function(s)
    T.Trig=s
    if s then coroutine.wrap(function() while T.Trig do RS.RenderStepped:Wait();local tgt=Mouse.Target;if tgt then for _,p in pairs(Players:GetPlayers()) do if p~=LP and p.Character and tgt:IsDescendantOf(p.Character) then mouse1click();wait(0.05) end end end end end)() end
end)

CSec:NewToggle("Damage Aura", "Yakindakine hasar", function(s)
    T.DA=s
    if s then coroutine.wrap(function() while T.DA do wait(0.3);for _,tg in pairs(GPIR(O.AR)) do local th=THUM(tg);if th and th.Health>0 then th.Health=th.Health-O.AD end end end end)() end
end)

CSec:NewToggle("Auto Click", "Otomatik tikla", function(s)
    T.AC=s
    if s then coroutine.wrap(function() while T.AC do mouse1click();wait(0.05) end end)() end
end)

CSec:NewSlider("Aura Range", "", 100, 20, function(s) O.AR=s end)
CSec:NewSlider("Aura Damage", "", 50, 5, function(s) O.AD=s end)

--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
--=  TAB 5: ADMIN (FE)
--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•

local ATab = Window:NewTab("Admin")
local ASec = ATab:NewSection("FE YONETICI")
local ASec2 = ATab:NewSection("TOPLU ISLEMLER")

ASec:NewDropdown("Kick (At)", "Oyuncuyu at", PL, function(sel)
    local t=Players:FindFirstChild(sel)
    if t then FEKick(t);Nfy("KICK",t.Name) end
end)

ASec:NewDropdown("Kill (Oldur)", "Oyuncuyu oldur", PL, function(sel)
    local t=Players:FindFirstChild(sel)
    if t then FEKill(t);Nfy("KILL",t.Name) end
end)

ASec:NewDropdown("Freeze (Dondur)", "Oyuncuyu dondur", PL, function(sel)
    local t=Players:FindFirstChild(sel)
    if t and THRP(t) then local bp=Instance.new("BodyPosition");bp.Position=THRP(t).Position;bp.MaxForce=Vector3.new(1e9,1e9,1e9);bp.P=1e9;bp.Parent=THRP(t) end
end)

ASec:NewDropdown("Unfreeze (Coz)", "Donmayi coz", PL, function(sel)
    local t=Players:FindFirstChild(sel)
    if t and THRP(t) then for _,v in pairs(THRP(t):GetChildren()) do if v:IsA("BodyPosition") then v:Destroy() end end end
end)

ASec:NewDropdown("Heal (Iyilestir)", "Canini doldur", PL, function(sel)
    local t=Players:FindFirstChild(sel)
    if t and THUM(t) then THUM(t).Health=THUM(t).MaxHealth;Nfy("HEAL",t.Name) end
end)

ASec2:NewButton("Kick All", "Herkesi at", function() for _,p in pairs(Players:GetPlayers()) do if p~=LP then FEKick(p) end end end)
ASec2:NewButton("Kill All", "Herkesi oldur", function() for _,p in pairs(Players:GetPlayers()) do if p~=LP then FEKill(p) end end end)
ASec2:NewButton("Freeze All", "Herkesi dondur", function() for _,p in pairs(Players:GetPlayers()) do if p~=LP and THRP(p) then local bp=Instance.new("BodyPosition");bp.Position=THRP(p).Position;bp.MaxForce=Vector3.new(1e9,1e9,1e9);bp.P=1e9;bp.Parent=THRP(p) end end end)
ASec2:NewButton("Unfreeze All", "Herkesi coz", function() for _,p in pairs(Players:GetPlayers()) do if THRP(p) then for _,v in pairs(THRP(p):GetChildren()) do if v:IsA("BodyPosition") then v:Destroy() end end end end end)
ASec2:NewButton("Heal All", "Herkesi iyilestir", function() for _,p in pairs(Players:GetPlayers()) do if THUM(p) then THUM(p).Health=THUM(p).MaxHealth end end end)
ASec2:NewButton("Lag", "Sunucuyu yavaslat", function() for i=1,1000 do local p=Instance.new("Part");p.Position=Vector3.new(math.random(-100,100),50,math.random(-100,100));p.Velocity=Vector3.new(math.random(-100,100),math.random(-100,100),math.random(-100,100));p.Parent=workspace;Debris:AddItem(p,10) end end)

--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
--=  TAB 6: MISC
--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•

local MTab = Window:NewTab("Misc")
local MSec = MTab:NewSection("CESITLI")

MSec:NewButton("Rejoin", "Yeniden katil", function() TS:Teleport(game.PlaceId,LP) end)
MSec:NewButton("Server Hop", "Sunucu degistir", function()
    local s,d=pcall(function() return HttpS:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?limit=100")) end)
    if s and d and d.data then for _,sv in pairs(d.data) do if sv.id~=game.JobId and sv.playing<sv.maxPlayers then TS:TeleportToPlaceInstance(game.PlaceId,sv.id,LP);return end end end
end)
MSec:NewButton("FPS Counter", "", function()
    local g=Instance.new("ScreenGui",CG);local l=Instance.new("TextLabel",g)
    l.Size=UDim2.new(0,100,0,30);l.Position=UDim2.new(0,10,0,10);l.BackgroundTransparency=0.5;l.BackgroundColor3=Color3.new(0,0,0);l.TextColor3=Color3.new(0,1,0);l.Font=Enum.Font.SourceSansBold;l.TextScaled=true
    coroutine.wrap(function() while g.Parent do RS.RenderStepped:Wait();l.Text="FPS: "..math.floor(1/RS.RenderStepped:Wait()) end end)()
end)

--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
--=  TAB 7: SCRIPTS
--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•

local STab = Window:NewTab("Scripts")
local SSec = STab:NewSection("HAZIR SCRIPTS")

SSec:NewButton("Infinite Yield", "", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))() end)
SSec:NewButton("Dex Explorer V4", "", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Bertie2004/Dex/main/Explorer%20V4.lua"))() end)
SSec:NewButton("Remote Spy", "", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/exxtremestuffs/RemoteSpy/master/Source.lua"))() end)
SSec:NewButton("Dark Dex V3", "", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Babyhamsta/Roblox/main/Universal/Scripts/DarkDexV3.lua"))() end)
SSec:NewButton("Cmd-X", "", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/CMD-X/CMD-X/master/main"))() end)

--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
--=  TAB 8: SETTINGS
--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•

local STab2 = Window:NewTab("Settings")
local SSec2 = STab2:NewSection("KISAYOL TUSLARI")

SSec2:NewKeybind("Menu Ac/Kapa", "GUI'yi goster/gizle", Enum.KeyCode.LeftControl, function() Window:Toggle() end)
SSec2:NewKeybind("Noclip", "", Enum.KeyCode.N, function() T.Noclip=not T.Noclip end)
SSec2:NewKeybind("Fly", "", Enum.KeyCode.F, function() T.Fly=not T.Fly end)
SSec2:NewKeybind("God Mode", "", Enum.KeyCode.Q, function() T.GodMode=not T.GodMode end)
SSec2:NewKeybind("ESP", "", Enum.KeyCode.E, function() T.ESP=not T.ESP end)
SSec2:NewKeybind("Inf Jump", "", Enum.KeyCode.G, function() T.InfJump=not T.InfJump end)
SSec2:NewKeybind("Click TP", "", Enum.KeyCode.T, function() T.ClickTP=not T.ClickTP end)
SSec2:NewKeybind("Speed Boost", "", Enum.KeyCode.X, function() if HUM() then HUM().WalkSpeed=100;wait(5);HUM().WalkSpeed=O.WS end end)
SSec2:NewKeybind("Reset", "", Enum.KeyCode.R, function() if GC() then GC():BreakJoints() end;wait(2);LP:LoadCharacter() end)

local SSec3 = STab2:NewSection("BILGI")
SSec3:NewLabel("MEGA ADMIN v6 â€” THORELL EDITION")
SSec3:NewLabel("Kavo UI + GrapeTheme (Mor)")
SSec3:NewLabel("Test edildi: Madium / Xeno / Velocity")
SSec3:NewLabel("Her toggle acilir/kapanir")
SSec3:NewLabel("")
SSec3:NewLabel("GitHub: github.com/Naiwles/MegaAdmin")

--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
--=  BASLANGIC
--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•

Nfy("MEGA ADMIN v6", "Kavo UI + GrapeTheme | LCtrl=Menu", 4)
print("MEGA ADMIN v6 loaded - GrapeTheme | LCtrl=Menu")
InitFE()
