--[[
â•”â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•—
â•‘         âš¡ MEGA ADMIN v3.1 â€” THORELL EDITION                   â•‘
â•‘                                                                  â•‘
â•‘   Modern Mor-Siyah Tema | Ã‡alÄ±ÅŸan Script | Tek Method          â•‘
â•‘   Madium âœ“ Xeno âœ“ Velocity âœ“                                   â•‘
â•šâ•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
--]]

-- GÃ¼venli yÃ¼kleme
local succ, Library = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/refs/heads/main/source.lua"))()
end)

if not succ or not Library then
    -- Yedek link
    succ, Library = pcall(function()
        return loadstring(game:HttpGet("https://raw.githubusercontent.com/CRYPTICALL/Kavo-UI-Library/main/source.lua"))()
    end)
end

if not succ or not Library then
    game.StarterGui:SetCore("SendNotification", {Title="âŒ HATA", Text="Kavo UI yÃ¼klenemedi! Ä°nternet baÄŸlantÄ±nÄ± kontrol et.", Duration=5})
    return
end

local Window = Library.CreateWindow("âš¡ MEGA ADMIN v3.1", "GrapeTheme")

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

--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
--=  UTILITY (KÄ±sa fonksiyonlar)
--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•

local function GC() return LP.Character end
local function GP() return LP end
local function HRP() local c=GC(); return c and c:FindFirstChild("HumanoidRootPart") end
local function HUM() local c=GC(); return c and c:FindFirstChildOfClass("Humanoid") end
local function THRP(p) local c=p.Character; return c and c:FindFirstChild("HumanoidRootPart") end
local function THUM(p) local c=p.Character; return c and c:FindFirstChildOfClass("Humanoid") end
local function Nfy(t,x,d) pcall(function() game.StarterGui:SetCore("SendNotification",{Title=t or "",Text=x or "",Duration=d or 3}) end) end

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

--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
--=  FE BYPASS (Metatable Hook â€” En SaÄŸlam)
--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•

local mt=getrawmetatable(game)
local __namecall=mt.__namecall
local FE_Hooked=false
local FE_AntiKick=false
local FE_AntiTools=false

local function InitFE()
    if FE_Hooked then return end
    FE_Hooked=true
    setreadonly(mt,false)
    mt.__namecall=function(self,...)
        local m=getnamecallmethod() or ""
        if FE_AntiKick and m=="FireServer" then
            local s=tostring(self):lower()
            if s:find("kick") or s:find("ban") or s:find("remove") then return end
        end
        if FE_AntiTools and m=="FireServer" and tostring(self):lower():find("tool") then return end
        return __namecall(self,...)
    end
    setreadonly(mt,true)
end

--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
--=  TOGGLE & OPTIONS
--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•

local T={}
local O={WalkSpeed=16,JumpPower=50,FlySpeed=50,AuraRange=20,AuraDamage=5,HitboxSize=3,SpinSpeed=10}

--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
--=  TAB 1: PLAYER
--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•

local T1=Window:NewTab("ğŸ® Player")
local S1=T1:NewSection("â€”â€” MODLAR â€”â€”")

-- GOD MODE
S1:NewToggle("God Mode", "Ã–lmezsin â€” Health loop korumasÄ±", function(s)
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

-- NOCLIP
S1:NewToggle("Noclip", "DuvarlarÄ±n iÃ§inden yÃ¼rÃ¼", function(s)
    T.Noclip=s
    Nfy("Noclip",s and "âœ… Aktif" or "KapalÄ±")
end)

RS.Stepped:Connect(function()
    if T.Noclip and GC() then
        for _,p in pairs(GC():GetDescendants()) do
            if p:IsA("BasePart") then p.CanCollide=false end
        end
    end
end)

-- FLY
S1:NewToggle("Fly", "UÃ§ â€” Space=YukarÄ± Shift=AÅŸaÄŸÄ±", function(s)
    T.Fly=s
    local hrp=HRP()
    if not hrp then return end
    if s then
        local bv=Instance.new("BodyVelocity");bv.MaxForce=Vector3.new(1e9,1e9,1e9);bv.P=1e9;bv.Parent=hrp
        local bg=Instance.new("BodyGyro");bg.MaxTorque=Vector3.new(1e9,1e9,1e9);bg.P=1e9;bg.Parent=hrp
        local h=HUM();if h then h.PlatformStand=true end
    else
        for _,v in pairs(hrp:GetChildren()) do if v:IsA("BodyVelocity") or v:IsA("BodyGyro") then v:Destroy() end end
        local h=HUM();if h then h.PlatformStand=false end
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
            bv.Velocity=md.Magnitude>0 and Camera.CFrame:VectorToObjectSpace(md).Unit*O.FlySpeed or Vector3.new(0,0,0)
            bg.CFrame=Camera.CFrame
        end
    end
end)

-- INFINITE JUMP
S1:NewToggle("Infinite Jump", "Havada tekrar zÄ±pla", function(s)
    T.InfiniteJump=s
    Nfy("Inf Jump",s and "âœ…" or "KapalÄ±")
end)

UIS.JumpRequest:Connect(function()
    if T.InfiniteJump and HUM() then HUM():ChangeState(Enum.HumanoidStateType.Jumping) end
end)

-- BHOP
S1:NewToggle("B-Hop", "KoÅŸarken otomatik zÄ±pla", function(s)
    T.BHop=s
    if s then
        coroutine.wrap(function()
            while T.BHop do
                wait(0.15)
                if HUM() and HUM().MoveDirection.Magnitude>0 then HUM():ChangeState(Enum.HumanoidStateType.Jumping) end
            end
        end)()
    end
end)

-- SPIN BOT
S1:NewToggle("Spin Bot", "Kendi etrafÄ±nda dÃ¶n", function(s)
    T.SpinBot=s
    if s then
        coroutine.wrap(function()
            while T.SpinBot do
                RS.RenderStepped:Wait()
                if HRP() then HRP().CFrame=HRP().CFrame*CFrame.Angles(0,math.rad(O.SpinSpeed),0) end
            end
        end)()
    end
end)

-- INVISIBLE
S1:NewToggle("Invisible", "GÃ¶rÃ¼nmez ol", function(s)
    T.Invisible=s
    local c=GC()
    if c then
        for _,p in pairs(c:GetDescendants()) do
            if p:IsA("BasePart") then p.Transparency=s and 1 or 0;p.CanCollide=not s end
        end
    end
end)

-- Sliderlar
S1:NewSlider("Walk Speed", "KoÅŸma hÄ±zÄ±", 500, 16, function(s) O.WalkSpeed=s;if HUM() then HUM().WalkSpeed=s end end)
S1:NewSlider("Jump Power", "ZÄ±plama gÃ¼cÃ¼", 500, 50, function(s) O.JumpPower=s;if HUM() then HUM().JumpPower=s end end)
S1:NewSlider("Fly Speed", "UÃ§uÅŸ hÄ±zÄ±", 500, 50, function(s) O.FlySpeed=s end)
S1:NewSlider("Spin Speed", "DÃ¶nÃ¼ÅŸ hÄ±zÄ±", 360, 10, function(s) O.SpinSpeed=s end)

-- ANTI
local S1b=T1:NewSection("â€”â€” ANTI â€”â€”")

S1b:NewToggle("Anti-Kick", "AtÄ±lamazsÄ±n â€” FE Hook", function(s)
    FE_AntiKick=s;InitFE();Nfy("Anti-Kick",s and "âœ…" or "KapalÄ±")
end)

S1b:NewToggle("Anti-AFK", "AFK'den atÄ±lmazsÄ±n", function(s)
    T.AntiAFK=s
    if s then
        coroutine.wrap(function()
            while T.AntiAFK do wait(45);VU:CaptureController();VU:ClickButton2(Vector2.new()) end
        end)()
    end
end)

S1b:NewToggle("No Fall Damage", "DÃ¼ÅŸÃ¼ÅŸ hasarÄ± yok", function(s)
    T.NoFall=s;if HUM() then HUM().FallDamage=not s end
end)

S1b:NewToggle("Auto Heal", "CanÄ±n hep full", function(s)
    T.AutoHeal=s
    if s then
        coroutine.wrap(function()
            while T.AutoHeal do
                wait(1)
                if HUM() and HUM().Health<HUM().MaxHealth then HUM().Health=HUM().MaxHealth end
            end
        end)()
    end
end)

S1:NewButton("Reset Character", "Karakteri sÄ±fÄ±rla", function()
    if GC() then GC():BreakJoints() end;wait(2);LP:LoadCharacter()
end)

--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
--=  TAB 2: VISUAL
--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•

local T2=Window:NewTab("ğŸ‘ï¸ Visual")
local S2=T2:NewSection("â€”â€” GÃ–RSEL â€”â€”")

local ESP_Objects={}
S2:NewToggle("ESP", "OyuncularÄ± duvar arkasÄ±ndan gÃ¶r", function(s)
    T.ESP=s
    if s then
        for _,p in pairs(Players:GetPlayers()) do
            if p~=LP and p.Character then
                local hrp=THRP(p)
                local head=p.Character:FindFirstChild("Head") or hrp
                if hrp and head then
                    local hl=Instance.new("Highlight",p.Character)
                    hl.FillColor=Color3.new(1,0,0);hl.FillTransparency=0.5
                    table.insert(ESP_Objects,hl)
                    local bbg=Instance.new("BillboardGui",p.Character)
                    bbg.Adornee=head;bbg.Size=UDim2.new(0,200,0,50);bbg.StudsOffset=Vector3.new(0,3,0)
                    local tl=Instance.new("TextLabel",bbg)
                    tl.Size=UDim2.new(1,0,1,0);tl.BackgroundTransparency=1
                    tl.Text=p.Name;tl.TextStrokeTransparency=0.3;tl.TextColor3=Color3.new(1,1,1)
                    tl.TextScaled=true;tl.Font=Enum.Font.SourceSansBold
                    table.insert(ESP_Objects,bbg)
                end
            end
        end
        coroutine.wrap(function()
            while T.ESP do
                wait(0.5)
                for _,p in pairs(Players:GetPlayers()) do
                    if p~=LP and p.Character then
                        for _,bbg in pairs(p.Character:GetDescendants()) do
                            if bbg:IsA("BillboardGui") and bbg:FindFirstChildOfClass("TextLabel") then
                                local d=THRP(p) and HRP() and math.floor((THRP(p).Position-HRP().Position).Magnitude) or 0
                                bbg.TextLabel.Text=p.Name.." ["..d.."m]"
                            end
                        end
                    end
                end
            end
        end)()
    else
        for _,o in pairs(ESP_Objects) do pcall(function() o:Destroy() end) end;ESP_Objects={}
        for _,p in pairs(Players:GetPlayers()) do
            if p.Character then
                for _,c in pairs(p.Character:GetDescendants()) do
                    if c:IsA("BillboardGui") or c:IsA("Highlight") then pcall(function() c:Destroy() end) end
                end
            end
        end
    end
end)

S2:NewToggle("Full Bright", "Geceyi gÃ¼ndÃ¼z yap", function(s)
    T.FullBright=s
    if s then
        Lighting.Ambient=Color3.new(1,1,1);Lighting.Brightness=3;Lighting.FogEnd=1e9
        Lighting.ClockTime=12;Lighting.GlobalShadows=false
    else Lighting:SetGlobalLighting() end
end)

S2:NewToggle("X-Ray", "Her ÅŸey ÅŸeffaf", function(s)
    T.XRay=s
    for _,o in pairs(workspace:GetDescendants()) do if o:IsA("BasePart") then o.Transparency=s and 0.7 or 0 end end
end)

S2:NewToggle("Wallhack", "Duvarlar gÃ¶rÃ¼nmez", function(s)
    T.Wallhack=s
    for _,o in pairs(workspace:GetDescendants()) do if o:IsA("BasePart") and o.Anchored then o.Transparency=s and 0.7 or 0 end end
end)

S2:NewToggle("Highlight", "KÄ±rmÄ±zÄ± vurgu", function(s)
    for _,p in pairs(Players:GetPlayers()) do
        if p~=LP and p.Character then
            if s then
                local hl=Instance.new("Highlight",p.Character)
                hl.FillColor=Color3.new(1,0,0);hl.FillTransparency=0.5
            else
                for _,hl in pairs(p.Character:GetDescendants()) do if hl:IsA("Highlight") then hl:Destroy() end end
            end
        end
    end
end)

S2:NewSlider("FOV", "Kamera gÃ¶rÃ¼ÅŸ aÃ§Ä±sÄ±", 180, 70, function(s) Camera.FieldOfView=s end)
S2:NewSlider("Gravity", "YerÃ§ekimi", 500, 196, function(s) workspace.Gravity=s end)
S2:NewSlider("Time", "Harita saati", 24, 12, function(s) Lighting.ClockTime=s end)

--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
--=  TAB 3: TELEPORT
--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•

local T3=Window:NewTab("ğŸ“ Teleport")
local S3=T3:NewSection("â€”â€” IÅINLANMA â€”â€”")

S3:NewToggle("Click TP", "TÄ±kla gittiÄŸin yere Ä±ÅŸÄ±nlan", function(s) T.ClickTP=s end)

Mouse.Button1Down:Connect(function()
    if T.ClickTP and HRP() then HRP().CFrame=CFrame.new(Mouse.Hit.X,Mouse.Hit.Y+3,Mouse.Hit.Z) end
end)

S3:NewDropdown("Oyuncuya Git", "SeÃ§ + Ä±ÅŸÄ±nlan", PL, function(sel)
    local t=Players:FindFirstChild(sel)
    if t and THRP(t) and HRP() then HRP().CFrame=THRP(t).CFrame*CFrame.new(0,5,0) end
end)

S3:NewDropdown("Getir (Bring)", "SeÃ§ + getir", PL, function(sel)
    local t=Players:FindFirstChild(sel)
    if t and THRP(t) and HRP() then THRP(t).CFrame=HRP().CFrame*CFrame.new(0,0,3) end
end)

S3:NewButton("Herkesi Getir", "", function()
    for _,p in pairs(Players:GetPlayers()) do
        if p~=LP and THRP(p) and HRP() then THRP(p).CFrame=HRP().CFrame*CFrame.new(0,0,3) end
    end
end)

S3:NewButton("Spawn'a Git", "", function()
    if HRP() and workspace:FindFirstChild("SpawnLocation") then HRP().CFrame=workspace.SpawnLocation.CFrame*CFrame.new(0,3,0) end
end)

S3:NewButton("YukarÄ± (+50)", "", function() if HRP() then HRP().CFrame=HRP().CFrame*CFrame.new(0,50,0) end end)
S3:NewButton("AÅŸaÄŸÄ± (-50)", "", function() if HRP() then HRP().CFrame=HRP().CFrame*CFrame.new(0,-50,0) end end)

--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
--=  TAB 4: COMBAT
--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•

local T4=Window:NewTab("âš”ï¸ Combat")
local S4=T4:NewSection("â€”â€” SAVAÅ â€”â€”")

S4:NewToggle("Aimbot", "En yakÄ±n oyuncuya otomatik niÅŸan", function(s)
    T.Aimbot=s
    if s then
        coroutine.wrap(function()
            while T.Aimbot do
                RS.RenderStepped:Wait()
                local t=GCP()
                if t and t.Character and t.Character:FindFirstChild("Head") and THUM(t) and THUM(t).Health>0 then
                    Camera.CFrame=CFrame.lookAt(Camera.CFrame.Position,t.Character.Head.Position)
                end
            end
        end)()
    end
end)

S4:NewToggle("Triggerbot", "Hedef niÅŸangahta tÄ±kla", function(s)
    T.Triggerbot=s
    if s then
        coroutine.wrap(function()
            while T.Triggerbot do
                RS.RenderStepped:Wait()
                local tgt=Mouse.Target
                if tgt then
                    for _,p in pairs(Players:GetPlayers()) do
                        if p~=LP and p.Character and tgt:IsDescendantOf(p.Character) then mouse1click();wait(0.05) end
                    end
                end
            end
        end)()
    end
end)

S4:NewToggle("Damage Aura", "YakÄ±ndakilere hasar ver", function(s)
    T.DamageAura=s
    if s then
        coroutine.wrap(function()
            while T.DamageAura do
                wait(0.3)
                for _,target in pairs(GPIR(O.AuraRange)) do
                    local th=THUM(target)
                    if th and th.Health>0 then th.Health=th.Health-O.AuraDamage end
                end
            end
        end)()
    end
end)

S4:NewToggle("Auto Click", "SÃ¼rekli otomatik tÄ±kla", function(s)
    T.AutoClick=s
    if s then coroutine.wrap(function() while T.AutoClick do mouse1click();wait(0.05) end end)() end
end)

S4:NewSlider("Aura Range", "Aura menzili", 100, 20, function(s) O.AuraRange=s end)
S4:NewSlider("Aura Damage", "Aura hasarÄ±", 50, 5, function(s) O.AuraDamage=s end)

S4:NewSlider("Hitbox Size", "Hitbox geniÅŸliÄŸi", 20, 3, function(s)
    O.HitboxSize=s
    for _,p in pairs(Players:GetPlayers()) do
        if p~=LP and p.Character then
            for _,part in pairs(p.Character:GetDescendants()) do
                if part:IsA("BasePart") then part.Size=Vector3.new(s,s,s) end
            end
        end
    end
end)

--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
--=  TAB 5: ADMIN
--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•

local T5=Window:NewTab("ğŸ‘‘ Admin")
local S5=T5:NewSection("â€”â€” FE YÃ–NETÄ°CÄ° â€”â€”")

local function FEKick(t)
    if not t then return end
    local c=t.Character
    if c then
        local h=c:FindFirstChildOfClass("Humanoid")
        if h then h.Health=0;h:BreakJoints() end
        c:BreakJoints()
    end
    for _,r in pairs(game:GetDescendants()) do
        if r:IsA("RemoteEvent") and r.Name:lower():find("kick") then
            pcall(function() r:FireServer(t) end)
        end
    end
end

local function FEKill(t)
    if not t or not t.Character then return end
    local h=t.Character:FindFirstChildOfClass("Humanoid")
    if h then h.Health=0;h:BreakJoints() end
end

S5:NewDropdown("Kick (At)", "FE Kick", PL, function(sel)
    local t=Players:FindFirstChild(sel)
    if t then FEKick(t);Nfy("KICK",t.Name) end
end)

S5:NewButton("Kick All", "Herkesi at", function()
    for _,p in pairs(Players:GetPlayers()) do if p~=LP then FEKick(p) end end
end)

S5:NewDropdown("Kill (Ã–ldÃ¼r)", "FE Kill", PL, function(sel)
    local t=Players:FindFirstChild(sel)
    if t then FEKill(t);Nfy("KILL",t.Name) end
end)

S5:NewButton("Kill All", "Herkesi Ã¶ldÃ¼r", function()
    for _,p in pairs(Players:GetPlayers()) do if p~=LP then FEKill(p) end end
end)

S5:NewDropdown("Freeze", "Dondur", PL, function(sel)
    local t=Players:FindFirstChild(sel)
    if t and THRP(t) then
        local bp=Instance.new("BodyPosition");bp.Position=THRP(t).Position
        bp.MaxForce=Vector3.new(1e9,1e9,1e9);bp.P=1e9;bp.Parent=THRP(t)
    end
end)

S5:NewButton("Freeze All", "", function()
    for _,p in pairs(Players:GetPlayers()) do
        if p~=LP and THRP(p) then
            local bp=Instance.new("BodyPosition");bp.Position=THRP(p).Position
            bp.MaxForce=Vector3.new(1e9,1e9,1e9);bp.P=1e9;bp.Parent=THRP(p)
        end
    end
end)

S5:NewDropdown("Unfreeze", "Ã‡Ã¶z", PL, function(sel)
    local t=Players:FindFirstChild(sel)
    if t and THRP(t) then
        for _,v in pairs(THRP(t):GetChildren()) do if v:IsA("BodyPosition") then v:Destroy() end end
    end
end)

S5:NewButton("Unfreeze All", "", function()
    for _,p in pairs(Players:GetPlayers()) do
        if THRP(p) then
            for _,v in pairs(THRP(p):GetChildren()) do if v:IsA("BodyPosition") then v:Destroy() end end
        end
    end
end)

S5:NewDropdown("Jail (Hapis)", "Kafesle", PL, function(sel)
    local t=Players:FindFirstChild(sel)
    if t and THRP(t) then
        local pos=THRP(t).Position
        for dx=-5,5,2 do for dz=-5,5,2 do
            if math.abs(dx)<=4 or math.abs(dz)<=4 then
                local p=Instance.new("Part");p.Size=Vector3.new(2,1,2);p.Position=pos+Vector3.new(dx,0,dz)
                p.Anchored=true;p.BrickColor=BrickColor.new("Bright red");p.Parent=workspace
                Debris:AddItem(p,60)
            end
        end end
        local c=Instance.new("Part");c.Size=Vector3.new(12,1,12);c.Position=pos+Vector3.new(0,6,0)
        c.Anchored=true;c.Parent=workspace;Debris:AddItem(c,60)
    end
end)

S5:NewDropdown("Heal", "Ä°yileÅŸtir", PL, function(sel)
    local t=Players:FindFirstChild(sel)
    if t and THUM(t) then THUM(t).Health=THUM(t).MaxHealth end
end)

S5:NewButton("Heal All", "Herkesi iyileÅŸtir", function()
    for _,p in pairs(Players:GetPlayers()) do if THUM(p) then THUM(p).Health=THUM(p).MaxHealth end end
end)

S5:NewButton("Lag", "Sunucuyu yavaÅŸlat", function()
    for i=1,1000 do
        local p=Instance.new("Part");p.Position=Vector3.new(math.random(-100,100),50,math.random(-100,100))
        p.Velocity=Vector3.new(math.random(-100,100),math.random(-100,100),math.random(-100,100));p.Parent=workspace
        Debris:AddItem(p,10)
    end
end)

--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
--=  TAB 6: SCRIPTS
--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•

local T6=Window:NewTab("ğŸ“œ Scripts")
local S6=T6:NewSection("â€”â€” HAZIR SCRIPTS â€”â€”")

local scriptList={
    {"Infinite Yield","EdgeIY/infiniteyield/master/source"},
    {"Dex Explorer V4","Bertie2004/Dex/main/Explorer%20V4.lua"},
    {"Remote Spy","exxtremestuffs/RemoteSpy/master/Source.lua"},
    {"Cmd-X","CMD-X/CMD-X/master/main"},
    {"Dark Dex V3","Babyhamsta/Roblox/main/Universal/Scripts/DarkDexV3.lua"},
    {"Chat Spoofer","Babyhamsta/Roblox/main/Universal/Scripts/ChatSpoofer.lua"},
}

for _,s in pairs(scriptList) do
    S6:NewButton(s[1], "Tek tÄ±kla Ã§alÄ±ÅŸtÄ±r", function()
        pcall(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/"..s[2]))() end)
    end)
end

--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
--=  TAB 7: MISC
--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•

local T7=Window:NewTab("ğŸ”§ Misc")
local S7=T7:NewSection("â€”â€” Ã‡EÅÄ°TLÄ° â€”â€”")

S7:NewButton("Rejoin", "Sunucuya yeniden katÄ±l", function()
    TS:Teleport(game.PlaceId,LP)
end)

S7:NewButton("Server Hop", "FarklÄ± sunucuya geÃ§", function()
    local s,d=pcall(function() return HttpS:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?limit=100")) end)
    if s and d and d.data then
        for _,sv in pairs(d.data) do
            if sv.id~=game.JobId and sv.playing<sv.maxPlayers then
                TS:TeleportToPlaceInstance(game.PlaceId,sv.id,LP);return
            end
        end
    end
end)

S7:NewButton("FPS Counter", "FPS sayacÄ± gÃ¶ster", function()
    local g=Instance.new("ScreenGui",CG)
    local l=Instance.new("TextLabel",g)
    l.Size=UDim2.new(0,100,0,30);l.Position=UDim2.new(0,10,0,10)
    l.BackgroundTransparency=0.5;l.BackgroundColor3=Color3.new(0,0,0)
    l.TextColor3=Color3.new(0,1,0);l.Font=Enum.Font.SourceSansBold;l.TextScaled=true
    coroutine.wrap(function() while g.Parent do RS.RenderStepped:Wait();l.Text="FPS: "..math.floor(1/RS.RenderStepped:Wait()) end end)()
end)

S7:NewButton("Player List", "Oyuncu listesi", function()
    local names={}
    for _,p in pairs(Players:GetPlayers()) do table.insert(names,p.Name) end
    Nfy("Players ("..#Players:GetPlayers()..")",table.concat(names,", "))
end)

--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
--=  TAB 8: SETTINGS
--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•

local T8=Window:NewTab("âš™ï¸ Settings")
local S8=T8:NewSection("â€”â€” TEMA â€”â€”")

S8:NewDropdown("Tema DeÄŸiÅŸtir", "MenÃ¼ temasÄ±", {"DarkTheme","LightTheme","GrapeTheme","OceanTheme","BloodTheme"}, function(sel)
    Library:Destroy()
    Window=Library.CreateWindow("âš¡ MEGA ADMIN v3.1",sel)
    Nfy("Tema",sel.." seÃ§ildi. Tekrar Ã§alÄ±ÅŸtÄ±rman gerekebilir.")
end)

local S8b=T8:NewSection("â€”â€” KISAYOL TUÅLARI â€”â€”")

S8b:NewKeybind("GUI AÃ§/Kapa", "", Enum.KeyCode.LeftControl, function() Window:Toggle() end)
S8b:NewKeybind("Noclip", "", Enum.KeyCode.N, function() T.Noclip=not T.Noclip end)
S8b:NewKeybind("Fly", "", Enum.KeyCode.F, function()
    T.Fly=not T.Fly
    local hrp=HRP()
    if T.Fly and hrp then
        Instance.new("BodyVelocity",hrp).MaxForce=Vector3.new(1e9,1e9,1e9)
        Instance.new("BodyGyro",hrp).MaxTorque=Vector3.new(1e9,1e9,1e9)
    elseif hrp then
        for _,v in pairs(hrp:GetChildren()) do if v:IsA("BodyVelocity") or v:IsA("BodyGyro") then v:Destroy() end end
    end
end)
S8b:NewKeybind("God Mode", "", Enum.KeyCode.Q, function() T.GodMode=not T.GodMode end)
S8b:NewKeybind("ESP", "", Enum.KeyCode.E, function() T.ESP=not T.ESP end)
S8b:NewKeybind("Inf Jump", "", Enum.KeyCode.G, function() T.InfiniteJump=not T.InfiniteJump end)
S8b:NewKeybind("Click TP", "", Enum.KeyCode.T, function() T.ClickTP=not T.ClickTP end)
S8b:NewKeybind("Speed Boost", "", Enum.KeyCode.X, function()
    if HUM() then HUM().WalkSpeed=100;wait(5);HUM().WalkSpeed=O.WalkSpeed end
end)
S8b:NewKeybind("Reset", "", Enum.KeyCode.R, function()
    if GC() then GC():BreakJoints() end;wait(2);LP:LoadCharacter()
end)

local S8c=T8:NewSection("â€”â€” BÄ°LGÄ° â€”â€”")

S8c:NewLabel("âš¡ MEGA ADMIN v3.1 â€” THORELL EDITION")
S8c:NewLabel("ğŸ’œ Mor-Siyah GrapeTheme")
S8c:NewLabel("ğŸ“Œ Her Ã¶zellikte EN Ä°YÄ° FE method")
S8c:NewLabel("ğŸ§ª Test: Madium âœ“ Xeno âœ“ Velocity âœ“")
S8c:NewLabel("")
S8c:NewLabel("âš ï¸ Byfron oyunlarÄ± iÃ§in executor bypass gerek")
S8c:NewLabel("")
S8c:NewLabel("KÄ±sayollar:")
S8c:NewLabel("  LCtrl=GUI | N=Noclip | F=Fly | Q=God")
S8c:NewLabel("  E=ESP | G=InfJump | T=ClickTP")
S8c:NewLabel("  X=Speed | R=Reset")
S8c:NewLabel("")
S8c:NewLabel("ğŸ‘¤ Owner: THORELL")

--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
--=  BAÅLANGIÃ‡
--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•

Nfy("âš¡ MEGA ADMIN v3.1","YÃ¼klendi! LCtrl=GUI | "..#PL.." oyuncu",5)

print("â•”â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•—")
print("â•‘  âš¡ MEGA ADMIN v3.1                     â•‘")
print("â•‘  ğŸ’œ GrapeTheme | Her ÅŸey Ã§alÄ±ÅŸÄ±yor     â•‘")
print("â•‘  ğŸ“Œ LCtrl = GUI aÃ§/kapa                â•‘")
print("â•šâ•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•")

InitFE()
