-- MEGA ADMIN FINAL â€” THORELL EDITION
-- SÄ±fÄ±rdan yazÄ±ldÄ±, 0 external loading, her executor'da Ã§alÄ±ÅŸÄ±r

local Players=game:GetService("Players")
local LP=Players.LocalPlayer
local Mouse=LP:GetMouse()
local Camera=workspace.CurrentCamera
local RS=game:GetService("RunService")
local UIS=game:GetService("UserInputService")
local VU=game:GetService("VirtualUser")
local TS=game:GetService("TeleportService")
local Lighting=game:GetService("Lighting")
local CG=game:GetService("CoreGui")
local HttpS=game:GetService("HttpService")
local Debris=game:GetService("Debris")

-- UTILITY
local function GC() return LP.Character end
local function HRP() local c=GC();return c and c:FindFirstChild("HumanoidRootPart") end
local function HUM() local c=GC();return c and c:FindFirstChildOfClass("Humanoid") end
local function THRP(p) local c=p.Character;return c and c:FindFirstChild("HumanoidRootPart") end
local function THUM(p) local c=p.Character;return c and c:FindFirstChildOfClass("Humanoid") end
local function Nfy(t,x,d) pcall(function() game:GetService("StarterGui"):SetCore("SendNotification",{Title=t or "",Text=x or "",Duration=d or 3}) end) end

local function GCP()
    local cl,cd=nil,99999
    for _,p in pairs(Players:GetPlayers()) do
        if p~=LP and THRP(p) and THUM(p) and THUM(p).Health>0 then
            local d=(THRP(p).Position-HRP().Position).Magnitude
            if d<cd then cd=d;cl=p end
        end
    end
    return cl
end

local PL={}
local function UPL() PL={};for _,p in pairs(Players:GetPlayers()) do if p~=LP then table.insert(PL,p.Name) end end end
UPL();Players.PlayerAdded:Connect(UPL);Players.PlayerRemoving:Connect(UPL)

-- FE BYPASS
local mt=getrawmetatable(game)
local nc=mt and mt.__namecall
local FE_H=false;local FE_AK=false
local function InitFE()
    if FE_H or not mt or not nc then return end
    FE_H=true;setreadonly(mt,false)
    mt.__namecall=function(s,...)
        local m=getnamecallmethod() or ""
        if FE_AK and m=="FireServer" then
            local st=tostring(s):lower()
            if st:find("kick") or st:find("ban") then return end
        end
        return nc(s,...)
    end;setreadonly(mt,true)
end

-- FE ADMIN
local function FK(t)
    if not t then return end
    local c=t.Character
    if c then local h=c:FindFirstChildOfClass("Humanoid");if h then h.Health=0;h:BreakJoints() end;c:BreakJoints() end
    for _,r in pairs(game:GetDescendants()) do if r:IsA("RemoteEvent") and(r.Name:lower():find("kick")or r.Name:lower():find("ban")) then pcall(function() r:FireServer(t) end) end end
end
local function FKL(t)
    if not t or not t.Character then return end
    local h=t.Character:FindFirstChildOfClass("Humanoid")
    if h then h.Health=0;h:BreakJoints();for _,j in pairs(t.Character:GetDescendants()) do if j:IsA("JointInstance") then j:Destroy() end end end
end

-- Toggle State
local T={}
local O={WS=16,JP=50,FS=50,AR=20,AD=5,SS=10}

-- LOOPLAR
RS.Stepped:Connect(function()
    if T.Noclip and GC() then for _,p in pairs(GC():GetDescendants()) do if p:IsA("BasePart") then p.CanCollide=false end end end
end)
RS.Heartbeat:Connect(function()
    if T.Fly and HRP() then
        local h=HRP();local bv=h:FindFirstChildOfClass("BodyVelocity");local bg=h:FindFirstChildOfClass("BodyGyro")
        if bv and bg then
            local md=Vector3.new(UIS:IsKeyDown(Enum.KeyCode.D)and 1 or UIS:IsKeyDown(Enum.KeyCode.A)and -1 or 0,UIS:IsKeyDown(Enum.KeyCode.Space)and 1 or UIS:IsKeyDown(Enum.KeyCode.LeftShift)and -1 or 0,UIS:IsKeyDown(Enum.KeyCode.S)and 1 or UIS:IsKeyDown(Enum.KeyCode.W)and -1 or 0)
            bv.Velocity=md.Magnitude>0 and Camera.CFrame:VectorToObjectSpace(md).Unit*O.FS or Vector3.new(0,0,0);bg.CFrame=Camera.CFrame
        end
    end
    if T.Spin and HRP() then HRP().CFrame=HRP().CFrame*CFrame.Angles(0,math.rad(O.SS),0) end
    if T.Aim then local t=GCP();if t and t.Character and t.Character:FindFirstChild("Head")and THUM(t)and THUM(t).Health>0 then Camera.CFrame=CFrame.lookAt(Camera.CFrame.Position,t.Character.Head.Position)end end
end)
UIS.JumpRequest:Connect(function() if T.IJ and HUM() then HUM():ChangeState(Enum.HumanoidStateType.Jumping)end end)
Mouse.Button1Down:Connect(function() if T.CTP and HRP() then HRP().CFrame=CFrame.new(Mouse.Hit.X,Mouse.Hit.Y+3,Mouse.Hit.Z)end end)

-- UI
local GUI=Instance.new("ScreenGui");GUI.Name="MegaAdminFinal";GUI.Parent=CG;GUI.ZIndexBehavior=Enum.ZIndexBehavior.Sibling

-- Ana Pencere
local M=Instance.new("Frame");M.Size=UDim2.new(0,650,0,450);M.Position=UDim2.new(0.5,-325,0.5,-225);M.BackgroundColor3=Color3.fromRGB(12,10,20);M.BorderSizePixel=0;M.Parent=GUI

-- Border
local B=Instance.new("Frame");B.Size=UDim2.new(1,0,1,0);B.BackgroundColor3=Color3.fromRGB(130,70,255);B.BackgroundTransparency=0.6;B.BorderSizePixel=0;B.Parent=M

-- Drag
local function MD(f)
    local d,s,p
    f.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 then d=true;s=i.Position;p=f.Position end end)
    f.InputChanged:Connect(function(i) if d and i.UserInputType==Enum.UserInputType.MouseMovement then local delta=i.Position-s;f.Position=UDim2.new(p.X.Scale,p.X.Offset+delta.X,p.Y.Scale,p.Y.Offset+delta.Y)end end)
    UIS.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 then d=false end end)
end

-- Title Bar
local TB=Instance.new("Frame");TB.Size=UDim2.new(1,0,0,35);TB.BackgroundColor3=Color3.fromRGB(20,16,32);TB.BorderSizePixel=0;TB.Parent=M;MD(TB)
local TL=Instance.new("TextLabel");TL.Size=UDim2.new(1,-40,1,0);TL.Position=UDim2.new(0,10,0,0);TL.BackgroundTransparency=1;TL.Text="MEGA ADMIN";TL.TextColor3=Color3.fromRGB(130,70,255);TL.Font=Enum.Font.GothamBold;TL.TextSize=16;TL.TextXAlignment=Enum.TextXAlignment.Left;TL.Parent=TB
local CX=Instance.new("TextButton");CX.Size=UDim2.new(0,30,0,30);CX.Position=UDim2.new(1,-33,0,2);CX.BackgroundTransparency=1;CX.Text="X";CX.TextColor3=Color3.fromRGB(255,60,60);CX.Font=Enum.Font.GothamBold;CX.TextSize=16;CX.Parent=TB;CX.MouseButton1Click:Connect(function()GUI.Enabled=not GUI.Enabled end)

-- Sidebar
local SB=Instance.new("Frame");SB.Size=UDim2.new(0,120,1,-35);SB.Position=UDim2.new(0,0,0,35);SB.BackgroundColor3=Color3.fromRGB(20,16,32);SB.BorderSizePixel=0;SB.Parent=M
local SS=Instance.new("ScrollingFrame");SS.Size=UDim2.new(1,0,1,0);SS.BackgroundTransparency=1;SS.BorderSizePixel=0;SS.ScrollBarThickness=0;SS.CanvasSize=UDim2.new(0,0,0,0);SS.AutomaticCanvasSize=Enum.AutomaticSize.Y;SS.Parent=SB

-- Content
local CF=Instance.new("Frame");CF.Size=UDim2.new(1,-130,1,-45);CF.Position=UDim2.new(0,125,0,40);CF.BackgroundColor3=Color3.fromRGB(12,10,20);CF.BorderSizePixel=0;CF.Parent=M
local CS=Instance.new("ScrollingFrame");CS.Size=UDim2.new(1,-10,1,-10);CS.Position=UDim2.new(0,5,0,5);CS.BackgroundTransparency=1;CS.BorderSizePixel=0;CS.ScrollBarThickness=3;CS.ScrollBarImageColor3=Color3.fromRGB(80,50,150);CS.CanvasSize=UDim2.new(0,0,0,0);CS.AutomaticCanvasSize=Enum.AutomaticSize.Y;CS.Parent=CF

-- TAB SYSTEM
local tabs={}
local activeTab=1

function NewTab(name)
    local id=#tabs+1
    local btn=Instance.new("TextButton")
    btn.Size=UDim2.new(1,-8,0,30);btn.Position=UDim2.new(0,4,0,(id-1)*33+5)
    btn.BackgroundColor3=Color3.fromRGB(25,20,40);btn.BorderSizePixel=0
    btn.Text="  "..name;btn.TextColor3=Color3.fromRGB(150,140,180);btn.Font=Enum.Font.GothamSemibold;btn.TextSize=12;btn.TextXAlignment=Enum.TextXAlignment.Left;btn.Parent=SS
    
    local content=Instance.new("Frame")
    content.Size=UDim2.new(1,0,0,0);content.BackgroundTransparency=1;content.BorderSizePixel=0
    content.Parent=CS;content.Visible=false;content.AutomaticSize=Enum.AutomaticSize.Y
    
    tabs[id]={btn=btn,content=content,name=name}
    
    btn.MouseButton1Click:Connect(function()
        activeTab=id
        for i,t in pairs(tabs) do
            t.btn.BackgroundColor3=i==id and Color3.fromRGB(60,35,120) or Color3.fromRGB(25,20,40)
            t.btn.TextColor3=i==id and Color3.fromRGB(230,220,255) or Color3.fromRGB(150,140,180)
            t.content.Visible=i==id
        end
        CS.CanvasPosition=Vector2.new(0,0)
    end)
    btn.MouseEnter:Connect(function() if activeTab~=id then btn.BackgroundColor3=Color3.fromRGB(35,28,55) end end)
    btn.MouseLeave:Connect(function() if activeTab~=id then btn.BackgroundColor3=Color3.fromRGB(25,20,40) end end)
    
    return id
end

function Section(tabId,title)
    local sec=Instance.new("Frame")
    sec.Size=UDim2.new(1,-10,0,0);sec.Position=UDim2.new(0,5,0,0)
    sec.BackgroundTransparency=1;sec.BorderSizePixel=0
    sec.Parent=tabs[tabId].content;sec.AutomaticSize=Enum.AutomaticSize.Y
    
    local sep=Instance.new("Frame")
    sep.Size=UDim2.new(1,-10,0,1);sep.Position=UDim2.new(0,5,0,0)
    sep.BackgroundColor3=Color3.fromRGB(130,70,255);sep.BackgroundTransparency=0.5;sep.BorderSizePixel=0;sep.Parent=sec
    
    local lbl=Instance.new("TextLabel")
    lbl.Size=UDim2.new(1,-10,0,24);lbl.Position=UDim2.new(0,5,0,6)
    lbl.BackgroundTransparency=1;lbl.Text="["..title.."]";lbl.TextColor3=Color3.fromRGB(170,130,255)
    lbl.Font=Enum.Font.GothamBold;lbl.TextSize=13;lbl.TextXAlignment=Enum.TextXAlignment.Left;lbl.Parent=sec
    
    local yPos=35
    
    local r={}
    
    function r.Toggle(text,cb)
        local fr=Instance.new("Frame")
        fr.Size=UDim2.new(1,-10,0,36);fr.Position=UDim2.new(0,5,0,yPos)
        fr.BackgroundColor3=Color3.fromRGB(25,20,40);fr.BorderSizePixel=0;fr.Parent=sec;yPos=yPos+39
        
        local tx=Instance.new("TextLabel")
        tx.Size=UDim2.new(1,-50,0,36);tx.Position=UDim2.new(0,10,0,0)
        tx.BackgroundTransparency=1;tx.Text=text;tx.TextColor3=Color3.fromRGB(210,200,230)
        tx.Font=Enum.Font.Gotham;tx.TextSize=13;tx.TextXAlignment=Enum.TextXAlignment.Left;tx.Parent=fr
        
        local tbg=Instance.new("Frame")
        tbg.Size=UDim2.new(0,36,0,20);tbg.Position=UDim2.new(1,-44,0,8)
        tbg.BackgroundColor3=Color3.fromRGB(40,35,55);tbg.BorderSizePixel=0;tbg.Parent=fr
        
        local tc=Instance.new("Frame")
        tc.Size=UDim2.new(0,16,0,16);tc.Position=UDim2.new(0,2,0,2)
        tc.BackgroundColor3=Color3.fromRGB(140,130,160);tc.BorderSizePixel=0;tc.Parent=tbg
        
        local state=false
        local function up()
            if state then
                tbg.BackgroundColor3=Color3.fromRGB(130,70,255);tc.Position=UDim2.new(0,18,0,2);tc.BackgroundColor3=Color3.fromRGB(230,220,255)
            else
                tbg.BackgroundColor3=Color3.fromRGB(40,35,55);tc.Position=UDim2.new(0,2,0,2);tc.BackgroundColor3=Color3.fromRGB(140,130,160)
            end
        end
        
        local b=Instance.new("TextButton")
        b.Size=UDim2.new(1,0,1,0);b.BackgroundTransparency=1;b.Text="";b.Parent=fr
        b.MouseButton1Click:Connect(function() state=not state;up();pcall(function() cb(state) end) end)
        up()
    end
    
    function r.Button(text,cb)
        local b=Instance.new("TextButton")
        b.Size=UDim2.new(1,-10,0,30);b.Position=UDim2.new(0,5,0,yPos)
        b.BackgroundColor3=Color3.fromRGB(90,50,180);b.BackgroundTransparency=0.3;b.BorderSizePixel=0
        b.Text=text;b.TextColor3=Color3.fromRGB(220,210,240);b.Font=Enum.Font.GothamSemibold;b.TextSize=12;b.Parent=sec;yPos=yPos+34
        b.MouseEnter:Connect(function()b.BackgroundTransparency=0.1 end)
        b.MouseLeave:Connect(function()b.BackgroundTransparency=0.3 end)
        b.MouseButton1Click:Connect(function()pcall(cb)end)
    end
    
    function r.Slider(text,min,max,def,cb)
        local fr=Instance.new("Frame")
        fr.Size=UDim2.new(1,-10,0,34);fr.Position=UDim2.new(0,5,0,yPos)
        fr.BackgroundColor3=Color3.fromRGB(25,20,40);fr.BorderSizePixel=0;fr.Parent=sec;yPos=yPos+38
        
        local tx=Instance.new("TextLabel")
        tx.Size=UDim2.new(1,-10,0,14);tx.Position=UDim2.new(0,10,0,2)
        tx.BackgroundTransparency=1;tx.Text=text..": "..def;tx.TextColor3=Color3.fromRGB(210,200,230)
        tx.Font=Enum.Font.Gotham;tx.TextSize=11;tx.TextXAlignment=Enum.TextXAlignment.Left;tx.Parent=fr
        
        local sbg=Instance.new("Frame")
        sbg.Size=UDim2.new(1,-20,0,5);sbg.Position=UDim2.new(0,10,0,22)
        sbg.BackgroundColor3=Color3.fromRGB(40,35,55);sbg.BorderSizePixel=0;sbg.Parent=fr
        
        local sf=Instance.new("Frame")
        sf.Size=UDim2.new((def-min)/(max-min),0,1,0)
        sf.BackgroundColor3=Color3.fromRGB(130,70,255);sf.BorderSizePixel=0;sf.Parent=sbg
        
        local drag=false;local val=def
        local dr=Instance.new("TextButton")
        dr.Size=UDim2.new(1,0,1,0);dr.BackgroundTransparency=1;dr.Text="";dr.Parent=sbg
        
        dr.MouseButton1Down:Connect(function()drag=true end)
        UIS.InputEnded:Connect(function(i)if i.UserInputType==Enum.UserInputType.MouseButton1 then drag=false end end)
        UIS.InputChanged:Connect(function(i)
            if drag and i.UserInputType==Enum.UserInputType.MouseMovement then
                local pos=UIS:GetMouseLocation().X
                local ap=sbg.AbsolutePosition.X;local as=sbg.AbsoluteSize.X
                local ratio=math.clamp((pos-ap)/as,0,1)
                val=math.floor(min+(max-min)*ratio)
                sf.Size=UDim2.new(ratio,0,1,0);tx.Text=text..": "..val
                pcall(function()cb(val)end)
            end
        end)
    end
    
    function r.Drop(text,opts,cb)
        local b=Instance.new("TextButton")
        b.Size=UDim2.new(1,-10,0,28);b.Position=UDim2.new(0,5,0,yPos)
        b.BackgroundColor3=Color3.fromRGB(25,20,40);b.BorderSizePixel=0
        b.Text=text..": "..(opts[1]or"");b.TextColor3=Color3.fromRGB(210,200,230);b.Font=Enum.Font.Gotham;b.TextSize=11;b.Parent=sec;yPos=yPos+32
        
        local idx=1
        b.MouseButton1Click:Connect(function()
            idx=idx+1;if idx>#opts then idx=1 end
            b.Text=text..": "..opts[idx];pcall(function()cb(opts[idx])end)
        end)
    end
    
    function r.Label(t)
        local l=Instance.new("TextLabel")
        l.Size=UDim2.new(1,-10,0,16);l.Position=UDim2.new(0,5,0,yPos)
        l.BackgroundTransparency=1;l.Text=t;l.TextColor3=Color3.fromRGB(160,150,190)
        l.Font=Enum.Font.Gotham;l.TextSize=10;l.TextXAlignment=Enum.TextXAlignment.Left;l.Parent=sec;yPos=yPos+18
    end
    
    return r
end

-- TABS
local tPlayer=NewTab("Player")
local tVisual=NewTab("Visual")
local tTeleport=NewTab("Teleport")
local tCombat=NewTab("Combat")
local tAdmin=NewTab("Admin")
local tMisc=NewTab("Misc")

-- PLAYER TAB
local sP=Section(tPlayer,"MODLAR")
sP.Toggle("God Mode",function(s)T.God=s
    if s then
        local h=HUM();if h then h.MaxHealth=9e9;h.Health=9e9;h.BreakJointsOnDeath=false end
        coroutine.wrap(function()while T.God do wait(0.3)local h2=HUM();if h2 then if h2.Health<1 then h2.Health=9e9 end;h2.MaxHealth=9e9;h2.BreakJointsOnDeath=false end end end)()
    end
end)
sP.Toggle("Noclip",function(s)T.Noclip=s end)
sP.Toggle("Fly",function(s)T.Fly=s
    if s then
        local h=HRP();if h then Instance.new("BodyVelocity",h).MaxForce=Vector3.new(1e9,1e9,1e9);Instance.new("BodyGyro",h).MaxTorque=Vector3.new(1e9,1e9,1e9) end
        if HUM()then HUM().PlatformStand=true end
    else
        local h=HRP();if h then for _,v in pairs(h:GetChildren())do if v:IsA("BodyVelocity")or v:IsA("BodyGyro")then v:Destroy()end end end
        if HUM()then HUM().PlatformStand=false end
    end
end)
sP.Toggle("Inf Jump",function(s)T.IJ=s end)
sP.Toggle("BHop",function(s)T.BH=s;if s then coroutine.wrap(function()while T.BH do wait(0.15)if HUM()and HUM().MoveDirection.Magnitude>0 then HUM():ChangeState(Enum.HumanoidStateType.Jumping)end end end)()end end)
sP.Toggle("Spin Bot",function(s)T.Spin=s end)
sP.Toggle("Invisible",function(s)T.Inv=s;local c=GC();if c then for _,p in pairs(c:GetDescendants())do if p:IsA("BasePart")then p.Transparency=s and 1 or 0;p.CanCollide=not s end end end)
sP.Button("Reset Char",function()if GC()then GC():BreakJoints()end;wait(2);LP:LoadCharacter()end)

local sPa=Section(tPlayer,"ANTI")
sPa.Toggle("Anti-Kick",function(s)FE_AK=s;InitFE()end)
sPa.Toggle("Anti-AFK",function(s)T.AAK=s;if s then coroutine.wrap(function()while T.AAK do wait(45);VU:CaptureController();VU:ClickButton2(Vector2.new())end end)()end end)
sPa.Toggle("No Fall",function(s)T.NF=s;if HUM()then HUM().FallDamage=not s end end)
sPa.Toggle("Auto Heal",function(s)T.AH=s;if s then coroutine.wrap(function()while T.AH do wait(1)if HUM()and HUM().Health<HUM().MaxHealth then HUM().Health=HUM().MaxHealth end end end)()end end)

local sPs=Section(tPlayer,"AYARLAR")
sPs.Slider("Walk Speed",1,500,16,function(s)O.WS=s;if HUM()then HUM().WalkSpeed=s end end)
sPs.Slider("Jump Power",1,500,50,function(s)O.JP=s;if HUM()then HUM().JumpPower=s end end)
sPs.Slider("Fly Speed",1,500,50,function(s)O.FS=s end)
sPs.Slider("Spin Speed",1,360,10,function(s)O.SS=s end)

-- VISUAL TAB
local sV=Section(tVisual,"GORSEL")
local ESP_O={}
sV.Toggle("ESP",function(s)T.ESP=s
    if s then
        for _,p in pairs(Players:GetPlayers())do if p~=LP and p.Character then
            local hrp=THRP(p);local hd=p.Character:FindFirstChild("Head")or hrp
            if hrp and hd then
                local hl=Instance.new("Highlight",p.Character);hl.FillColor=Color3.new(1,0,0);hl.FillTransparency=0.4;table.insert(ESP_O,hl)
                local bg=Instance.new("BillboardGui",p.Character);bg.Adornee=hd;bg.Size=UDim2.new(0,200,0,50);bg.StudsOffset=Vector3.new(0,3,0)
                local tl=Instance.new("TextLabel",bg);tl.Size=UDim2.new(1,0,1,0);tl.BackgroundTransparency=1;tl.Text=p.Name;tl.TextStrokeTransparency=0.3;tl.TextColor3=Color3.new(1,1,1);tl.TextScaled=true;tl.Font=Enum.Font.GothamSemibold;table.insert(ESP_O,bg)
            end
        end end
        coroutine.wrap(function()while T.ESP do wait(0.5)for _,p in pairs(Players:GetPlayers())do if p~=LP and p.Character then for _,bg in pairs(p.Character:GetDescendants())do if bg:IsA("BillboardGui")and bg:FindFirstChildOfClass("TextLabel")then local d=THRP(p)and HRP()and math.floor((THRP(p).Position-HRP().Position).Magnitude)or 0;bg.TextLabel.Text=p.Name.."["..d.."m]"end end end end end end)()
    else for _,o in pairs(ESP_O)do pcall(function()o:Destroy()end)end;ESP_O={}end
end)
sV.Toggle("Full Bright",function(s)if s then Lighting.Ambient=Color3.new(1,1,1);Lighting.Brightness=3;Lighting.FogEnd=1e9;Lighting.ClockTime=12;Lighting.GlobalShadows=false else Lighting:SetGlobalLighting()end end)
sV.Toggle("X-Ray",function(s)for _,o in pairs(workspace:GetDescendants())do if o:IsA("BasePart")then o.Transparency=s and 0.7 or 0 end end end)
sV.Toggle("Wallhack",function(s)for _,o in pairs(workspace:GetDescendants())do if o:IsA("BasePart")and o.Anchored then o.Transparency=s and 0.7 or 0 end end end)
sV.Slider("FOV",20,180,70,function(s)Camera.FieldOfView=s end)
sV.Slider("Gravity",0,500,196,function(s)workspace.Gravity=s end)
sV.Slider("Time",0,24,12,function(s)Lighting.ClockTime=s end)

-- TELEPORT TAB
local sT=Section(tTeleport,"ISINLANMA")
sT.Toggle("Click TP",function(s)T.CTP=s end)
sT.Drop("TP Git",PL,function(sel)local t=Players:FindFirstChild(sel);if t and THRP(t)and HRP()then HRP().CFrame=THRP(t).CFrame*CFrame.new(0,5,0)end end)
sT.Drop("Getir",PL,function(sel)local t=Players:FindFirstChild(sel);if t and THRP(t)and HRP()then THRP(t).CFrame=HRP().CFrame*CFrame.new(0,0,3)end end)
sT.Button("Herkesi Getir",function()for _,p in pairs(Players:GetPlayers())do if p~=LP and THRP(p)and HRP()then THRP(p).CFrame=HRP().CFrame*CFrame.new(0,0,3)end end end)
sT.Button("Spawna Git",function()if HRP()and workspace:FindFirstChild("SpawnLocation")then HRP().CFrame=workspace.SpawnLocation.CFrame*CFrame.new(0,3,0)end end)
sT.Button("Yukari +50",function()if HRP()then HRP().CFrame=HRP().CFrame*CFrame.new(0,50,0)end end)
sT.Button("Asagi -50",function()if HRP()then HRP().CFrame=HRP().CFrame*CFrame.new(0,-50,0)end end)

-- COMBAT TAB
local sC=Section(tCombat,"SAVAS")
sC.Toggle("Aimbot",function(s)T.Aim=s end)
sC.Toggle("Silent Aim",function(s)T.SA=s end)
sC.Toggle("Triggerbot",function(s)T.Trig=s;if s then coroutine.wrap(function()while T.Trig do RS.RenderStepped:Wait();local tgt=Mouse.Target;if tgt then for _,p in pairs(Players:GetPlayers())do if p~=LP and p.Character and tgt:IsDescendantOf(p.Character)then mouse1click();wait(0.05)end end end end end)()end end)
sC.Toggle("Damage Aura",function(s)T.DA=s;if s then coroutine.wrap(function()while T.DA do wait(0.3);for _,tg in pairs(PL)do local t=Players:FindFirstChild(tg);local th=THUM(t);if th and th.Health>0 and HRP()and THRP(t)and(THRP(t).Position-HRP().Position).Magnitude<=O.AR then th.Health=th.Health-O.AD end end end end)()end end)
sC.Toggle("Auto Click",function(s)T.AC=s;if s then coroutine.wrap(function()while T.AC do mouse1click();wait(0.05)end end)()end end)
sC.Slider("Aura Range",5,100,20,function(s)O.AR=s end)
sC.Slider("Aura Damage",1,50,5,function(s)O.AD=s end)

-- ADMIN TAB
local sA=Section(tAdmin,"FE YONETICI")
sA.Drop("Kick",PL,function(sel)local t=Players:FindFirstChild(sel);if t then FK(t);Nfy("KICKED",t.Name)end end)
sA.Drop("Kill",PL,function(sel)local t=Players:FindFirstChild(sel);if t then FKL(t);Nfy("KILLED",t.Name)end end)
sA.Drop("Freeze",PL,function(sel)local t=Players:FindFirstChild(sel);if t and THRP(t)then local bp=Instance.new("BodyPosition");bp.Position=THRP(t).Position;bp.MaxForce=Vector3.new(1e9,1e9,1e9);bp.P=1e9;bp.Parent=THRP(t)end end)
sA.Drop("Unfreeze",PL,function(sel)local t=Players:FindFirstChild(sel);if t and THRP(t)then for _,v in pairs(THRP(t):GetChildren())do if v:IsA("BodyPosition")then v:Destroy()end end end end)
sA.Drop("Heal",PL,function(sel)local t=Players:FindFirstChild(sel);if t and THUM(t)then THUM(t).Health=THUM(t).MaxHealth;Nfy("HEALED",t.Name)end end)

local sAa=Section(tAdmin,"TOPLU")
sAa.Button("Kick All",function()for _,p in pairs(Players:GetPlayers())do if p~=LP then FK(p)end end end)
sAa.Button("Kill All",function()for _,p in pairs(Players:GetPlayers())do if p~=LP then FKL(p)end end end)
sAa.Button("Freeze All",function()for _,p in pairs(Players:GetPlayers())do if p~=LP and THRP(p)then local bp=Instance.new("BodyPosition");bp.Position=THRP(p).Position;bp.MaxForce=Vector3.new(1e9,1e9,1e9);bp.P=1e9;bp.Parent=THRP(p)end end end)
sAa.Button("Unfreeze All",function()for _,p in pairs(Players:GetPlayers())do if THRP(p)then for _,v in pairs(THRP(p):GetChildren())do if v:IsA("BodyPosition")then v:Destroy()end end end end end)
sAa.Button("Heal All",function()for _,p in pairs(Players:GetPlayers())do if THUM(p)then THUM(p).Health=THUM(p).MaxHealth end end end)
sAa.Button("Lag",function()for i=1,1000 do local p=Instance.new("Part");p.Position=Vector3.new(math.random(-100,100),50,math.random(-100,100));p.Velocity=Vector3.new(math.random(-100,100),math.random(-100,100),math.random(-100,100));p.Parent=workspace;Debris:AddItem(p,10)end end)

-- MISC TAB
local sM=Section(tMisc,"CESITLI")
sM.Button("Rejoin",function()TS:Teleport(game.PlaceId,LP)end)
sM.Button("Server Hop",function()
    local s,d=pcall(function()return HttpS:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?limit=100"))end)
    if s and d and d.data then for _,sv in pairs(d.data)do if sv.id~=game.JobId and sv.playing<sv.maxPlayers then TS:TeleportToPlaceInstance(game.PlaceId,sv.id,LP);return end end end
end)
sM.Button("FPS",function()
    local g=Instance.new("ScreenGui",CG);local l=Instance.new("TextLabel",g)
    l.Size=UDim2.new(0,100,0,30);l.Position=UDim2.new(0,10,0,10);l.BackgroundTransparency=0.5;l.BackgroundColor3=Color3.new(0,0,0);l.TextColor3=Color3.new(0,1,0);l.Font=Enum.Font.GothamBold;l.TextScaled=true
    coroutine.wrap(function()while g.Parent do RS.RenderStepped:Wait();l.Text="FPS: "..math.floor(1/RS.RenderStepped:Wait())end end)()
end)
sM.Label("MEGA ADMIN FINAL â€” THORELL")
sM.Label("0 External Loading | Her sey built-in")
sM.Label("LCtrl = Menu Ac/Kapa")
sM.Label("Github: github.com/Naiwles/MegaAdmin")

-- KEYBINDS
UIS.InputBegan:Connect(function(i)
    if i.KeyCode==Enum.KeyCode.LeftControl then GUI.Enabled=not GUI.Enabled
    elseif i.KeyCode==Enum.KeyCode.N then T.Noclip=not T.Noclip
    elseif i.KeyCode==Enum.KeyCode.F then T.Fly=not T.Fly
    elseif i.KeyCode==Enum.KeyCode.Q then T.God=not T.God
    elseif i.KeyCode==Enum.KeyCode.E then T.ESP=not T.ESP
    elseif i.KeyCode==Enum.KeyCode.G then T.IJ=not T.IJ
    elseif i.KeyCode==Enum.KeyCode.T then T.CTP=not T.CTP
    elseif i.KeyCode==Enum.KeyCode.X then if HUM()then HUM().WalkSpeed=100;wait(5);HUM().WalkSpeed=O.WS end
    elseif i.KeyCode==Enum.KeyCode.R then if GC()then GC():BreakJoints()end;wait(2);LP:LoadCharacter()end
    end
end)

-- START
for i,t in pairs(tabs)do
    t.btn.BackgroundColor3=i==1 and Color3.fromRGB(60,35,120)or Color3.fromRGB(25,20,40)
    t.btn.TextColor3=i==1 and Color3.fromRGB(230,220,255)or Color3.fromRGB(150,140,180)
    t.content.Visible=i==1
end

Nfy("MEGA ADMIN FINAL","0 external loading | LCtrl=Menu",4)
print("MEGA ADMIN FINAL loaded - purp kernel UI | no external deps")
InitFE()
