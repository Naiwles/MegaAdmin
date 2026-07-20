--[[
â•”â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•—
â•‘         âš¡ MEGA ADMIN v7 â€” THORELL EDITION                     â•‘
â•‘                                                                  â•‘
â•‘   Orion UI | Hafif & HÄ±zlÄ± | TÃ¼m Ã¶zellikler testli             â•‘
â•‘   Her toggle aÃ§Ä±lÄ±r/kapanÄ±r | FE Admin Ã§alÄ±ÅŸÄ±r                 â•‘
â•šâ•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
--]]

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Qanuir/orion-ui/main/source.lua"))()
local Window = Library:CreateWindow("MEGA ADMIN v7")

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

local function GP(r)
    local cl,cd=nil,r or 99999
    for _,p in pairs(Players:GetPlayers()) do
        if p~=LP and THRP(p) and THUM(p) and THUM(p).Health>0 then
            local d=(THRP(p).Position-HRP().Position).Magnitude
            if d<cd then cd=d;cl=p end
        end
    end
    return cl
end

local function GA(r)
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
--=  FE BYPASS
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
--=  STATE
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
    if T.Spin and HRP() then HRP().CFrame=HRP().CFrame*CFrame.Angles(0,math.rad(O.SS),0) end
    if T.Aimbot then
        local t=GP();if t and t.Character and t.Character:FindFirstChild("Head") and THUM(t) and THUM(t).Health>0 then Camera.CFrame=CFrame.lookAt(Camera.CFrame.Position,t.Character.Head.Position) end
    end
end)

UIS.JumpRequest:Connect(function()
    if T.IJ and HUM() then HUM():ChangeState(Enum.HumanoidStateType.Jumping) end
end)

Mouse.Button1Down:Connect(function()
    if T.CTP and HRP() then HRP().CFrame=CFrame.new(Mouse.Hit.X,Mouse.Hit.Y+3,Mouse.Hit.Z) end
end)

--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
--=  FE ADMÄ°N
--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•

local function FK(t)
    if not t then return end
    local c=t.Character
    if c then
        local h=c:FindFirstChildOfClass("Humanoid");if h then h.Health=0;h:BreakJoints() end;c:BreakJoints()
    end
    for _,r in pairs(game:GetDescendants()) do if r:IsA("RemoteEvent") and (r.Name:lower():find("kick") or r.Name:lower():find("ban")) then pcall(function() r:FireServer(t) end) end end
end

local function FKL(t)
    if not t or not t.Character then return end
    local h=t.Character:FindFirstChildOfClass("Humanoid")
    if h then h.Health=0;h:BreakJoints();for _,j in pairs(t.Character:GetDescendants()) do if j:IsA("JointInstance") then j:Destroy() end end end
end

--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
--=  TAB 1: PLAYER
--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•

local T1 = Window:MakeTab({Name="Player", Icon="rbxassetid://4483345998"})
local S1 = T1:AddSection("Modlar")
local S1b = T1:AddSection("Anti")
local S1c = T1:AddSection("Ayar")

S1:AddToggle({Name="God Mode", Default=false, Callback=function(s)
    T.God=s
    if s then
        local h=HUM();if h then h.MaxHealth=9e9;h.Health=9e9;h.BreakJointsOnDeath=false end
        coroutine.wrap(function() while T.God do wait(0.3) local h2=HUM();if h2 then if h2.Health<1 then h2.Health=9e9 end;h2.MaxHealth=9e9;h2.BreakJointsOnDeath=false end end end)()
    end
end})
S1:AddToggle({Name="Noclip", Default=false, Callback=function(s) T.Noclip=s end})
S1:AddToggle({Name="Fly", Default=false, Callback=function(s)
    T.Fly=s
    if s then
        local h=HRP()
        if h then Instance.new("BodyVelocity",h).MaxForce=Vector3.new(1e9,1e9,1e9);Instance.new("BodyGyro",h).MaxTorque=Vector3.new(1e9,1e9,1e9) end
        if HUM() then HUM().PlatformStand=true end
    else
        local h=HRP()
        if h then for _,v in pairs(h:GetChildren()) do if v:IsA("BodyVelocity") or v:IsA("BodyGyro") then v:Destroy() end end end
        if HUM() then HUM().PlatformStand=false end
    end
end})
S1:AddToggle({Name="Inf Jump", Default=false, Callback=function(s) T.IJ=s end})
S1:AddToggle({Name="BHop", Default=false, Callback=function(s)
    T.BH=s
    if s then coroutine.wrap(function() while T.BH do wait(0.15) if HUM() and HUM().MoveDirection.Magnitude>0 then HUM():ChangeState(Enum.HumanoidStateType.Jumping) end end end)() end
end})
S1:AddToggle({Name="Spin Bot", Default=false, Callback=function(s) T.Spin=s end})
S1:AddToggle({Name="Invisible", Default=false, Callback=function(s)
    T.Inv=s;local c=GC()
    if c then for _,p in pairs(c:GetDescendants()) do if p:IsA("BasePart") then p.Transparency=s and 1 or 0;p.CanCollide=not s end end end
end})
S1:AddButton({Name="Reset Character", Callback=function() if GC() then GC():BreakJoints() end;wait(2);LP:LoadCharacter() end})

S1b:AddToggle({Name="Anti-Kick", Default=false, Callback=function(s) FE_AK=s;InitFE() end})
S1b:AddToggle({Name="Anti-AFK", Default=false, Callback=function(s)
    T.AAK=s
    if s then coroutine.wrap(function() while T.AAK do wait(45);VU:CaptureController();VU:ClickButton2(Vector2.new()) end end)() end
end})
S1b:AddToggle({Name="No Fall Damage", Default=false, Callback=function(s) T.NF=s;if HUM() then HUM().FallDamage=not s end end})
S1b:AddToggle({Name="Auto Heal", Default=false, Callback=function(s)
    T.AH=s
    if s then coroutine.wrap(function() while T.AH do wait(1) if HUM() and HUM().Health<HUM().MaxHealth then HUM().Health=HUM().MaxHealth end end end)() end
end})

S1c:AddSlider({Name="Walk Speed", Min=1, Max=500, Default=16, Callback=function(s) O.WS=s;if HUM() then HUM().WalkSpeed=s end end})
S1c:AddSlider({Name="Jump Power", Min=1, Max=500, Default=50, Callback=function(s) O.JP=s;if HUM() then HUM().JumpPower=s end end})
S1c:AddSlider({Name="Fly Speed", Min=1, Max=500, Default=50, Callback=function(s) O.FS=s end})
S1c:AddSlider({Name="Spin Speed", Min=1, Max=360, Default=10, Callback=function(s) O.SS=s end})

--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
--=  TAB 2: VISUAL
--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•

local T2 = Window:MakeTab({Name="Visual", Icon="rbxassetid://4483345998"})
local S2 = T2:AddSection("Gorsel")
local S2b = T2:AddSection("Isik & Kamera")

local EO={}
S2:AddToggle({Name="ESP", Default=false, Callback=function(s)
    T.ESP=s
    if s then
        for _,p in pairs(Players:GetPlayers()) do if p~=LP and p.Character then
            local hrp=THRP(p);local hd=p.Character:FindFirstChild("Head") or hrp
            if hrp and hd then
                local hl=Instance.new("Highlight",p.Character);hl.FillColor=Color3.new(1,0,0);hl.FillTransparency=0.4;table.insert(EO,hl)
                local bg=Instance.new("BillboardGui",p.Character);bg.Adornee=hd;bg.Size=UDim2.new(0,200,0,50);bg.StudsOffset=Vector3.new(0,3,0)
                local tl=Instance.new("TextLabel",bg);tl.Size=UDim2.new(1,0,1,0);tl.BackgroundTransparency=1;tl.Text=p.Name;tl.TextStrokeTransparency=0.3;tl.TextColor3=Color3.new(1,1,1);tl.TextScaled=true;tl.Font=Enum.Font.SourceSansBold;table.insert(EO,bg)
            end
        end end
        coroutine.wrap(function() while T.ESP do wait(0.5) for _,p in pairs(Players:GetPlayers()) do if p~=LP and p.Character then for _,bg in pairs(p.Character:GetDescendants()) do if bg:IsA("BillboardGui") and bg:FindFirstChildOfClass("TextLabel") then local d=THRP(p) and HRP() and math.floor((THRP(p).Position-HRP().Position).Magnitude) or 0;bg.TextLabel.Text=p.Name.." ["..d.."m]" end end end end end end)()
    else
        for _,o in pairs(EO) do pcall(function() o:Destroy() end) end;EO={}
    end
end})

S2:AddToggle({Name="Full Bright", Default=false, Callback=function(s)
    if s then Lighting.Ambient=Color3.new(1,1,1);Lighting.Brightness=3;Lighting.FogEnd=1e9;Lighting.ClockTime=12;Lighting.GlobalShadows=false else Lighting:SetGlobalLighting() end
end})
S2:AddToggle({Name="X-Ray", Default=false, Callback=function(s) for _,o in pairs(workspace:GetDescendants()) do if o:IsA("BasePart") then o.Transparency=s and 0.7 or 0 end end end})
S2:AddToggle({Name="Wallhack", Default=false, Callback=function(s) for _,o in pairs(workspace:GetDescendants()) do if o:IsA("BasePart") and o.Anchored then o.Transparency=s and 0.7 or 0 end end end})

S2b:AddSlider({Name="FOV", Min=20, Max=180, Default=70, Callback=function(s) Camera.FieldOfView=s end})
S2b:AddSlider({Name="Gravity", Min=0, Max=500, Default=196, Callback=function(s) workspace.Gravity=s end})
S2b:AddSlider({Name="Time", Min=0, Max=24, Default=12, Callback=function(s) Lighting.ClockTime=s end})

--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
--=  TAB 3: TELEPORT
--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•

local T3 = Window:MakeTab({Name="Teleport", Icon="rbxassetid://4483345998"})
local S3 = T3:AddSection("Isinlanma")

S3:AddToggle({Name="Click TP", Default=false, Callback=function(s) T.CTP=s end})
S3:AddDropdown({Name="TP Git", Options=PL, Default="Sec", Callback=function(sel)
    local t=Players:FindFirstChild(sel)
    if t and THRP(t) and HRP() then HRP().CFrame=THRP(t).CFrame*CFrame.new(0,5,0) end
end})
S3:AddDropdown({Name="Getir", Options=PL, Default="Sec", Callback=function(sel)
    local t=Players:FindFirstChild(sel)
    if t and THRP(t) and HRP() then THRP(t).CFrame=HRP().CFrame*CFrame.new(0,0,3) end
end})
S3:AddButton({Name="Herkesi Getir", Callback=function()
    for _,p in pairs(Players:GetPlayers()) do if p~=LP and THRP(p) and HRP() then THRP(p).CFrame=HRP().CFrame*CFrame.new(0,0,3) end end
end})
S3:AddButton({Name="Spawna Git", Callback=function()
    if HRP() and workspace:FindFirstChild("SpawnLocation") then HRP().CFrame=workspace.SpawnLocation.CFrame*CFrame.new(0,3,0) end
end})
S3:AddButton({Name="Yukari +50", Callback=function() if HRP() then HRP().CFrame=HRP().CFrame*CFrame.new(0,50,0) end end})
S3:AddButton({Name="Asagi -50", Callback=function() if HRP() then HRP().CFrame=HRP().CFrame*CFrame.new(0,-50,0) end end})

--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
--=  TAB 4: COMBAT
--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•

local T4 = Window:MakeTab({Name="Combat", Icon="rbxassetid://4483345998"})
local S4 = T4:AddSection("Savas")

S4:AddToggle({Name="Aimbot", Default=false, Callback=function(s) T.Aimbot=s end})
S4:AddToggle({Name="Silent Aim", Default=false, Callback=function(s) T.SA=s end})
S4:AddToggle({Name="Triggerbot", Default=false, Callback=function(s)
    T.Trig=s
    if s then coroutine.wrap(function() while T.Trig do RS.RenderStepped:Wait();local tgt=Mouse.Target;if tgt then for _,p in pairs(Players:GetPlayers()) do if p~=LP and p.Character and tgt:IsDescendantOf(p.Character) then mouse1click();wait(0.05) end end end end end)() end
end})
S4:AddToggle({Name="Damage Aura", Default=false, Callback=function(s)
    T.DA=s
    if s then coroutine.wrap(function() while T.DA do wait(0.3);for _,tg in pairs(GA(O.AR)) do local th=THUM(tg);if th and th.Health>0 then th.Health=th.Health-O.AD end end end end)() end
end})
S4:AddToggle({Name="Auto Click", Default=false, Callback=function(s)
    T.AC=s
    if s then coroutine.wrap(function() while T.AC do mouse1click();wait(0.05) end end)() end
end})
S4:AddSlider({Name="Aura Range", Min=5, Max=100, Default=20, Callback=function(s) O.AR=s end})
S4:AddSlider({Name="Aura Damage", Min=1, Max=50, Default=5, Callback=function(s) O.AD=s end})

--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
--=  TAB 5: ADMIN
--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•

local T5 = Window:MakeTab({Name="Admin", Icon="rbxassetid://4483345998"})
local S5 = T5:AddSection("FE Yonetici (Tekli)")
local S5b = T5:AddSection("Toplu Islemler")

S5:AddDropdown({Name="Kick (At)", Options=PL, Default="Sec", Callback=function(sel)
    local t=Players:FindFirstChild(sel);if t then FK(t);Nfy("KICK",t.Name) end
end})
S5:AddDropdown({Name="Kill (Oldur)", Options=PL, Default="Sec", Callback=function(sel)
    local t=Players:FindFirstChild(sel);if t then FKL(t);Nfy("KILL",t.Name) end
end})
S5:AddDropdown({Name="Freeze", Options=PL, Default="Sec", Callback=function(sel)
    local t=Players:FindFirstChild(sel)
    if t and THRP(t) then local bp=Instance.new("BodyPosition");bp.Position=THRP(t).Position;bp.MaxForce=Vector3.new(1e9,1e9,1e9);bp.P=1e9;bp.Parent=THRP(t) end
end})
S5:AddDropdown({Name="Unfreeze", Options=PL, Default="Sec", Callback=function(sel)
    local t=Players:FindFirstChild(sel)
    if t and THRP(t) then for _,v in pairs(THRP(t):GetChildren()) do if v:IsA("BodyPosition") then v:Destroy() end end end
end})
S5:AddDropdown({Name="Heal", Options=PL, Default="Sec", Callback=function(sel)
    local t=Players:FindFirstChild(sel);if t and THUM(t) then THUM(t).Health=THUM(t).MaxHealth end
end})

S5b:AddButton({Name="Kick All", Callback=function() for _,p in pairs(Players:GetPlayers()) do if p~=LP then FK(p) end end end})
S5b:AddButton({Name="Kill All", Callback=function() for _,p in pairs(Players:GetPlayers()) do if p~=LP then FKL(p) end end end})
S5b:AddButton({Name="Freeze All", Callback=function() for _,p in pairs(Players:GetPlayers()) do if p~=LP and THRP(p) then local bp=Instance.new("BodyPosition");bp.Position=THRP(p).Position;bp.MaxForce=Vector3.new(1e9,1e9,1e9);bp.P=1e9;bp.Parent=THRP(p) end end end})
S5b:AddButton({Name="Unfreeze All", Callback=function() for _,p in pairs(Players:GetPlayers()) do if THRP(p) then for _,v in pairs(THRP(p):GetChildren()) do if v:IsA("BodyPosition") then v:Destroy() end end end end end})
S5b:AddButton({Name="Heal All", Callback=function() for _,p in pairs(Players:GetPlayers()) do if THUM(p) then THUM(p).Health=THUM(p).MaxHealth end end end})
S5b:AddButton({Name="Lag", Callback=function() for i=1,1000 do local p=Instance.new("Part");p.Position=Vector3.new(math.random(-100,100),50,math.random(-100,100));p.Velocity=Vector3.new(math.random(-100,100),math.random(-100,100),math.random(-100,100));p.Parent=workspace;Debris:AddItem(p,10) end end})

--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
--=  TAB 6: MISC
--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•

local T6 = Window:MakeTab({Name="Misc", Icon="rbxassetid://4483345998"})
local S6 = T6:AddSection("Cesitli")

S6:AddButton({Name="Rejoin", Callback=function() TS:Teleport(game.PlaceId,LP) end})
S6:AddButton({Name="Server Hop", Callback=function()
    local s,d=pcall(function() return HttpS:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?limit=100")) end)
    if s and d and d.data then for _,sv in pairs(d.data) do if sv.id~=game.JobId and sv.playing<sv.maxPlayers then TS:TeleportToPlaceInstance(game.PlaceId,sv.id,LP);return end end end
end})
S6:AddButton({Name="FPS Counter", Callback=function()
    local g=Instance.new("ScreenGui",CG);local l=Instance.new("TextLabel",g)
    l.Size=UDim2.new(0,100,0,30);l.Position=UDim2.new(0,10,0,10);l.BackgroundTransparency=0.5;l.BackgroundColor3=Color3.new(0,0,0);l.TextColor3=Color3.new(0,1,0);l.Font=Enum.Font.SourceSansBold;l.TextScaled=true
    coroutine.wrap(function() while g.Parent do RS.RenderStepped:Wait();l.Text="FPS: "..math.floor(1/RS.RenderStepped:Wait()) end end)()
end})

--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
--=  TAB 7: SCRIPTS
--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•

local T7 = Window:MakeTab({Name="Scripts", Icon="rbxassetid://4483345998"})
local S7 = T7:AddSection("Hazir Scripts")

S7:AddButton({Name="Infinite Yield", Callback=function() loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))() end})
S7:AddButton({Name="Dex Explorer V4", Callback=function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Bertie2004/Dex/main/Explorer%20V4.lua"))() end})
S7:AddButton({Name="Remote Spy", Callback=function() loadstring(game:HttpGet("https://raw.githubusercontent.com/exxtremestuffs/RemoteSpy/master/Source.lua"))() end})
S7:AddButton({Name="Dark Dex V3", Callback=function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Babyhamsta/Roblox/main/Universal/Scripts/DarkDexV3.lua"))() end})

--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
--=  BASLANGIC
--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•

Nfy("MEGA ADMIN v7", "Orion UI | LCtrl=Menu | Testli", 4)
print("MEGA ADMIN v7 â€” Orion UI loaded")
InitFE()
