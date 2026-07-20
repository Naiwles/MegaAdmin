-- MEGA ADMIN â€” CHAT COMMAND ONLY (0 GUI)
-- Madium icin ozel: hic UI yok, sadece chat komutlari
-- ;komut seklinde calisir

local Players=game:GetService("Players")
local LP=Players.LocalPlayer
local Mouse=LP:GetMouse()
local Camera=workspace.CurrentCamera
local RS=game:GetService("RunService")
local UIS=game:GetService("UserInputService")
local VU=game:GetService("VirtualUser")
local TS=game:GetService("TeleportService")
local Lighting=game:GetService("Lighting")
local Debris=game:GetService("Debris")

-- Utility
local function GC()return LP.Character end
local function HRP()local c=GC();return c and c:FindFirstChild("HumanoidRootPart")end
local function HUM()local c=GC();return c and c:FindFirstChildOfClass("Humanoid")end
local function THRP(p)local c=p.Character;return c and c:FindFirstChild("HumanoidRootPart")end
local function THUM(p)local c=p.Character;return c and c:FindFirstChildOfClass("Humanoid")end

local function Nfy(t,x)pcall(function()game:GetService("StarterGui"):SetCore("SendNotification",{Title=t or "",Text=x or "",Duration=3})end)end

-- State
local T={}
local O={WS=16,JP=50,FS=50,AR=20,AD=5}

-- FE
local mt=getrawmetatable(game)
local nc=mt and mt.__namecall
local FE_H=false;local FE_AK=false
local function InitFE()
    if FE_H or not mt or not nc then return end
    FE_H=true;setreadonly(mt,false)
    mt.__namecall=function(s,...)
        local m=getnamecallmethod()or""
        if FE_AK and m=="FireServer" then
            local st=tostring(s):lower()
            if st:find("kick")or st:find("ban")then return end
        end
        return nc(s,...)
    end;setreadonly(mt,true)
end

-- Loops
RS.Stepped:Connect(function()
    if T.Noclip and GC()then for _,p in pairs(GC():GetDescendants())do if p:IsA("BasePart")then p.CanCollide=false end end end
end)
RS.Heartbeat:Connect(function()
    if T.Fly and HRP()then
        local h=HRP();local bv=h:FindFirstChildOfClass("BodyVelocity");local bg=h:FindFirstChildOfClass("BodyGyro")
        if bv and bg then
            local md=Vector3.new(UIS:IsKeyDown(Enum.KeyCode.D)and 1 or UIS:IsKeyDown(Enum.KeyCode.A)and -1 or 0,UIS:IsKeyDown(Enum.KeyCode.Space)and 1 or UIS:IsKeyDown(Enum.KeyCode.LeftShift)and -1 or 0,UIS:IsKeyDown(Enum.KeyCode.S)and 1 or UIS:IsKeyDown(Enum.KeyCode.W)and -1 or 0)
            bv.Velocity=md.Magnitude>0 and Camera.CFrame:VectorToObjectSpace(md).Unit*O.FS or Vector3.new(0,0,0);bg.CFrame=Camera.CFrame
        end
    end
    if T.Spin and HRP()then HRP().CFrame=HRP().CFrame*CFrame.Angles(0,math.rad(O.SS or 10),0)end
    if T.Aim then
        local cl,cd=nil,99999
        for _,p in pairs(Players:GetPlayers())do
            if p~=LP and THRP(p)and THUM(p)and THUM(p).Health>0 then
                local d=(THRP(p).Position-HRP().Position).Magnitude
                if d<cd then cd=d;cl=p end
            end
        end
        if cl and cl.Character and cl.Character:FindFirstChild("Head")and THUM(cl)and THUM(cl).Health>0 then Camera.CFrame=CFrame.lookAt(Camera.CFrame.Position,cl.Character.Head.Position)end
    end
end)
UIS.JumpRequest:Connect(function()if T.IJ and HUM()then HUM():ChangeState(Enum.HumanoidStateType.Jumping)end end)

-- Admin FE
local function FK(t)
    if not t then return end
    local c=t.Character
    if c then local h=c:FindFirstChildOfClass("Humanoid");if h then h.Health=0;h:BreakJoints()end;c:BreakJoints()end
    for _,r in pairs(game:GetDescendants())do if r:IsA("RemoteEvent")and(r.Name:lower():find("kick")or r.Name:lower():find("ban"))then pcall(function()r:FireServer(t)end)end end
end
local function FKL(t)
    if not t or not t.Character then return end
    local h=t.Character:FindFirstChildOfClass("Humanoid")
    if h then h.Health=0;h:BreakJoints();for _,j in pairs(t.Character:GetDescendants())do if j:IsA("JointInstance")then j:Destroy()end end end
end

-- Plugin list
local PL={}
local function UPL()PL={};for _,p in pairs(Players:GetPlayers())do if p~=LP then table.insert(PL,p)end end end
UPL()
Players.PlayerAdded:Connect(UPL)
Players.PlayerRemoving:Connect(UPL)

-- Find player by name
local function FindP(name)
    for _,p in pairs(PL)do
        if p.Name:lower():find(name:lower())then return p end
    end
    return nil
end

-- KOMUT SISTEMI
LP.Chatted:Connect(function(msg)
    if msg:sub(1,1)==";"then
        local parts=msg:sub(2):split(" ")
        local cmd=parts[1]:lower()
        local args={}
        for i=2,#parts do args[#args+1]=parts[i]end
        
        -- PLAYER
        if cmd=="god"or cmd=="godmode"then
            T.God=not T.God
            if T.God then
                local h=HUM();if h then h.MaxHealth=9e9;h.Health=9e9;h.BreakJointsOnDeath=false end
                coroutine.wrap(function()while T.God do wait(0.3)local h2=HUM();if h2 then if h2.Health<1 then h2.Health=9e9 end;h2.MaxHealth=9e9;h2.BreakJointsOnDeath=false end end end)()
            end
            Nfy("God",T.God and "ON" or "OFF")
        
        elseif cmd=="noclip"or cmd=="nc"then
            T.Noclip=not T.Noclip;Nfy("Noclip",T.Noclip and "ON" or "OFF")
        
        elseif cmd=="fly"then
            T.Fly=not T.Fly
            if T.Fly then
                local h=HRP()
                if h then Instance.new("BodyVelocity",h).MaxForce=Vector3.new(1e9,1e9,1e9);Instance.new("BodyGyro",h).MaxTorque=Vector3.new(1e9,1e9,1e9)end
                if HUM()then HUM().PlatformStand=true end
            else
                local h=HRP()
                if h then for _,v in pairs(h:GetChildren())do if v:IsA("BodyVelocity")or v:IsA("BodyGyro")then v:Destroy()end end end
                if HUM()then HUM().PlatformStand=false end
            end
            Nfy("Fly",T.Fly and "ON" or "OFF")
        
        elseif cmd=="infjump"or cmd=="ij"then
            T.IJ=not T.IJ;Nfy("InfJump",T.IJ and "ON" or "OFF")
        
        elseif cmd=="spin"then
            T.Spin=not T.Spin;Nfy("Spin",T.Spin and "ON" or "OFF")
        
        elseif cmd=="bhop"then
            T.BH=not T.BH
            if T.BH then coroutine.wrap(function()while T.BH do wait(0.15)if HUM()and HUM().MoveDirection.Magnitude>0 then HUM():ChangeState(Enum.HumanoidStateType.Jumping)end end end)()end
            Nfy("BHop",T.BH and "ON" or "OFF")
        
        elseif cmd=="invisible"or cmd=="inv"then
            T.Inv=not T.Inv;local c=GC()
            if c then for _,p in pairs(c:GetDescendants())do if p:IsA("BasePart")then p.Transparency=T.Inv and 1 or 0;p.CanCollide=not T.Inv end end end
            Nfy("Invisible",T.Inv and "ON" or "OFF")
        
        elseif cmd=="antikick"or cmd=="ak"then
            FE_AK=not FE_AK;InitFE();Nfy("AntiKick",FE_AK and "ON" or "OFF")
        
        elseif cmd=="antiafk"or cmd=="aafk"then
            T.AAFK=not T.AAFK
            if T.AAFK then coroutine.wrap(function()while T.AAFK do wait(45);VU:CaptureController();VU:ClickButton2(Vector2.new())end end)()end
            Nfy("AntiAFK",T.AAFK and "ON" or "OFF")
        
        elseif cmd=="speed"then
            local s=tonumber(args[1])
            if s then O.WS=s;if HUM()then HUM().WalkSpeed=s end;Nfy("Speed",tostring(s))end
        
        elseif cmd=="jump"then
            local s=tonumber(args[1])
            if s then O.JP=s;if HUM()then HUM().JumpPower=s end;Nfy("Jump",tostring(s))end
        
        elseif cmd=="flyspeed"then
            local s=tonumber(args[1])
            if s then O.FS=s;Nfy("FlySpeed",tostring(s))end
        
        elseif cmd=="aimbot"or cmd=="aim"then
            T.Aim=not T.Aim;Nfy("Aimbot",T.Aim and "ON" or "OFF")
        
        elseif cmd=="aura"then
            T.DA=not T.DA
            if T.DA then coroutine.wrap(function()while T.DA do wait(0.3)for _,tg in pairs(PL)do local th=THUM(tg);if th and th.Health>0 and HRP()and THRP(tg)and(THRP(tg).Position-HRP().Position).Magnitude<=O.AR then th.Health=th.Health-O.AD end end end end)()end
            Nfy("Aura",T.DA and "ON" or "OFF")
        
        elseif cmd=="autoclick"or cmd=="ac"then
            T.AC=not T.AC
            if T.AC then coroutine.wrap(function()while T.AC do mouse1click();wait(0.05)end end)()end
            Nfy("AutoClick",T.AC and "ON" or "OFF")
        
        elseif cmd=="aurarange"then
            local s=tonumber(args[1]);if s then O.AR=s;Nfy("AuraRange",tostring(s))end
        
        elseif cmd=="auradamage"then
            local s=tonumber(args[1]);if s then O.AD=s;Nfy("AuraDmg",tostring(s))end
        
        elseif cmd=="fullbright"or cmd=="fb"then
            if T.FB then Lighting:SetGlobalLighting()else Lighting.Ambient=Color3.new(1,1,1);Lighting.Brightness=3;Lighting.FogEnd=1e9;Lighting.ClockTime=12;Lighting.GlobalShadows=false end
            T.FB=not T.FB;Nfy("FullBright",T.FB and "ON" or "OFF")
        
        elseif cmd=="xray"then
            T.XR=not T.XR
            for _,o in pairs(workspace:GetDescendants())do if o:IsA("BasePart")then o.Transparency=T.XR and 0.7 or 0 end end
            Nfy("XRay",T.XR and "ON" or "OFF")
        
        elseif cmd=="fov"then
            local s=tonumber(args[1]);if s then Camera.FieldOfView=s;Nfy("FOV",tostring(s))end
        
        elseif cmd=="gravity"or cmd=="grav"then
            local s=tonumber(args[1]);if s then workspace.Gravity=s;Nfy("Gravity",tostring(s))end
        
        elseif cmd=="time"then
            local s=tonumber(args[1]);if s then Lighting.ClockTime=s;Nfy("Time",tostring(s))end
        
        elseif cmd=="kill"then
            local target=args[1]and FindP(args[1])
            if target then FKL(target);Nfy("KILL",target.Name)else Nfy("Hata","Oyuncu bulunamadi")end
        
        elseif cmd=="kick"then
            local target=args[1]and FindP(args[1])
            if target then FK(target);Nfy("KICK",target.Name)else Nfy("Hata","Oyuncu bulunamadi")end
        
        elseif cmd=="freeze"then
            local target=args[1]and FindP(args[1])
            if target and THRP(target)then local bp=Instance.new("BodyPosition");bp.Position=THRP(target).Position;bp.MaxForce=Vector3.new(1e9,1e9,1e9);bp.P=1e9;bp.Parent=THRP(target);Nfy("FREEZE",target.Name)end
        
        elseif cmd=="unfreeze"then
            local target=args[1]and FindP(args[1])
            if target and THRP(target)then for _,v in pairs(THRP(target):GetChildren())do if v:IsA("BodyPosition")then v:Destroy()end end;Nfy("UNFREEZE",target.Name)end
        
        elseif cmd=="heal"then
            local target=args[1]and FindP(args[1])
            if target and THUM(target)then THUM(target).Health=THUM(target).MaxHealth;Nfy("HEAL",target.Name)end
        
        elseif cmd=="bring"then
            local target=args[1]and FindP(args[1])
            if target and THRP(target)and HRP()then THRP(target).CFrame=HRP().CFrame*CFrame.new(0,0,3);Nfy("BRING",target.Name)end
        
        elseif cmd=="tp"then
            local target=args[1]and FindP(args[1])
            if target and THRP(target)and HRP()then HRP().CFrame=THRP(target).CFrame*CFrame.new(0,5,0);Nfy("TP",target.Name)end
        
        elseif cmd=="killall"then
            for _,p in pairs(PL)do FKL(p)end;Nfy("KillAll","Herkese olduruldu")
        
        elseif cmd=="kickall"then
            for _,p in pairs(PL)do FK(p)end;Nfy("KickAll","Herkese atildi")
        
        elseif cmd=="freezeall"then
            for _,p in pairs(PL)do if THRP(p)then local bp=Instance.new("BodyPosition");bp.Position=THRP(p).Position;bp.MaxForce=Vector3.new(1e9,1e9,1e9);bp.P=1e9;bp.Parent=THRP(p)end end
            Nfy("FreezeAll","Herkese donduruldu")
        
        elseif cmd=="unfreezeall"then
            for _,p in pairs(Players:GetPlayers())do if THRP(p)then for _,v in pairs(THRP(p):GetChildren())do if v:IsA("BodyPosition")then v:Destroy()end end end end
            Nfy("UnfreezeAll","Herkes cozuldu")
        
        elseif cmd=="healall"then
            for _,p in pairs(Players:GetPlayers())do if THUM(p)then THUM(p).Health=THUM(p).MaxHealth end end
            Nfy("HealAll","Herkese iyilestirildi")
        
        elseif cmd=="rejoin"then TS:Teleport(game.PlaceId,LP)
        
        elseif cmd=="serverhop"then
            local s,d=pcall(function()return game:GetService("HttpService"):JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?limit=100"))end)
            if s and d and d.data then for _,sv in pairs(d.data)do if sv.id~=game.JobId and sv.playing<sv.maxPlayers then TS:TeleportToPlaceInstance(game.PlaceId,sv.id,LP);return end end end
        
        elseif cmd=="reset"then
            if GC()then GC():BreakJoints()end;wait(2);LP:LoadCharacter()
        
        elseif cmd=="help"or cmd=="commands"then
            local cmds={"god","noclip","fly","infjump","spin","bhop","invisible","speed [1-500]","jump [1-500]","flyspeed [1-500]","antikick","antiafk","aimbot","aura","autoclick","aurarange","auradamage","fullbright","xray","fov","gravity","time","kill [isim]","kick [isim]","freeze [isim]","unfreeze [isim]","heal [isim]","bring [isim]","tp [isim]","killall","kickall","freezeall","unfreezeall","healall","rejoin","serverhop","reset","help"}
            Nfy("Komutlar ("..#cmds..")","; ile basla. Orn: ;god")
            print("=== MEGA ADMIN KOMUTLARI ===")
            for _,c in pairs(cmds)do print(";"..c)end
            print("==============================")
        
        else
            Nfy("Hata","Bilinmeyen komut: ;"..cmd)
        end
    end
end)

-- Baslangic
Nfy("MEGA ADMIN Chat-Only",";help ile komutlari gor | Testli")
print("MEGA ADMIN Chat-Only mode loaded")
print("Komutlar icin ;help yazin")
InitFE()
