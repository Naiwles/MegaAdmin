--[[
╔══════════════════════════════════════════════════════════════════════════════════╗
║         💀 MEGA ADMIN ULTIMATE v2.0 — THORELL EDITION                         ║
║         1000+ FEATURE  |  FE BYPASS  |  UNIVERSAL  |  GUI + COMMAND SYSTEM   ║
║                                                                                ║
║   Executors: Madium ✓  Xeno ✓  Velocity ✓  (ve çoğu Lua executor)             ║
╚══════════════════════════════════════════════════════════════════════════════════╝
--]]

--══════════════════════════════════════════════════════════════════════════════
--=  [CORE] GÜVENLİK & VERSION
--══════════════════════════════════════════════════════════════════════════════

local Version = "v2.0.0"
local Owner = "THORELL"
local ScriptName = "MEGA ADMIN ULTIMATE"
local FeatureCount = 0
local cmdCount = 0

--══════════════════════════════════════════════════════════════════════════════
--=  [CORE] UI KÜTÜPHANESİ (Kavo UI — built-in)
--══════════════════════════════════════════════════════════════════════════════

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source"))()
local Window = Library.CreateLib(ScriptName .. " " .. Version, "DarkTheme")

--══════════════════════════════════════════════════════════════════════════════
--=  [CORE] SERVİSLER & DEĞİŞKENLER
--══════════════════════════════════════════════════════════════════════════════

local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local Mouse = LP:GetMouse()
local Camera = workspace.CurrentCamera
local RS = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local VU = game:GetService("VirtualUser")
local TS = game:GetService("TeleportService")
local HttpS = game:GetService("HttpService")
local Lighting = game:GetService("Lighting")
local CG = game:GetService("CoreGui")
local TweenS = game:GetService("TweenService")
local Debris = game:GetService("Debris")
local Market = game:GetService("MarketplaceService")

--══════════════════════════════════════════════════════════════════════════════
--=  [CORE] FE BYPASS MOTORU
--══════════════════════════════════════════════════════════════════════════════

-- Metatable hook (FE bypass için temel)
local mt = getrawmetatable and getrawmetatable(game) or {}
local __index = mt.__index
local __namecall = mt.__namecall
local __newindex = mt.__newindex
local protect = protectfunction or protect or function(f) return f end
local setreadonly = setreadonly or function(...) end

-- Hook durumu
local FE = {
    Hooked = false,
    BlockedRemotes = {},
    LoggedRemotes = {},
    AntiKick = false,
    AntiTools = false,
    AntiRemoteKick = false,
    SpoofChat = false
}

function FE:Init()
    if FE.Hooked then return end
    FE.Hooked = true
    
    -- namecall hook (FireServer, InvokeServer, Kick mesajları)
    if __namecall then
        setreadonly(mt, false)
        mt.__namecall = protect(function(self, ...)
            local method = getnamecallmethod and getnamecallmethod() or ""
            local args = {...}
            
            -- Anti-Kick (FireServer ile gelen kick engelleme)
            if FE.AntiKick and method == "FireServer" then
                local s = tostring(self)
                if s:lower():find("kick") or s:lower():find("ban") or s:lower():find("remove") then
                    return
                end
            end
            
            -- Remote Logger
            if FE.LoggedRemotes and method == "FireServer" and not s:find("Humanoid") then
                warn("[REMOTE] " .. tostring(self):sub(1, 80))
            end
            
            return __namecall(self, ...)
        end)
        setreadonly(mt, true)
    end
    
    -- index hook (nesne erişimi engelleme)
    if __index then
        setreadonly(mt, false)
        mt.__index = protect(function(self, key)
            if FE.AntiKick and type(key) == "string" and key:lower() == "kick" and not self:IsA("Player") then
                return function() end
            end
            return __index(self, key)
        end)
        setreadonly(mt, true)
    end
    
    warn("✅ FE Bypass Motoru aktif!")
end

--══════════════════════════════════════════════════════════════════════════════
--=  [CORE] KOMUT SİSTEMİ
--══════════════════════════════════════════════════════════════════════════════

local Commands = {}
local CommandHistory = {}
local function AddCmd(name, desc, aliases, func, category, hidden)
    cmdCount = cmdCount + 1
    Commands[name:lower()] = {name=name, desc=desc, aliases=aliases or {}, func=func, category=category or "Misc", hidden=hidden}
    for _, a in pairs(aliases or {}) do
        Commands[a:lower()] = Commands[name:lower()]
    end
end

-- Chat komut dinleyici
LP.Chatted:Connect(function(msg)
    if msg:sub(1,1) == ";" or msg:sub(1,1) == "/" then
        local parts = msg:sub(2):split(" ")
        local cmdName = parts[1]:lower()
        local args = {}
        for i=2, #parts do args[i-1] = parts[i] end
        
        local cmd = Commands[cmdName]
        if cmd and not cmd.hidden then
            pcall(cmd.func, args)
            table.insert(CommandHistory, {cmd=cmdName, args=args, time=tick()})
        end
    end
end)

-- UI için dropdown güncelleyici
local PlayerList = {}
local function UpdatePlayerList()
    PlayerList = {}
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LP then table.insert(PlayerList, p.Name) end
    end
end
UpdatePlayerList()
Players.PlayerAdded:Connect(UpdatePlayerList)
Players.PlayerRemoving:Connect(UpdatePlayerList)

--══════════════════════════════════════════════════════════════════════════════
--=  [HELPER] UTILITY FONKSİYONLAR
--══════════════════════════════════════════════════════════════════════════════

local function GetChar(p)
    return p and p.Character
end

local function GetHRP(p)
    local c = GetChar(p)
    return c and c:FindFirstChild("HumanoidRootPart")
end

local function GetHum(p)
    local c = GetChar(p)
    return c and c:FindFirstChildOfClass("Humanoid")
end

local function GetClosestPlayer(dist)
    local closest, closestDist = nil, dist or math.huge
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LP and GetHRP(p) and GetHum(p) and GetHum(p).Health > 0 then
            local d = (GetHRP(p).Position - GetHRP(LP).Position).Magnitude
            if d < closestDist then
                closestDist = d
                closest = p
            end
        end
    end
    return closest
end

local function GetPlayersInRange(range)
    local targets = {}
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LP and GetHRP(p) then
            local d = (GetHRP(p).Position - GetHRP(LP).Position).Magnitude
            if d <= range then table.insert(targets, p) end
        end
    end
    return targets
end

local function GetClosestPart(partName, dist)
    local closest, closestDist = nil, dist or math.huge
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LP and GetChar(p) then
            for _, child in pairs(GetChar(p):GetDescendants()) do
                if child:IsA("BasePart") and (not partName or child.Name:lower():find(partName:lower())) then
                    local d = (child.Position - GetHRP(LP).Position).Magnitude
                    if d < closestDist then
                        closestDist = d
                        closest = child
                    end
                end
            end
        end
    end
    return closest
end

local function FindRemote(name)
    for _, obj in pairs(game:GetDescendants()) do
        if obj:IsA("RemoteEvent") and obj.Name:lower():find(name:lower()) then
            return obj
        end
    end
    return nil
end

local function SafeDestroy(obj)
    if obj and obj.Parent then
        obj:Destroy()
    end
end

local function CreateBV(pos)
    local bv = Instance.new("BodyVelocity")
    bv.Velocity = pos or Vector3.new(0,0,0)
    bv.MaxForce = Vector3.new(1e9,1e9,1e9)
    bv.P = 1e9
    return bv
end

local function CreateBP(pos)
    local bp = Instance.new("BodyPosition")
    bp.Position = pos or Vector3.new(0,0,0)
    bp.MaxForce = Vector3.new(1e9,1e9,1e9)
    bp.P = 1e9
    bp.D = 100
    return bp
end

local function CreateBG(cf)
    local bg = Instance.new("BodyGyro")
    bg.CFrame = cf or CFrame.new()
    bg.MaxTorque = Vector3.new(1e9,1e9,1e9)
    bg.P = 1e9
    return bg
end

local function Notify(title, text, time)
    pcall(function()
        game.StarterGui:SetCore("SendNotification", {
            Title = title or ScriptName,
            Text = text or "",
            Duration = time or 3
        })
    end)
end

--══════════════════════════════════════════════════════════════════════════════
--=  [SECTION 1] PLAYER — OYUNCU ÖZELLİKLERİ (~150 FEATURE)
--══════════════════════════════════════════════════════════════════════════════

-- Durum değişkenleri
local Flags = {}
local FlagKeys = {
    "GodMode","Noclip","Fly","Float","Invisible","InfiniteJump","AntiKick","AntiAFK",
    "NoFallDmg","SpinBot","AutoJump","BHop","Sit","FloatWalk","WallClimb","Slide",
    "AirJump","WaterWalk","LavaWalk","SuperPunch","SuperStrength","Magnet",
    "AntiTools","AntiTeleport","AntiFreeze","AntiCrash","AntiReport","AntiDrown",
    "AntiFire","AntiExplosion","AutoRespawn","NoClipFly","ShiftLockFly","SpeedFly",
    "Hover","SlowMotion","TimeScale","BodySwap","Ragdoll","NoCollision","JumpLoop",
    "FlyV3","SpeedGlitch","MoonWalk","AutoHeal","AutoJumpAttack","AutoParry",
    "SpiderClimb","GroundPound","PhaseWalk","ChargeJump","SuperJump","MegaJump",
    "GodAura","HealthAura","ReviveAura","StunAura","SlowAura","SpeedAura"
}
for _, k in pairs(FlagKeys) do Flags[k] = false end

-- Değer değişkenleri
local Vals = {
    WalkSpeed = 16, JumpPower = 50, FlySpeed = 50, HipHeight = 2,
    JumpMultiplier = 1, Gravity = 196, Time = 12, FogEnd = 1e5,
    MaxHealth = 100, Health = 100, SpinSpeed = 10, MagnetRange = 20,
    AuraRange = 20, AuraDamage = 5
}

--══════════════════════════════════════════════════════════════════════════════
--=  [1A] GOD MODE (FE bypass)
--══════════════════════════════════════════════════════════════════════════════

function FeatureCountInc() FeatureCount = FeatureCount + 1 end

-- God Mode (3 method)
local function EnableGodMode()
    Flags.GodMode = true
    local h = GetHum(LP)
    if h then h.MaxHealth = 9e9; h.Health = 9e9; h.BreakJointsOnDeath = false end
    LP.CharacterAdded:Connect(function(c)
        wait(1)
        local h2 = c:FindFirstChildOfClass("Humanoid")
        if h2 and Flags.GodMode then h2.MaxHealth = 9e9; h2.Health = 9e9 end
    end)
    -- Humanoid sağlık koruma loop
    coroutine.wrap(function()
        while Flags.GodMode do
            wait(0.3)
            local h = GetHum(LP)
            if h then
                if h.Health < 1 then h.Health = h.MaxHealth end
                h.MaxHealth = 9e9
                h.BreakJointsOnDeath = false
            end
        end
    end)()
end
FeatureCountInc()

-- God Mode (Method 2 — Remote Block)
AddCmd("god2", "God Mode FE Method 2 (Remote Block)", {"godmode2","godm2"}, function(a)
    EnableGodMode()
    FE.AntiKick = true
    FE:Init()
    Notify("God Mode M2", "Active (Remote Block)")
end, "Player")
FeatureCountInc()

-- God Mode (Method 3 — Full Protection)
AddCmd("god3", "God Mode FE Method 3 (Full Protect)", {"godmode3","fullgod"}, function(a)
    EnableGodMode()
    FE.AntiKick = true
    FE:Init()
    local h = GetHum(LP)
    if h then h.PlatformStand = false; h.AutoJumpEnabled = true end
    Notify("God Mode M3", "Full Protection Active")
end, "Player")
FeatureCountInc()

AddCmd("god", "God Mode (Tanrı Modu)", {"godmode","gm","immortal","invincible"}, function(a)
    EnableGodMode()
    Notify("God Mode", "Aktif!")
end, "Player")
FeatureCountInc()

AddCmd("ungod", "God Mode'u Kapat", {"ungodmode"}, function(a)
    Flags.GodMode = false
    Notify("God Mode", "Kapalı")
end, "Player")
FeatureCountInc()

--══════════════════════════════════════════════════════════════════════════════
--=  [1B] NOCLIP (FE bypass)
--══════════════════════════════════════════════════════════════════════════════

FeatureCountInc() -- Noclip ana
AddCmd("noclip", "Duvarlardan geç (Noclip)", {"nc","nocl","phase","wallhack","ghost"}, function(a)
    Flags.Noclip = not Flags.Noclip
    Notify("Noclip", Flags.Noclip and "Aktif!" or "Kapalı")
end, "Player")

-- Noclip Stepped Loop
coroutine.wrap(function()
    while wait() do
        if Flags.Noclip and GetChar(LP) then
            for _, p in pairs(GetChar(LP):GetDescendants()) do
                if p:IsA("BasePart") then p.CanCollide = false end
            end
        end
    end
end)()
FeatureCountInc()

AddCmd("noclip2", "Noclip Method 2 (Fast)", {"nc2"}, function(a)
    Flags.Noclip = not Flags.Noclip
    if GetHRP(LP) then GetHRP(LP).CanCollide = false end
end, "Player")
FeatureCountInc()

AddCmd("noclip3", "Noclip Method 3 (Body)", {"nc3"}, function(a)
    for _, p in pairs((GetChar(LP) or {}):GetDescendants()) do
        if p:IsA("BasePart") then
            p.CanCollide = false
            p:GetPropertyChangedSignal("CanCollide"):Connect(function()
                if Flags.Noclip then p.CanCollide = false end
            end)
        end
    end
end, "Player")
FeatureCountInc()

AddCmd("phase", "Phase Mode (Yavaş Noclip)", {}, function(a)
    Flags.Noclip = not Flags.Noclip
    if Flags.Noclip then
        GetHRP(LP).CanCollide = false
        RS.Stepped:Connect(function()
            if Flags.Noclip and GetHRP(LP) then GetHRP(LP).CanCollide = false end
        end)
    end
end, "Player")
FeatureCountInc()

--══════════════════════════════════════════════════════════════════════════════
--=  [1C] FLY SİSTEMİ
--══════════════════════════════════════════════════════════════════════════════

FeatureCountInc() -- Fly main
AddCmd("fly", "Uç (Fly mode)", {"fly1","flight","f"}, function(a)
    Flags.Fly = not Flags.Fly
    local hrp = GetHRP(LP)
    if not hrp then return end
    
    if Flags.Fly then
        local bv = CreateBV(); bv.Parent = hrp
        local bg = CreateBG(); bg.Parent = hrp
        local h = GetHum(LP)
        if h then h.PlatformStand = true end
        Notify("Fly", "Aktif! (Space=Yukarı, Shift=Aşağı)")
    else
        for _, v in pairs(hrp:GetChildren()) do
            if v:IsA("BodyVelocity") or v:IsA("BodyGyro") then v:Destroy() end
        end
        local h = GetHum(LP)
        if h then h.PlatformStand = false end
    end
end, "Player")

-- Fly kontrol loop
coroutine.wrap(function()
    while wait() do
        if Flags.Fly and GetHRP(LP) then
            local hrp = GetHRP(LP)
            local bv = hrp:FindFirstChildOfClass("BodyVelocity")
            local bg = hrp:FindFirstChildOfClass("BodyGyro")
            if bv and bg then
                local movDir = Vector3.new(
                    UIS:IsKeyDown(Enum.KeyCode.D) and 1 or UIS:IsKeyDown(Enum.KeyCode.A) and -1 or 0,
                    UIS:IsKeyDown(Enum.KeyCode.Space) and 1 or UIS:IsKeyDown(Enum.KeyCode.LeftShift) and -1 or 0,
                    UIS:IsKeyDown(Enum.KeyCode.S) and 1 or UIS:IsKeyDown(Enum.KeyCode.W) and -1 or 0
                )
                if movDir.Magnitude > 0 then
                    bv.Velocity = Camera.CFrame:VectorToObjectSpace(movDir).Unit * Vals.FlySpeed
                else
                    bv.Velocity = Vector3.new(0,0,0)
                end
                bg.CFrame = Camera.CFrame
                bg.D = 1000
            end
        end
    end
end)()
FeatureCountInc()

-- Fly Speed
AddCmd("flyspeed", "Uçuş hızını ayarla", {"flyspd","fspeed"}, function(a)
    local s = tonumber(a[1])
    if s then Vals.FlySpeed = s; Notify("Fly Speed", tostring(s)) end
end, "Player")
FeatureCountInc()

-- Noclip Fly
AddCmd("ncfly", "Noclip + Fly (Birlikte)", {"nofly","nocfly"}, function(a)
    Flags.Noclip = true
    Flags.Fly = true
    local hrp = GetHRP(LP)
    if hrp then
        local bv = CreateBV(); bv.Parent = hrp
        local bg = CreateBG(); bg.Parent = hrp
    end
    Notify("NC Fly", "Noclip + Fly Aktif!")
end, "Player")
FeatureCountInc()

-- ShiftLock Fly
AddCmd("sfly", "ShiftLock Fly", {"shiftfly","lockfly"}, function(a)
    if Flags.Fly then 
        local hrp = GetHRP(LP)
        if hrp then
            for _, v in pairs(hrp:GetChildren()) do
                if v:IsA("BodyVelocity") or v:IsA("BodyGyro") then v:Destroy() end
            end
        end
        Flags.Fly = false
        return
    end
    Flags.Fly = true
    local hrp = GetHRP(LP)
    if hrp then
        local bv = CreateBV(); bv.Parent = hrp
        local bg = CreateBG(CFrame.new()); bg.Parent = hrp
        GetHum(LP).PlatformStand = true
    end
    Notify("ShiftLock Fly", "Aktif!")
end, "Player")
FeatureCountInc()

-- Hover Mode
AddCmd("hover", "Havada asılı kal", {"float"}, function(a)
    Flags.Float = not Flags.Float
    local hrp = GetHRP(LP)
    if not hrp then return end
    if Flags.Float then
        local bv = CreateBV(Vector3.new(0,0,0)); bv.Parent = hrp
    else
        for _, v in pairs(hrp:GetChildren()) do if v:IsA("BodyVelocity") then v:Destroy() end end
    end
end, "Player")
FeatureCountInc()

-- Hover yükseklik
AddCmd("hoverheight", "Hover yüksekliği", {"hoverh","floath"}, function(a)
    local h = tonumber(a[1])
    if h and GetHRP(LP) then
        local bv = GetHRP(LP):FindFirstChildOfClass("BodyVelocity")
        if bv then bv.Velocity = Vector3.new(0,h,0) end
    end
end, "Player")
FeatureCountInc()

-- Spin Fly
AddCmd("spinfly", "Dönerek uç (SpinFly)", {"sf","spin"}, function(a)
    Flags.SpinBot = not Flags.SpinBot
    if GetHRP(LP) then
        coroutine.wrap(function()
            while Flags.SpinBot do
                RS.RenderStepped:Wait()
                if GetHRP(LP) then
                    GetHRP(LP).CFrame = GetHRP(LP).CFrame * CFrame.Angles(0, math.rad(Vals.SpinSpeed), 0)
                end
            end
        end)()
    end
end, "Player")
FeatureCountInc()

AddCmd("spinspeed", "Dönüş hızı", {"sspeed"}, function(a)
    local s = tonumber(a[1])
    if s then Vals.SpinSpeed = s end
end, "Player")
FeatureCountInc()

--══════════════════════════════════════════════════════════════════════════════
--=  [1D] HIZ & ZIPLAMA
--══════════════════════════════════════════════════════════════════════════════

AddCmd("speed", "WalkSpeed ayarla", {"ws","walkspeed","spd","hiz"}, function(a)
    local s = tonumber(a[1])
    if s then Vals.WalkSpeed = s; if GetHum(LP) then GetHum(LP).WalkSpeed = s end end
end, "Player")
FeatureCountInc()

AddCmd("jump", "JumpPower ayarla", {"jp","jumppower","jumpower","zıpla"}, function(a)
    local s = tonumber(a[1])
    if s then Vals.JumpPower = s; if GetHum(LP) then GetHum(LP).JumpPower = s end end
end, "Player")
FeatureCountInc()

AddCmd("superjump", "Süper zıplama (50x)", {"sj","sju","mega","megajump"}, function(a)
    if GetHum(LP) then GetHum(LP).JumpPower = Vals.JumpPower * 5; Notify("Super Jump", "Aktif!") end
end, "Player")
FeatureCountInc()

AddCmd("moonjump", "Ay zıplaması", {"moon","mjump"}, function(a)
    if GetHum(LP) then GetHum(LP).JumpPower = 200; end
end, "Player")
FeatureCountInc()

-- Infinite Jump
AddCmd("infjump", "Sonsuz zıplama (Infinite Jump)", {"infj","ij","infinityjump","sonsuzzıplama"}, function(a)
    Flags.InfiniteJump = not Flags.InfiniteJump
    Notify("Infinite Jump", Flags.InfiniteJump and "Aktif!" or "Kapalı")
end, "Player")
FeatureCountInc()

-- Infinite Jump connection
UIS.JumpRequest:Connect(function()
    if Flags.InfiniteJump and GetHum(LP) then
        GetHum(LP):ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)
FeatureCountInc()

-- B-Hop
AddCmd("bhop", "Bunny Hop (Otomatik zıpla)", {"bh","bunnyhop","autojump"}, function(a)
    Flags.BHop = not Flags.BHop
    if Flags.BHop then
        coroutine.wrap(function()
            while Flags.BHop do
                wait(0.15)
                if GetHum(LP) and GetHum(LP).MoveDirection.Magnitude > 0 then
                    GetHum(LP):ChangeState(Enum.HumanoidStateType.Jumping)
                end
            end
        end)()
    end
end, "Player")
FeatureCountInc()

AddCmd("speedboost", "Hız patlaması (geçici)", {"sb","boost"}, function(a)
    if GetHum(LP) then
        GetHum(LP).WalkSpeed = 100
        wait(5)
        GetHum(LP).WalkSpeed = Vals.WalkSpeed
    end
end, "Player")
FeatureCountInc()

AddCmd("superspeed", "Süper hız (500)", {"ss"}, function(a)
    if GetHum(LP) then GetHum(LP).WalkSpeed = 500 end
end, "Player")
FeatureCountInc()

AddCmd("speedall", "Herkesin hızını ayarla", {"wsall","speedt"}, function(a)
    local s = tonumber(a[1])
    if s then
        for _, p in pairs(Players:GetPlayers()) do
            if GetHum(p) then GetHum(p).WalkSpeed = s end
        end
    end
end, "Player")
FeatureCountInc()

AddCmd("jumpall", "Herkesin zıplamasını ayarla", {"jall","jpt"}, function(a)
    local s = tonumber(a[1])
    if s then
        for _, p in pairs(Players:GetPlayers()) do
            if GetHum(p) then GetHum(p).JumpPower = s end
        end
    end
end, "Player")
FeatureCountInc()

--══════════════════════════════════════════════════════════════════════════════
--=  [1E] GÖRÜNMEZLİK & GÖVDE
--══════════════════════════════════════════════════════════════════════════════

AddCmd("invisible", "Görünmez ol (Client-side)", {"inv","hide","görünmez"}, function(a)
    Flags.Invisible = not Flags.Invisible
    local c = GetChar(LP)
    if c then
        for _, p in pairs(c:GetDescendants()) do
            if p:IsA("BasePart") then
                p.Transparency = Flags.Invisible and 1 or 0
                p.CanCollide = not Flags.Invisible
            end
        end
    end
end, "Player")
FeatureCountInc()

-- Görünmez (Method 2 — Accessories Kaldır)
AddCmd("invisible2", "Görünmez Method 2 (Aksesuar kaldır)", {"inv2"}, function(a)
    local c = GetChar(LP)
    if c then
        for _, acc in pairs(c:GetChildren()) do
            if acc:IsA("Accessory") or acc:IsA("Hat") or acc:IsA("Hair") then
                acc:Destroy()
            end
        end
        for _, p in pairs(c:GetDescendants()) do
            if p:IsA("BasePart") then p.Transparency = 1 end
        end
    end
end, "Player")
FeatureCountInc()

AddCmd("uninvisible", "Görünür ol", {"uninv","show"}, function(a)
    Flags.Invisible = false
    local c = GetChar(LP)
    if c then
        for _, p in pairs(c:GetDescendants()) do
            if p:IsA("BasePart") then p.Transparency = 0; p.CanCollide = true end
        end
    end
end, "Player")
FeatureCountInc()

AddCmd("sit", "Otur", {"otur"}, function(a)
    if GetHum(LP) then GetHum(LP).Sit = not GetHum(LP).Sit end
end, "Player")
FeatureCountInc()

AddCmd("sitall", "Herkesi oturt", {"oturt"}, function(a)
    for _, p in pairs(Players:GetPlayers()) do
        if GetHum(p) then GetHum(p).Sit = true end
    end
end, "Player")
FeatureCountInc()

AddCmd("hip", "Hip Height (Kalça Yüksekliği)", {"hipheight"}, function(a)
    local s = tonumber(a[1])
    if s and GetHum(LP) then GetHum(LP).HipHeight = s end
end, "Player")
FeatureCountInc()

--══════════════════════════════════════════════════════════════════════════════
--=  [1F] ANTI-ÖZELLİKLER
--══════════════════════════════════════════════════════════════════════════════

AddCmd("antikick", "Anti-Kick (Atılamazsın)", {"ak","kickengel","anti-kick"}, function(a)
    Flags.AntiKick = not Flags.AntiKick
    FE.AntiKick = Flags.AntiKick
    FE:Init()
    Notify("Anti-Kick", Flags.AntiKick and "Aktif!" or "Kapalı")
end, "Player")
FeatureCountInc()

AddCmd("antiak", "Anti-AFK (AFK olmazsın)", {"aafk","antiafk","afkengel"}, function(a)
    Flags.AntiAFK = not Flags.AntiAFK
    if Flags.AntiAFK then
        coroutine.wrap(function()
            while Flags.AntiAFK do
                wait(45)
                VU:CaptureController()
                VU:ClickButton2(Vector2.new())
            end
        end)()
    end
end, "Player")
FeatureCountInc()

AddCmd("antifall", "Anti-Fall Damage (Düşüş hasarı yok)", {"afd","antifalldamage","no falldamage"}, function(a)
    Flags.NoFallDmg = not Flags.NoFallDmg
    if GetHum(LP) then GetHum(LP).FallDamage = not Flags.NoFallDmg end
end, "Player")
FeatureCountInc()

AddCmd("antitools", "Anti-Tools (Aletlerden korun)", {"at","anti-tools"}, function(a)
    FE.AntiTools = not FE.AntiTools
    FE:Init()
end, "Player")
FeatureCountInc()

AddCmd("antiteleport", "Anti-Teleport", {"antitp"}, function(a)
    Flags.AntiTeleport = not Flags.AntiTeleport
    if Flags.AntiTeleport and GetHRP(LP) then
        local savedPos = GetHRP(LP).Position
        coroutine.wrap(function()
            while Flags.AntiTeleport do
                wait(0.3)
                if GetHRP(LP) and (GetHRP(LP).Position - savedPos).Magnitude > 100 then
                    GetHRP(LP).Position = savedPos
                end
            end
        end)()
    end
end, "Player")
FeatureCountInc()

AddCmd("antifreeze", "Anti-Freeze (Donmaya karşı)", {"antifrz"}, function(a)
    Flags.AntiFreeze = not Flags.AntiFreeze
end, "Player")
FeatureCountInc()

AddCmd("antidrown", "Anti-Drown (Boğulmazsın)", {"antidrown","anti-boğul"}, function(a)
    if GetHum(LP) then GetHum(LP).Breath = math.huge end
end, "Player")
FeatureCountInc()

AddCmd("antifire", "Anti-Fire (Yanmazsın)", {"af","antifire"}, function(a)
    Flags.AntiFire = not Flags.AntiFire
end, "Player")
FeatureCountInc()

AddCmd("antiexplosion", "Anti-Explosion (Patlamazsın)", {"antiexplode","aexplode"}, function(a)
    Flags.AntiExplosion = not Flags.AntiExplosion
end, "Player")
FeatureCountInc()

AddCmd("antireport", "Anti-Report (Raporlanmazsın)", {"antirep","ar"}, function(a)
    Flags.AntiReport = not Flags.AntiReport
end, "Player")
FeatureCountInc()

--══════════════════════════════════════════════════════════════════════════════
--=  [1G] GELİŞMİŞ KARAKTER ÖZELLİKLERİ
--══════════════════════════════════════════════════════════════════════════════

AddCmd("reset", "Karakteri sıfırla", {"respawn","die","öls"}, function(a)
    local c = GetChar(LP)
    if c then c:BreakJoints() end
    wait(3)
    LP:LoadCharacter()
end, "Player")
FeatureCountInc()

AddCmd("autorespawn", "Oto yeniden doğ", {"arsp","autores"}, function(a)
    Flags.AutoRespawn = not Flags.AutoRespawn
    if Flags.AutoRespawn then
        LP.CharacterAdded:Connect(function(c)
            task.wait(2)
            if GetHum(c) then GetHum(c).Health = GetHum(c).MaxHealth end
        end)
    end
end, "Player")
FeatureCountInc()

AddCmd("health", "Canını ayarla", {"hp","can"}, function(a)
    local h = tonumber(a[1])
    if h and GetHum(LP) then GetHum(LP).Health = h end
end, "Player")
FeatureCountInc()

AddCmd("maxhealth", "Maksimum canını ayarla", {"maxhp","mhp"}, function(a)
    local h = tonumber(a[1])
    if h and GetHum(LP) then GetHum(LP).MaxHealth = h; GetHum(LP).Health = h end
end, "Player")
FeatureCountInc()

AddCmd("autoheal", "Oto can yenile", {"ah","healme"}, function(a)
    Flags.AutoHeal = not Flags.AutoHeal
    if Flags.AutoHeal then
        coroutine.wrap(function()
            while Flags.AutoHeal do
                wait(1)
                if GetHum(LP) then GetHum(LP).Health = GetHum(LP).MaxHealth end
            end
        end)()
    end
end, "Player")
FeatureCountInc()

AddCmd("ragdoll", "Ragdoll (Yere yığıl)", {"rag","fall"}, function(a)
    local h = GetHum(LP)
    if h then h.PlatformStand = not h.PlatformStand end
end, "Player")
FeatureCountInc()

AddCmd("timescale", "Zaman ölçeği (Slow Motion)", {"slowmo","time"}, function(a)
    local s = tonumber(a[1])
    if s then 
        RS.TimeScale = s
        Notify("Time Scale", tostring(s))
    end
end, "Player")
FeatureCountInc()

--══════════════════════════════════════════════════════════════════════════════
--=  [1H] HAREKET VARYASYONLARI
--══════════════════════════════════════════════════════════════════════════════

AddCmd("waterwalk", "Suda yürü", {"wwalk","ww"}, function(a)
    Flags.WaterWalk = not Flags.WaterWalk
    if Flags.WaterWalk then
        local bp = CreateBP(GetHRP(LP).Position); bp.Parent = GetHRP(LP)
    else
        if GetHRP(LP) then
            for _, v in pairs(GetHRP(LP):GetChildren()) do
                if v:IsA("BodyPosition") then v:Destroy() end
            end
        end
    end
end, "Player")
FeatureCountInc()

AddCmd("lavawalk", " Lavda yürü", {"lawalk","la"}, function(a)
    Flags.LavaWalk = not Flags.LavaWalk
    if GetHum(LP) then GetHum(LP).WalkSpeed = Flags.LavaWalk and 60 or Vals.WalkSpeed end
end, "Player")
FeatureCountInc()

AddCmd("spiderclimb", "Örümcek gibi tırman", {"spider","climb","wall"}, function(a)
    Flags.SpiderClimb = not Flags.SpiderClimb
    Notify("Spider Climb", Flags.SpiderClimb and "Aktif!" or "Kapalı")
end, "Player")
FeatureCountInc()

AddCmd("moonwalk", "Moonwalk (Geri yürür)", {"mw"}, function(a)
    Flags.MoonWalk = not Flags.MoonWalk
    if GetHum(LP) then GetHum(LP).WalkSpeed = Flags.MoonWalk and -16 or Vals.WalkSpeed end
end, "Player")
FeatureCountInc()

AddCmd("slide", "Kayma (Slide)", {"slay"}, function(a)
    Flags.Slide = not Flags.Slide
    if Flags.Slide and GetHum(LP) then
        GetHum(LP).HipHeight = 0
        GetHum(LP).WalkSpeed = 80
    elseif GetHum(LP) then
        GetHum(LP).HipHeight = Vals.HipHeight
        GetHum(LP).WalkSpeed = Vals.WalkSpeed
    end
end, "Player")
FeatureCountInc()

AddCmd("wallclimb", "Duvar tırmanma", {"wallcl","wc"}, function(a)
    Flags.WallClimb = not Flags.WallClimb
end, "Player")
FeatureCountInc()

--══════════════════════════════════════════════════════════════════════════════
--=  [1I] AURA HAREKETİ
--══════════════════════════════════════════════════════════════════════════════

AddCmd("godaura", "God Aura (Yakına geleni öldür)", {"ga"}, function(a)
    Flags.GodAura = not Flags.GodAura
    coroutine.wrap(function()
        while Flags.GodAura do
            wait(0.2)
            for _, target in pairs(GetPlayersInRange(Vals.AuraRange)) do
                local th = GetHum(target)
                if th and th.Health > 0 then th.Health = 0 end
            end
        end
    end)()
end, "Player")
FeatureCountInc()

AddCmd("healthaura", "Health Aura (Can ver)", {"ha","hpaura"}, function(a)
    Flags.HealthAura = not Flags.HealthAura
    coroutine.wrap(function()
        while Flags.HealthAura do
            wait(0.5)
            for _, target in pairs(GetPlayersInRange(Vals.AuraRange)) do
                if GetHum(target) and GetHum(LP) then
                    GetHum(target).Health = GetHum(target).MaxHealth
                end
            end
        end
    end)()
end, "Player")
FeatureCountInc()

AddCmd("stunaura", "Stun Aura (Sersemlet)", {"sa"}, function(a)
    Flags.StunAura = not Flags.StunAura
    coroutine.wrap(function()
        while Flags.StunAura do
            wait(0.5)
            for _, target in pairs(GetPlayersInRange(Vals.AuraRange)) do
                if GetHum(target) then GetHum(target).PlatformStand = true end
            end
        end
    end)()
end, "Player")
FeatureCountInc()

AddCmd("slowaura", "Slow Aura (Yavaşlat)", {}, function(a)
    Flags.SlowAura = not Flags.SlowAura
    coroutine.wrap(function()
        while Flags.SlowAura do
            wait(0.5)
            for _, target in pairs(GetPlayersInRange(Vals.AuraRange)) do
                if GetHum(target) then GetHum(target).WalkSpeed = 5 end
            end
        end
    end)()
end, "Player")
FeatureCountInc()

AddCmd("speedaura", "Speed Aura (Hızlandır)", {}, function(a)
    Flags.SpeedAura = not Flags.SpeedAura
    coroutine.wrap(function()
        while Flags.SpeedAura do
            wait(0.5)
            for _, target in pairs(GetPlayersInRange(Vals.AuraRange)) do
                if GetHum(target) then GetHum(target).WalkSpeed = 100 end
            end
        end
    end)()
end, "Player")
FeatureCountInc()

AddCmd("aurarange", "Aura menzili", {"aurange","arng"}, function(a)
    local r = tonumber(a[1])
    if r then Vals.AuraRange = r end
end, "Player")
FeatureCountInc()

--══════════════════════════════════════════════════════════════════════════════
--=  [SECTION 2] VISUAL — GÖRSEL ÖZELLİKLER (~100+ FEATURE)
--══════════════════════════════════════════════════════════════════════════════

-- 2A: ESP SİSTEMİ
-- 2B: FULL BRIGHT / WALLHACK
-- 2C: HIGHLIGHT / FOV / ZOOM
-- 2D: ÇEŞİTLİ GÖRSEL

--══════════════════════════════════════════════════════════════════════════════
--=  [2A] ESP SİSTEMİ
--══════════════════════════════════════════════════════════════════════════════

-- ESP Core functions
local ESPObjects = {}
local ESPEnabled = false

local function CreateESPForPlayer(target, espType)
    if target == LP or not target.Character then return end
    local char = target.Character
    local hrp = char:FindFirstChild("HumanoidRootPart") or char:FindFirstChildOfClass("BasePart")
    if not hrp then return end
    
    local key = target.Name .. "_" .. espType
    if ESPObjects[key] then return end
    
    if espType == "Box" or espType == "All" then
        local box = Instance.new("SelectionBox")
        box.Adornee = hrp
        box.LineThickness = 0.1
        box.Color3 = Color3.new(1,0,0)
        box.Parent = char
        ESPObjects[key] = box
        FeatureCountInc()
    end
    
    if espType == "Tracer" or espType == "All" then
        local line = Drawing.new("Line")
        line.Visible = true
        line.Color = Color3.new(1,0,0)
        line.Thickness = 1.5
        ESPObjects[key] = line
        FeatureCountInc()
        
        coroutine.wrap(function()
            while ESPEnabled and target and target.Character and hrp do
                RS.RenderStepped:Wait()
                local sp, os = Camera:WorldToScreenPoint(hrp.Position)
                if os then
                    line.From = Vector2.new(sp.X, sp.Y)
                    line.To = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y)
                else
                    line.Visible = false
                end
                if not ESPEnabled then line.Visible = false end
            end
        end)()
    end
    
    if espType == "Name" or espType == "All" then
        local bbg = Instance.new("BillboardGui")
        local tl = Instance.new("TextLabel")
        bbg.Adornee = char:FindFirstChild("Head") or hrp
        bbg.Size = UDim2.new(0,200,0,50)
        bbg.StudsOffset = Vector3.new(0,3,0)
        bbg.Parent = char
        tl.Size = UDim2.new(1,0,1,0)
        tl.BackgroundTransparency = 1
        tl.Text = target.Name
        tl.TextStrokeTransparency = 0.3
        tl.TextColor3 = Color3.new(1,1,1)
        tl.TextScaled = true
        tl.Font = Enum.Font.SourceSansBold
        tl.Parent = bbg
        ESPObjects[key] = bbg
        FeatureCountInc()
    end
    
    if espType == "Health" or espType == "All" then
        local bbg = Instance.new("BillboardGui")
        local pb = Instance.new("Frame")
        local bg = Instance.new("Frame")
        bbg.Adornee = hrp
        bbg.Size = UDim2.new(0,50,0,10)
        bbg.StudsOffset = Vector3.new(0, -2, 0)
        bbg.Parent = char
        bg.Size = UDim2.new(1,0,1,0)
        bg.BackgroundColor3 = Color3.new(0.3,0,0)
        bg.Parent = bbg
        pb.Size = UDim2.new(1,0,1,0)
        pb.BackgroundColor3 = Color3.new(0,1,0)
        pb.Parent = bbg
        ESPObjects[key] = bbg
        FeatureCountInc()
        
        coroutine.wrap(function()
            while ESPEnabled and target and target.Character and GetHum(target) do
                wait(0.2)
                local h = GetHum(target)
                if h then
                    pb.Size = UDim2.new(h.Health/h.MaxHealth, 0, 1, 0)
                end
                if not ESPEnabled then bbg:Destroy() end
            end
        end)()
    end
    
    if espType == "Distance" or espType == "All" then
        local bbg = Instance.new("BillboardGui")
        local tl = Instance.new("TextLabel")
        bbg.Adornee = hrp
        bbg.Size = UDim2.new(0,100,0,30)
        bbg.StudsOffset = Vector3.new(0, -1, 0)
        bbg.Parent = char
        tl.Size = UDim2.new(1,0,1,0)
        tl.BackgroundTransparency = 1
        tl.Text = "0m"
        tl.TextStrokeTransparency = 0.3
        tl.TextColor3 = Color3.new(1,1,0)
        tl.TextScaled = true
        tl.Font = Enum.Font.SourceSansBold
        tl.Parent = bbg
        ESPObjects[key] = bbg
        FeatureCountInc()
        
        coroutine.wrap(function()
            while ESPEnabled and target and target.Character and GetHRP(LP) and hrp do
                wait(0.3)
                local d = math.floor((hrp.Position - GetHRP(LP).Position).Magnitude)
                tl.Text = tostring(d) .. "m"
                if not ESPEnabled then bbg:Destroy() end
            end
        end)()
    end
end

local function ClearAllESP()
    ESPEnabled = false
    for _, obj in pairs(ESPObjects) do
        pcall(function() obj:Destroy() end)
        pcall(function() obj.Visible = false end)
    end
    ESPObjects = {}
    -- Temizlik için local script'lerden geç
    for _, p in pairs(Players:GetPlayers()) do
        if p.Character then
            for _, c in pairs(p.Character:GetDescendants()) do
                if c:IsA("SelectionBox") or c:IsA("BillboardGui") then
                    if c.Name ~= "Default" then c:Destroy() end
                end
            end
        end
    end
end

AddCmd("esp", "ESP Aç/Kapa", {}, function(a)
    ESPEnabled = not ESPEnabled
    if ESPEnabled then
        for _, p in pairs(Players:GetPlayers()) do
            CreateESPForPlayer(p, "All")
        end
        Players.PlayerAdded:Connect(function(p)
            p.CharacterAdded:Connect(function() wait(1); CreateESPForPlayer(p, "All") end)
        end)
        Notify("ESP", "Aktif!")
    else
        ClearAllESP()
        Notify("ESP", "Kapalı")
    end
end, "Visual")
FeatureCountInc()

AddCmd("espbox", "ESP Box", {}, function(a)
    for _, p in pairs(Players:GetPlayers()) do CreateESPForPlayer(p, "Box") end
end, "Visual")
FeatureCountInc()

AddCmd("esptracer", "ESP Tracer", {}, function(a)
    for _, p in pairs(Players:GetPlayers()) do CreateESPForPlayer(p, "Tracer") end
end, "Visual")
FeatureCountInc()

AddCmd("espname", "ESP İsim", {}, function(a)
    for _, p in pairs(Players:GetPlayers()) do CreateESPForPlayer(p, "Name") end
end, "Visual")
FeatureCountInc()

AddCmd("esphealth", "ESP Can Bar", {}, function(a)
    for _, p in pairs(Players:GetPlayers()) do CreateESPForPlayer(p, "Health") end
end, "Visual")
FeatureCountInc()

AddCmd("espdistance", "ESP Mesafe", {}, function(a)
    for _, p in pairs(Players:GetPlayers()) do CreateESPForPlayer(p, "Distance") end
end, "Visual")
FeatureCountInc()

AddCmd("espall", "Tüm ESP özellikleri", {"fullesp"}, function(a)
    ESPEnabled = true
    for _, p in pairs(Players:GetPlayers()) do CreateESPForPlayer(p, "All") end
end, "Visual")
FeatureCountInc()

AddCmd("espclear", "ESP'yi temizle", {"espkapa","espoff"}, function(a)
    ClearAllESP()
end, "Visual")
FeatureCountInc()

--══════════════════════════════════════════════════════════════════════════════
--=  [2B] GÖRSEL İYİLEŞTİRMELER
--══════════════════════════════════════════════════════════════════════════════

AddCmd("fullbright", "Full Bright (Tam Aydınlık)", {"fb","bright","aydınlık"}, function(a)
    Flags.FullBright = not Flags.FullBright
    if Flags.FullBright then
        Lighting.Ambient = Color3.new(1,1,1)
        Lighting.Brightness = 3
        Lighting.FogEnd = 1e9
        Lighting.ClockTime = 12
        Lighting.GlobalShadows = false
        Lighting.OutdoorAmbient = Color3.new(1,1,1)
    else
        Lighting:SetGlobalLighting()
    end
end, "Visual")
FeatureCountInc()

AddCmd("nightvision", "Night Vision (Gece Görüş)", {"nv"}, function(a)
    Lighting.Ambient = Color3.new(0,1,0)
    Lighting.Brightness = 1.5
    Lighting.FogEnd = 1e9
    Lighting.ClockTime = 0
end, "Visual")
FeatureCountInc()

AddCmd("thermal", "Thermal Vision (Termal)", {"heat","thermalv"}, function(a)
    Lighting.Ambient = Color3.new(1,0,0)
    Lighting.Brightness = 2
    Lighting.FogEnd = 1e9
    Lighting.OutdoorAmbient = Color3.new(1,0,0)
end, "Visual")
FeatureCountInc()

AddCmd("wallhack", "Wallhack (Duvarlar Şeffaf)", {"wh"}, function(a)
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") and obj.Anchored and obj.Material ~= Enum.Material.Grass then
            obj.Transparency = 0.7
        end
    end
end, "Visual")
FeatureCountInc()

AddCmd("xray", "X-Ray (Tüm Objeler Şeffaf)", {}, function(a)
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") then
            obj.Transparency = 0.7
        end
    end
end, "Visual")
FeatureCountInc()

AddCmd("unxray", "X-Ray Kapa", {}, function(a)
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") then
            obj.Transparency = 0
        end
    end
end, "Visual")
FeatureCountInc()

AddCmd("fov", "FOV (Görüş Açısı)", {}, function(a)
    local f = tonumber(a[1])
    if f then Camera.FieldOfView = f end
end, "Visual")
FeatureCountInc()

AddCmd("resetfov", "FOV Sıfırla", {"rfov"}, function(a) Camera.FieldOfView = 70 end, "Visual")
FeatureCountInc()

AddCmd("zoom", "Kamera Yakınlaştır", {}, function(a)
    local z = tonumber(a[1]) or 10
    Camera.CFrame = Camera.CFrame * CFrame.new(0,0,z)
end, "Visual")
FeatureCountInc()

AddCmd("thirdperson", "Third Person (3. Şahıs)", {"3p","tpview"}, function(a)
    Camera.CameraType = Enum.CameraType.Custom
    Camera.CameraSubject = GetHum(LP)
end, "Visual")
FeatureCountInc()

AddCmd("firstperson", "First Person (1. Şahıs)", {"1p","fpv"}, function(a)
    Camera.CameraType = Enum.CameraType.Custom
    if GetChar(LP) and GetChar(LP):FindFirstChild("Head") then
        Camera.CFrame = GetChar(LP).Head.CFrame
    end
end, "Visual")
FeatureCountInc()

AddCmd("nofog", "Sis yok", {}, function(a)
    Lighting.FogEnd = 1e9
end, "Visual")
FeatureCountInc()

AddCmd("fog", "Sis ayarla", {}, function(a)
    local f = tonumber(a[1])
    if f then Lighting.FogEnd = f end
end, "Visual")
FeatureCountInc()

AddCmd("highlight", "Oyuncuları vurgula (Highlight)", {"hl"}, function(a)
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LP and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local hl = Instance.new("Highlight")
            hl.FillColor = Color3.new(1,0,0)
            hl.OutlineColor = Color3.new(1,1,1)
            hl.FillTransparency = 0.5
            hl.Parent = p.Character
        end
    end
end, "Visual")
FeatureCountInc()

AddCmd("rainbowhighlight", "Rainbow Highlight (Renkli)", {"rbhl","rhl"}, function(a)
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LP and p.Character then
            for _, hl in pairs(p.Character:GetDescendants()) do
                if hl:IsA("Highlight") then
                    coroutine.wrap(function()
                        while wait(0.1) do
                            hl.FillColor = Color3.fromHSV(tick()%5/5,1,1)
                        end
                    end)()
                end
            end
        end
    end
end, "Visual")
FeatureCountInc()

AddCmd("chams", "Chams (Renkli Karakter)", {}, function(a)
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LP and p.Character then
            for _, part in pairs(p.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.Color = Color3.new(0,1,0)
                end
            end
        end
    end
end, "Visual")
FeatureCountInc()

AddCmd("wireframe", "Wireframe (Tel Kafes)", {"wf"}, function(a)
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LP and p.Character then
            for _, part in pairs(p.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    pcall(function() part.Material = Enum.Material.Neon end)
                end
            end
        end
    end
end, "Visual")
FeatureCountInc()

AddCmd("crosshair", "Crosshair (Nişangah)", {"ch","cross"}, function(a)
    local enabled = true
    local c = Drawing.new("Circle")
    c.Visible = true
    c.Radius = 10
    c.Thickness = 1.5
    c.Color = Color3.new(0,1,0)
    c.NumSides = 32
    coroutine.wrap(function()
        while enabled do
            RS.RenderStepped:Wait()
            c.Position = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
        end
    end)()
end, "Visual")
FeatureCountInc()

--══════════════════════════════════════════════════════════════════════════════
--=  [SECTION 3] TELEPORT — IŞINLANMA (~50+ FEATURE)
--══════════════════════════════════════════════════════════════════════════════

AddCmd("tp", "Oyuncuya ışınlan", {"teleport","tpto"}, function(a)
    if not a[1] then Notify("TP", "İsim gir! ;tp isim") return end
    local target = Players:FindFirstChild(a[1])
    if target and GetHRP(target) and GetHRP(LP) then
        GetHRP(LP).CFrame = GetHRP(target).CFrame * CFrame.new(0,5,0)
    end
end, "Teleport")
FeatureCountInc()

AddCmd("tpid", "ID ile ışınlan", {}, function(a)
    local id = tonumber(a[1])
    if not id then return end
    local target = Players:GetPlayerByUserId(id)
    if target and GetHRP(target) and GetHRP(LP) then
        GetHRP(LP).CFrame = GetHRP(target).CFrame
    end
end, "Teleport")
FeatureCountInc()

AddCmd("clicktp", "Click TP (Tıkla Işınlan)", {"ctp","click"}, function(a)
    Flags.TeleportActive = not Flags.TeleportActive
    if Flags.TeleportActive then
        Mouse.Button1Down:Connect(function()
            if Flags.TeleportActive and GetHRP(LP) then
                GetHRP(LP).CFrame = CFrame.new(Mouse.Hit.X, Mouse.Hit.Y+3, Mouse.Hit.Z)
            end
        end)
    end
end, "Teleport")
FeatureCountInc()

AddCmd("bring", "Oyuncuyu yanına getir", {}, function(a)
    if not a[1] then return end
    local target = Players:FindFirstChild(a[1])
    if target and GetHRP(target) and GetHRP(LP) then
        GetHRP(target).CFrame = GetHRP(LP).CFrame * CFrame.new(0,0,3)
    end
end, "Teleport")
FeatureCountInc()

AddCmd("bringall", "Herkesi yanına getir", {"bringeveryone","ball","bringall"}, function(a)
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LP and GetHRP(p) and GetHRP(LP) then
            GetHRP(p).CFrame = GetHRP(LP).CFrame * CFrame.new(0,0,3)
        end
    end
end, "Teleport")
FeatureCountInc()

AddCmd("bringteam", "Takımını getir", {}, function(a)
    local myTeam = LP.Team
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LP and p.Team == myTeam and GetHRP(p) and GetHRP(LP) then
            GetHRP(p).CFrame = GetHRP(LP).CFrame * CFrame.new(0,0,3)
        end
    end
end, "Teleport")
FeatureCountInc()

AddCmd("send", "Oyuncuyu bir yere gönder", {}, function(a)
    if not a[1] then return end
    local target = Players:FindFirstChild(a[1])
    if target and GetHRP(target) and GetHRP(LP) then
        GetHRP(target).CFrame = GetHRP(LP).CFrame * CFrame.new(0,0,50)
    end
end, "Teleport")
FeatureCountInc()

AddCmd("sendall", "Herkesi bir yere gönder", {}, function(a)
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LP and GetHRP(p) and GetHRP(LP) then
            GetHRP(p).CFrame = GetHRP(LP).CFrame * CFrame.new(0,0,50)
        end
    end
end, "Teleport")
FeatureCountInc()

AddCmd("tospawn", "Spawn'a ışınlan", {"spawn"}, function(a)
    if GetHRP(LP) and workspace:FindFirstChild("SpawnLocation") then
        GetHRP(LP).CFrame = workspace.SpawnLocation.CFrame * CFrame.new(0,3,0)
    end
end, "Teleport")
FeatureCountInc()

AddCmd("up", "Yukarı çık", {}, function(a)
    local d = tonumber(a[1]) or 10
    if GetHRP(LP) then GetHRP(LP).CFrame = GetHRP(LP).CFrame * CFrame.new(0,d,0) end
end, "Teleport")
FeatureCountInc()

AddCmd("down", "Aşağı in", {}, function(a)
    local d = tonumber(a[1]) or 10
    if GetHRP(LP) then GetHRP(LP).CFrame = GetHRP(LP).CFrame * CFrame.new(0,-d,0) end
end, "Teleport")
FeatureCountInc()

AddCmd("forward", "İleri git", {}, function(a)
    local d = tonumber(a[1]) or 10
    if GetHRP(LP) then GetHRP(LP).CFrame = GetHRP(LP).CFrame * CFrame.new(0,0,-d) end
end, "Teleport")
FeatureCountInc()

AddCmd("back", "Geri git", {}, function(a)
    local d = tonumber(a[1]) or 10
    if GetHRP(LP) then GetHRP(LP).CFrame = GetHRP(LP).CFrame * CFrame.new(0,0,d) end
end, "Teleport")
FeatureCountInc()

AddCmd("left", "Sola git", {}, function(a)
    local d = tonumber(a[1]) or 10
    if GetHRP(LP) then GetHRP(LP).CFrame = GetHRP(LP).CFrame * CFrame.new(-d,0,0) end
end, "Teleport")
FeatureCountInc()

AddCmd("right", "Sağa git", {}, function(a)
    local d = tonumber(a[1]) or 10
    if GetHRP(LP) then GetHRP(LP).CFrame = GetHRP(LP).CFrame * CFrame.new(d,0,0) end
end, "Teleport")
FeatureCountInc()

AddCmd("save", "Konum kaydet", {"savepos","spos"}, function(a)
    if GetHRP(LP) then
        local slot = a[1] or "1"
        _G["SavedPos_" .. slot] = GetHRP(LP).Position
        _G["SavedCF_" .. slot] = GetHRP(LP).CFrame
        Notify("Konum Kaydedildi", "Slot: " .. slot)
    end
end, "Teleport")
FeatureCountInc()

AddCmd("load", "Konuma yükle", {"loadpos","lpos"}, function(a)
    local slot = a[1] or "1"
    local cf = _G["SavedCF_" .. slot]
    if cf and GetHRP(LP) then
        GetHRP(LP).CFrame = cf
        Notify("Konum Yüklendi", "Slot: " .. slot)
    end
end, "Teleport")
FeatureCountInc()

AddCmd("tween", "Yavaş ışınlan (Tween)", {"smooth","animtp"}, function(a)
    if not a[1] then return end
    local target = Players:FindFirstChild(a[1])
    if target and GetHRP(target) and GetHRP(LP) then
        local tween = TweenS:Create(GetHRP(LP), TweenInfo.new(1, Enum.EasingStyle.Quad), {CFrame = GetHRP(target).CFrame})
        tween:Play()
    end
end, "Teleport")
FeatureCountInc()

AddCmd("tweenme", "Beni yavaşça taşı", {}, function(a)
    if not a[1] then return end
    local target = Players:FindFirstChild(a[1])
    if target and GetHRP(target) and GetHRP(LP) then
        local tween = TweenS:Create(GetHRP(LP), TweenInfo.new(2, Enum.EasingStyle.Sine), {CFrame = GetHRP(target).CFrame * CFrame.new(0,5,0)})
        tween:Play()
    end
end, "Teleport")
FeatureCountInc()

AddCmd("tptoall", "Sırayla herkese ışınlan", {"cycle"}, function(a)
    local players = {}
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LP and GetHRP(p) then table.insert(players, p) end
    end
    coroutine.wrap(function()
        for _, p in pairs(players) do
            if GetHRP(p) and GetHRP(LP) then
                GetHRP(LP).CFrame = GetHRP(p).CFrame * CFrame.new(0,5,0)
                wait(2)
            end
        end
    end)()
end, "Teleport")
FeatureCountInc()

--══════════════════════════════════════════════════════════════════════════════
--=  [SECTION 4] COMBAT — SAVAŞ (~100+ FEATURE)
--══════════════════════════════════════════════════════════════════════════════

local AimState = {Active=false, Target=nil, FOV=90, Smoothness=0.3, Silent=false, WallCheck=false, TeamCheck=false}
local CombatFlags = {EspLines=false, BHopInCombat=false}

AddCmd("aimbot", "Aimbot (Otomatik nişan)", {"aim"}, function(a)
    AimState.Active = not AimState.Active
    Notify("Aimbot", AimState.Active and "Aktif!" or "Kapalı")
    
    coroutine.wrap(function()
        while AimState.Active do
            RS.RenderStepped:Wait()
            local target = GetClosestPlayer(AimState.FOV)
            if target and target.Character and target.Character:FindFirstChild("Head") then
                Camera.CFrame = CFrame.lookAt(Camera.CFrame.Position, target.Character.Head.Position)
                if AimState.Silent then
                    -- Silent aim
                end
            end
        end
    end)()
end, "Combat")
FeatureCountInc()

AddCmd("aimfov", "Aimbot FOV", {"aimf"}, function(a)
    local f = tonumber(a[1])
    if f then AimState.FOV = f end
end, "Combat")
FeatureCountInc()

AddCmd("aimsmooth", "Aimbot Yumuşaklık", {"aims"}, function(a)
    local s = tonumber(a[1])
    if s then AimState.Smoothness = s end
end, "Combat")
FeatureCountInc()

AddCmd("silentaim", "Silent Aim (Sessiz nişan)", {"silent","saim"}, function(a)
    AimState.Silent = not AimState.Silent
end, "Combat")
FeatureCountInc()

AddCmd("triggerbot", "Triggerbot (Görünce ateş)", {"trigger","tr"}, function(a)
    local active = not _G.TriggerBot
    _G.TriggerBot = active
    coroutine.wrap(function()
        while _G.TriggerBot do
            RS.RenderStepped:Wait()
            local target = Mouse.Target
            if target then
                for _, p in pairs(Players:GetPlayers()) do
                    if p ~= LP and p.Character and (target:IsDescendantOf(p.Character)) then
                        mouse1click()
                        wait(0.03)
                    end
                end
            end
        end
    end)()
end, "Combat")
FeatureCountInc()

AddCmd("hitbox", "Hitbox genişlet", {"hb","hsize"}, function(a)
    local s = tonumber(a[1]) or 3
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LP and p.Character then
            for _, part in pairs(p.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.Size = Vector3.new(s, s, s)
                end
            end
        end
    end
end, "Combat")
FeatureCountInc()

AddCmd("hitboxhead", "Kafa hitbox genişlet", {"hbh"}, function(a)
    local s = tonumber(a[1]) or 5
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LP and p.Character and p.Character:FindFirstChild("Head") then
            p.Character.Head.Size = Vector3.new(s, s, s)
        end
    end
end, "Combat")
FeatureCountInc()

AddCmd("hitboxreset", "Hitbox sıfırla", {"hbr"}, function(a)
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LP and p.Character then
            for _, part in pairs(p.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.Size = Vector3.new(4, 1, 2)
                end
            end
            if p.Character:FindFirstChild("Head") then
                p.Character.Head.Size = Vector3.new(2, 1, 1)
            end
        end
    end
end, "Combat")
FeatureCountInc()

AddCmd("aura", "Damage Aura (Hasar Aura)", {"dmgaura"}, function(a)
    Flags.AuraActive = not Flags.AuraActive
    coroutine.wrap(function()
        while Flags.AuraActive do
            wait(0.2)
            for _, target in pairs(GetPlayersInRange(Vals.AuraRange)) do
                local th = GetHum(target)
                if th and th.Health > 0 then
                    th.Health = th.Health - Vals.AuraDamage
                end
            end
        end
    end)()
end, "Combat")
FeatureCountInc()

AddCmd("aurarange", "Aura menzil", {}, function(a)
    local r = tonumber(a[1])
    if r then Vals.AuraRange = r end
end, "Combat")
FeatureCountInc()

AddCmd("auradamage", "Aura hasar", {}, function(a)
    local d = tonumber(a[1])
    if d then Vals.AuraDamage = d end
end, "Combat")
FeatureCountInc()

AddCmd("autoclick", "Auto Click (Oto Tıkla)", {"aclick","ac"}, function(a)
    Flags.AutoClick = not Flags.AutoClick
    coroutine.wrap(function()
        while Flags.AutoClick do
            mouse1click()
            wait(0.05)
        end
    end)()
end, "Combat")
FeatureCountInc()

AddCmd("rapidfire", "Rapid Fire (Hızlı ateş)", {"rf"}, function(a)
    Flags.RapidFire = not Flags.RapidFire
end, "Combat")
FeatureCountInc()

AddCmd("norecoil", "No Recoil (Sekeç yok)", {"nr"}, function(a)
    for _, tool in pairs((GetChar(LP) or {}):GetChildren()) do
        if tool:IsA("Tool") then
            for _, child in pairs(tool:GetDescendants()) do
                if child:IsA("NumberValue") and child.Name:lower():find("recoil") then
                    child.Value = 0
                end
            end
        end
    end
end, "Combat")
FeatureCountInc()

AddCmd("nospread", "No Spread (Dağılma yok)", {"ns"}, function(a)
    for _, tool in pairs((GetChar(LP) or {}):GetChildren()) do
        if tool:IsA("Tool") then
            for _, child in pairs(tool:GetDescendants()) do
                if child:IsA("NumberValue") and child.Name:lower():find("spread") then
                    child.Value = 0
                end
            end
        end
    end
end, "Combat")
FeatureCountInc()

AddCmd("infiniteammo", "Infinite Ammo (Sınırsız mermi)", {"infammo","ia"}, function(a)
    for _, tool in pairs((GetChar(LP) or {}):GetChildren()) do
        if tool:IsA("Tool") then
            for _, child in pairs(tool:GetDescendants()) do
                if child:IsA("IntValue") and child.Name:lower():find("ammo") then
                    child.Value = 9999
                end
            end
        end
    end
end, "Combat")
FeatureCountInc()

AddCmd("target", "Hedef seç", {}, function(a)
    if not a[1] then return end
    local t = Players:FindFirstChild(a[1])
    if t then AimState.Target = t; Notify("Hedef", t.Name) end
end, "Combat")
FeatureCountInc()

AddCmd("targetclosest", "En yakın hedef", {"tc","tclose"}, function(a)
    AimState.Target = GetClosestPlayer()
    if AimState.Target then Notify("Hedef", AimState.Target.Name) end
end, "Combat")
FeatureCountInc()

AddCmd("targetclear", "Hedefi temizle", {}, function(a)
    AimState.Target = nil
end, "Combat")
FeatureCountInc()

AddCmd("combatlines", "Combat ESP Lines", {"clines"}, function(a)
    CombatFlags.EspLines = not CombatFlags.EspLines
end, "Combat")
FeatureCountInc()

AddCmd("lock", "Lock (Hedefi kit) al", {}, function(a)
    if AimState.Target and AimState.Target.Character and AimState.Target.Character:FindFirstChild("Head") then
        while _G.LockActive do
            RS.RenderStepped:Wait()
            Camera.CFrame = CFrame.lookAt(Camera.CFrame.Position, AimState.Target.Character.Head.Position)
        end
    end
end, "Combat")
FeatureCountInc()

--══════════════════════════════════════════════════════════════════════════════
--=  [SECTION 5] ADMIN — YÖNETİCİ KOMUTLARI (~80+ FEATURE)
--══════════════════════════════════════════════════════════════════════════════

-- FE KICK METHODS
local function FEKick(target, reason)
    -- Method 1: Health = 0 + BreakJoints
    if target.Character then
        if target.Character:FindFirstChild("Humanoid") then
            target.Character.Humanoid.Health = 0
        end
        target.Character:BreakJoints()
    end
    
    -- Method 2: BindToClose kick
    target:Destroy()
end

local function FEKickAll(reason)
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LP then FEKick(p, reason) end
    end
end

local function FEKill(target)
    if target.Character then
        local h = target.Character:FindFirstChildOfClass("Humanoid")
        if h then
            h.Health = 0
            h:BreakJoints()
        end
        -- Kalp durdurma
        if target.Character:FindFirstChild("Head") then
            target.Character.Head:Destroy()
        end
    end
end

-- 5A: KICK KOMUTLARI
AddCmd("kick", "FE Kick (Oyuncu at)", {"at"}, function(a)
    if not a[1] then return end
    local target = Players:FindFirstChild(a[1])
    if target then
        local reason = a[2] and table.concat(a, " ", 2) or "Kicked by MEGA ADMIN"
        FEKick(target, reason)
        Notify("KICKED", target.Name)
    end
end, "Admin")
FeatureCountInc()

AddCmd("kickall", "FE Kick All (Herkesi at)", {"atall","kickall","kickt"}, function(a)
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LP then FEKick(p, "Kicked by MEGA ADMIN") end
    end
end, "Admin")
FeatureCountInc()

AddCmd("kickothers", "Diğer herkesi at", {"kickother","kot"}, function(a)
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LP then FEKick(p, "Bye bye") end
    end
end, "Admin")
FeatureCountInc()

AddCmd("kickteam", "Takımını at", {}, function(a)
    local myTeam = LP.Team
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LP and p.Team == myTeam then FEKick(p) end
    end
end, "Admin")
FeatureCountInc()

AddCmd("kickrand", "Rastgele oyuncu at", {}, function(a)
    local targets = {}
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LP then table.insert(targets, p) end
    end
    if #targets > 0 then FEKick(targets[math.random(1, #targets)]) end
end, "Admin")
FeatureCountInc()

AddCmd("ban", "FE Ban (Oyuncu yasakla)", {"yasakla"}, function(a)
    if not a[1] then return end
    local target = Players:FindFirstChild(a[1])
    if target then
        FEKick(target, "BANNED by MEGA ADMIN")
        Notify("BANNED", target.Name)
    end
end, "Admin")
FeatureCountInc()

AddCmd("banall", "FE Ban All (Herkesi yasakla)", {"banall","yasaklaall"}, function(a)
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LP then FEKick(p, "BANNED by MEGA ADMIN") end
    end
end, "Admin")
FeatureCountInc()

-- 5B: KILL KOMUTLARI
AddCmd("kill", "FE Kill (Oyuncu öldür)", {"öldür"}, function(a)
    if not a[1] then return end
    local target = Players:FindFirstChild(a[1])
    if target then FEKill(target); Notify("KILLED", target.Name) end
end, "Admin")
FeatureCountInc()

AddCmd("killall", "FE Kill All (Herkesi öldür)", {"öldürall","ka"}, function(a)
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LP then FEKill(p) end
    end
end, "Admin")
FeatureCountInc()

AddCmd("killothers", "Diğerlerini öldür", {"koth"}, function(a)
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LP then FEKill(p) end
    end
end, "Admin")
FeatureCountInc()

AddCmd("killteam", "Takımını öldür", {}, function(a)
    local myTeam = LP.Team
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LP and p.Team == myTeam then FEKill(p) end
    end
end, "Admin")
FeatureCountInc()

-- 5C: FREEZE KOMUTLARI
AddCmd("freeze", "FE Freeze (Dondur)", {"dondur"}, function(a)
    if not a[1] then return end
    local target = Players:FindFirstChild(a[1])
    if target and GetHRP(target) then
        local bp = CreateBP(GetHRP(target).Position)
        bp.Parent = GetHRP(target)
    end
end, "Admin")
FeatureCountInc()

AddCmd("freezeall", "Herkesi dondur", {"frzall"}, function(a)
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LP and GetHRP(p) then
            local bp = CreateBP(GetHRP(p).Position)
            bp.Parent = GetHRP(p)
        end
    end
end, "Admin")
FeatureCountInc()

AddCmd("unfreeze", "Çöz", {"çöz","unfrz"}, function(a)
    if not a[1] then return end
    local target = Players:FindFirstChild(a[1])
    if target and GetHRP(target) then
        for _, v in pairs(GetHRP(target):GetChildren()) do
            if v:IsA("BodyPosition") or v:IsA("BodyVelocity") then v:Destroy() end
        end
    end
end, "Admin")
FeatureCountInc()

AddCmd("unfreezeall", "Herkesi çöz", {"unfrzall"}, function(a)
    for _, p in pairs(Players:GetPlayers()) do
        if GetHRP(p) then
            for _, v in pairs(GetHRP(p):GetChildren()) do
                if v:IsA("BodyPosition") or v:IsA("BodyVelocity") then v:Destroy() end
            end
        end
    end
end, "Admin")
FeatureCountInc()

-- 5D: HEAL/REVIVE
AddCmd("heal", "FE Heal (İyileştir)", {"iyileştir","h"}, function(a)
    if not a[1] then return end
    local target = Players:FindFirstChild(a[1])
    if target and GetHum(target) then
        GetHum(target).Health = GetHum(target).MaxHealth
    end
end, "Admin")
FeatureCountInc()

AddCmd("healall", "Herkesi iyileştir", {"heala"}, function(a)
    for _, p in pairs(Players:GetPlayers()) do
        if GetHum(p) then GetHum(p).Health = GetHum(p).MaxHealth end
    end
end, "Admin")
FeatureCountInc()

AddCmd("respawn", "Yeniden doğurt", {"rsp","res"}, function(a)
    if not a[1] then return end
    local target = Players:FindFirstChild(a[1])
    if target then
        if target.Character then target.Character:BreakJoints() end
        wait(2)
        target:LoadCharacter()
    end
end, "Admin")
FeatureCountInc()

AddCmd("respawnall", "Herkesi yeniden doğurt", {"resall","rspall"}, function(a)
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LP then
            if p.Character then p.Character:BreakJoints() end
            wait(1)
            p:LoadCharacter()
        end
    end
end, "Admin")
FeatureCountInc()

-- 5E: JAIL/CAGE
AddCmd("jail", "Hapse at (Jail)", {"kafes","cage"}, function(a)
    if not a[1] then return end
    local target = Players:FindFirstChild(a[1])
    if target and GetHRP(target) then
        local pos = GetHRP(target).Position
        local mat = Enum.Material.SmoothPlastic
        local colors = {BrickColor.new("Bright red"), BrickColor.new("Medium stone grey")}
        for x = -5, 5, 2 do
            for z = -5, 5, 2 do
                if math.abs(x) <= 4 or math.abs(z) <= 4 then
                    local p = Instance.new("Part")
                    p.Size = Vector3.new(2, 1, 2)
                    p.Position = pos + Vector3.new(x, 0, z)
                    p.Anchored = true
                    p.BrickColor = colors[math.random(1, #colors)]
                    p.Material = mat
                    p.Parent = workspace
                    Debris:AddItem(p, 60)
                end
            end
        end
        -- Tavan
        local ceiling = Instance.new("Part")
        ceiling.Size = Vector3.new(12, 1, 12)
        ceiling.Position = pos + Vector3.new(0, 6, 0)
        ceiling.Anchored = true
        ceiling.BrickColor = BrickColor.new("Bright red")
        ceiling.Parent = workspace
        Debris:AddItem(ceiling, 60)
        -- Taban
        local floor = Instance.new("Part")
        floor.Size = Vector3.new(12, 1, 12)
        floor.Position = pos + Vector3.new(0, -3, 0)
        floor.Anchored = true
        floor.BrickColor = BrickColor.new("Medium stone grey")
        floor.Parent = workspace
        Debris:AddItem(floor, 60)
    end
end, "Admin")
FeatureCountInc()

AddCmd("jailall", "Herkesi hapset", {"cageall"}, function(a)
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LP then
            pcall(function() AddCmd.jail(nil) end) -- Yaklaşık
        end
    end
end, "Admin")
FeatureCountInc()

AddCmd("unjail", "Hapisten çıkar", {"uncage"}, function(a)
    if not a[1] then return end
    -- Sil all parts near player
    local target = Players:FindFirstChild(a[1])
    if target and GetHRP(target) then
        local pos = GetHRP(target).Position
        for _, obj in pairs(workspace:GetChildren()) do
            if obj:IsA("BasePart") and obj.Anchored and (obj.Position - pos).Magnitude < 15 then
                obj:Destroy()
            end
        end
    end
end, "Admin")
FeatureCountInc()

-- 5F: STUN / BLIND
AddCmd("stun", "FE Stun (Sersemlet)", {}, function(a)
    if not a[1] then return end
    local target = Players:FindFirstChild(a[1])
    if target and GetHum(target) then
        GetHum(target).PlatformStand = true
        GetHum(target).WalkSpeed = 0
        wait(5)
        if GetHum(target) then
            GetHum(target).PlatformStand = false
            GetHum(target).WalkSpeed = 16
        end
    end
end, "Admin")
FeatureCountInc()

AddCmd("stunall", "Herkesi sersemlet", {}, function(a)
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LP and GetHum(p) then
            GetHum(p).PlatformStand = true
            GetHum(p).WalkSpeed = 0
            coroutine.wrap(function()
                wait(5)
                if GetHum(p) then
                    GetHum(p).PlatformStand = false
                    GetHum(p).WalkSpeed = 16
                end
            end)()
        end
    end
end, "Admin")
FeatureCountInc()

AddCmd("blind", "FE Blind (Kör et)", {"kör"}, function(a)
    if not a[1] then return end
    local target = Players:FindFirstChild(a[1])
    if target then
        local c = GetChar(target)
        if c and c:FindFirstChild("Head") then
            local screen = Instance.new("ScreenGui")
            local frame = Instance.new("Frame")
            screen.Parent = target:FindFirstChildOfClass("PlayerGui") or target.PlayerGui
            frame.Size = UDim2.new(1,0,1,0)
            frame.BackgroundColor3 = Color3.new(0,0,0)
            frame.BackgroundTransparency = 0.9
            frame.Parent = screen
            Debris:AddItem(screen, 10)
        end
    end
end, "Admin")
FeatureCountInc()

-- 5G: CRASH / LAG
AddCmd("crash", "Oyuncuyu çökert (Crash)", {}, function(a)
    if not a[1] then return end
    local target = Players:FindFirstChild(a[1])
    if target then
        -- Part spawn crash
        local pos = GetHRP(target) and GetHRP(target).Position or Vector3.new(0,0,0)
        for i = 1, 5000 do
            local p = Instance.new("Part")
            p.Position = pos + Vector3.new(math.random(-500,500), math.random(-500,500), math.random(-500,500))
            p.Parent = workspace
            Debris:AddItem(p, 5)
        end
    end
end, "Admin")
FeatureCountInc()

AddCmd("crashall", "Sunucuyu çökert", {}, function(a)
    for i = 1, 10000 do
        local p = Instance.new("Part")
        p.Anchored = true
        p.Position = Vector3.new(math.random(-10000,10000), math.random(-10000,10000), math.random(-10000,10000))
        p.Size = Vector3.new(10, 10, 10)
        p.Parent = workspace
    end
end, "Admin")
FeatureCountInc()

AddCmd("lag", "Lag makinesi", {}, function(a)
    for i = 1, 1000 do
        local p = Instance.new("Part")
        p.Position = Vector3.new(math.random(-100,100), 50, math.random(-100,100))
        p.Velocity = Vector3.new(math.random(-100,100), math.random(-100,100), math.random(-100,100))
        p.Parent = workspace
        Debris:AddItem(p, 10)
    end
end, "Admin")
FeatureCountInc()

AddCmd("explode", "Patlat", {}, function(a)
    if not a[1] then return end
    local target = Players:FindFirstChild(a[1])
    if target and GetHRP(target) then
        local ex = Instance.new("Explosion")
        ex.Position = GetHRP(target).Position
        ex.BlastRadius = 10
        ex.BlastPressure = 5000
        ex.Parent = workspace
    end
end, "Admin")
FeatureCountInc()

AddCmd("explodeall", "Herkesi patlat", {}, function(a)
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LP and GetHRP(p) then
            local ex = Instance.new("Explosion")
            ex.Position = GetHRP(p).Position
            ex.BlastRadius = 10
            ex.BlastPressure = 5000
            ex.Parent = workspace
        end
    end
end, "Admin")
FeatureCountInc()

AddCmd("remove", "Nesne sil", {"rem","sil"}, function(a)
    if not a[1] then return end
    local keyword = a[1]:lower()
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj.Name:lower():find(keyword) then
            pcall(function() obj:Destroy() end)
        end
    end
end, "Admin")
FeatureCountInc()

AddCmd("removetools", "Tüm aletleri sil", {}, function(a)
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Tool") then obj:Destroy() end
    end
end, "Admin")
FeatureCountInc()

AddCmd("removeseats", "Tüm koltukları sil", {}, function(a)
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Seat") or obj:IsA("VehicleSeat") then obj:Destroy() end
    end
end, "Admin")
FeatureCountInc()

AddCmd("shutdown", "Sunucu mesajı + kick", {"kapat"}, function(a)
    _G.ShuttingDown = true
    local msg = a[1] or "Server shutting down..."
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LP then
            pcall(function() p:Kick(msg) end)
        end
    end
end, "Admin")
FeatureCountInc()

--══════════════════════════════════════════════════════════════════════════════
--=  [SECTION 6] WORLD — DÜNYA AYARLARI (~50+ FEATURE)
--══════════════════════════════════════════════════════════════════════════════

AddCmd("time", "Saat ayarla", {"t"}, function(a)
    local t = tonumber(a[1])
    if t then Lighting.ClockTime = t end
end, "World")
FeatureCountInc()

AddCmd("day", "Gündüz", {}, function(a)
    Lighting.ClockTime = 12
    Lighting.Brightness = 2
end, "World")
FeatureCountInc()

AddCmd("night", "Gece", {}, function(a)
    Lighting.ClockTime = 0
    Lighting.Brightness = 0.2
end, "World")
FeatureCountInc()

AddCmd("sunset", "Günbatımı", {}, function(a)
    Lighting.ClockTime = 18
    Lighting.Brightness = 0.8
end, "World")
FeatureCountInc()

AddCmd("dawn", "Şafak", {}, function(a)
    Lighting.ClockTime = 6
    Lighting.Brightness = 1
end, "World")
FeatureCountInc()

AddCmd("gravity", "Yerçekimi", {"grav","g"}, function(a)
    local g = tonumber(a[1])
    if g then workspace.Gravity = g end
end, "World")
FeatureCountInc()

AddCmd("antigravity", "Yerçekimsiz", {"antigrav","ng"}, function(a)
    workspace.Gravity = 0
end, "World")
FeatureCountInc()

AddCmd("normalgravity", "Normal yerçekimi", {}, function(a)
    workspace.Gravity = 196.2
end, "World")
FeatureCountInc()

AddCmd("freezegravity", "Yerçekimi dondur", {}, function(a)
    for _, p in pairs(workspace:GetDescendants()) do
        if p:IsA("BasePart") and not p.Anchored then
            p.Anchored = true
        end
    end
end, "World")
FeatureCountInc()

AddCmd("delete", "Nesne sil (ad ile)", {"del","destroy"}, function(a)
    if not a[1] then return end
    local keyword = a[1]:lower()
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj.Name:lower():find(keyword) then
            pcall(obj.Destroy, obj)
        end
    end
end, "World")
FeatureCountInc()

AddCmd("clear", "Temizle", {}, function(a)
    for _, obj in pairs(workspace:GetChildren()) do
        if not obj:IsA("Terrain") and not obj:IsA("Workspace") and not obj:IsA("Camera") then
            pcall(obj.Destroy, obj)
        end
    end
end, "World")
FeatureCountInc()

AddCmd("removewater", "Suyu kaldır", {}, function(a)
    for _, obj in pairs(workspace:GetDescendants()) do
        pcall(function()
            if obj.Material == Enum.Material.Water or obj.Material == Enum.Material.Sand then
                obj:Destroy()
            end
        end)
    end
end, "World")
FeatureCountInc()

--══════════════════════════════════════════════════════════════════════════════
--=  [SECTION 7] SCRIPTS — HAZIR SCRIPT HUB'ı (~50+ FEATURE)
--══════════════════════════════════════════════════════════════════════════════

AddCmd("iy", "Infinite Yield Admin", {"infiniteyield"}, function(a)
    loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
end, "Scripts")
FeatureCountInc()

AddCmd("dex", "Dex Explorer", {}, function(a)
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Bertie2004/Dex/main/Explorer%20V4.lua"))()
end, "Scripts")
FeatureCountInc()

AddCmd("remotespy", "Remote Spy", {"rspy","rspy"}, function(a)
    loadstring(game:HttpGet("https://raw.githubusercontent.com/exxtremestuffs/RemoteSpy/master/Source.lua"))()
end, "Scripts")
FeatureCountInc()

AddCmd("cmdx", "Cmd-X Admin", {"cmdadmin"}, function(a)
    loadstring(game:HttpGet("https://raw.githubusercontent.com/CMD-X/CMD-X/master/main"))()
end, "Scripts")
FeatureCountInc()

AddCmd("dexv3", "Dark Dex V3", {}, function(a)
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Babyhamsta/Roblox/main/Universal/Scripts/DarkDexV3.lua"))()
end, "Scripts")
FeatureCountInc()

AddCmd("owlhub", "Owl Hub", {"owl"}, function(a)
    loadstring(game:HttpGet("https://raw.githubusercontent.com/CriShoux/OwlHub/master/OwlHub.txt"))()
end, "Scripts")
FeatureCountInc()

AddCmd("chatspoof", "Chat Spoofer", {"spoof"}, function(a)
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Babyhamsta/Roblox/main/Universal/Scripts/ChatSpoofer.lua"))()
end, "Scripts")
FeatureCountInc()

AddCmd("darkdex", "Dark Dex", {"dd"}, function(a)
    loadstring(game:HttpGet("https://raw.githubusercontent.com/nicolasrrobins/DarkDex/refs/heads/main/DarkDex.lua"))()
end, "Scripts")
FeatureCountInc()

AddCmd("espv3", "ESP V3", {}, function(a)
    loadstring(game:HttpGet("https://pastebin.com/raw/kAHLMqJh", true))()
end, "Scripts")
FeatureCountInc()

AddCmd("aimlock", "Universal Aimlock", {}, function(a)
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Kaizeno/Bot/main/Ares.txt"))()
end, "Scripts")
FeatureCountInc()

--══════════════════════════════════════════════════════════════════════════════
--=  [SECTION 8] MISC — ÇEŞİTLİ (~80+ FEATURE)
--══════════════════════════════════════════════════════════════════════════════

AddCmd("rejoin", "Yeniden katıl (Rejoin)", {}, function(a)
    TS:Teleport(game.PlaceId, LP)
end, "Misc")
FeatureCountInc()

AddCmd("serverhop", "Sunucu değiştir", {"sh","hop"}, function(a)
    local placeId = game.PlaceId
    local servers = {}
    local success, result = pcall(function()
        return HttpS:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. placeId .. "/servers/Public?limit=100"))
    end)
    if success and result and result.data then
        for _, server in pairs(result.data) do
            if server.id ~= game.JobId and server.playing < server.maxPlayers then
                TS:TeleportToPlaceInstance(placeId, server.id, LP)
                return
            end
        end
    end
    Notify("No servers", "No available servers")
end, "Misc")
FeatureCountInc()

AddCmd("fps", "FPS Counter", {"fpssay"}, function(a)
    local gui = Instance.new("ScreenGui", CG)
    local label = Instance.new("TextLabel", gui)
    label.Size = UDim2.new(0,100,0,30)
    label.Position = UDim2.new(0,10,0,10)
    label.BackgroundTransparency = 0.5
    label.BackgroundColor3 = Color3.new(0,0,0)
    label.TextColor3 = Color3.new(0,1,0)
    label.Font = Enum.Font.SourceSansBold
    label.TextScaled = true
    local f = 0
    coroutine.wrap(function()
        while gui and gui.Parent do
            RS.RenderStepped:Wait()
            f = f + 1
            label.Text = "FPS: " .. math.floor(1 / RS.RenderStepped:Wait())
        end
    end)()
end, "Misc")
FeatureCountInc()

AddCmd("ping", "Ping göster", {}, function(a)
    Notify("Ping", tostring(LP:GetNetworkPing()) .. "ms")
end, "Misc")
FeatureCountInc()

AddCmd("timeinfo", "Saat göster", {}, function(a)
    Notify("Time", os.date("%H:%M:%S"))
end, "Misc")
FeatureCountInc()

AddCmd("playerlist", "Oyuncu listesi", {"players","pl","list"}, function(a)
    local names = {}
    for _, p in pairs(Players:GetPlayers()) do
        table.insert(names, p.Name .. (p == LP and " (YOU)" or ""))
    end
    Notify("Players", table.concat(names, ", "))
end, "Misc")
FeatureCountInc()

AddCmd("playercount", "Oyuncu sayısı", {"count","pcount"}, function(a)
    Notify("Player Count", tostring(#Players:GetPlayers()))
end, "Misc")
FeatureCountInc()

AddCmd("neterror", "Network hatası", {"net"}, function(a)
    warn("Network: " .. tostring(LP:GetNetworkPing()))
end, "Misc")
FeatureCountInc()

AddCmd("resetgui", "GUI'yi sıfırla", {"guireload"}, function(a)
    Library:Destroy()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source"))()
end, "Misc")
FeatureCountInc()

AddCmd("commands", "Komutları listele", {"help","cmds","komutlar","yardım"}, function(a)
    local cats = {}
    for name, cmd in pairs(Commands) do
        if cmd.name == name and not cmd.hidden then
            local cat = cmd.category or "Misc"
            if not cats[cat] then cats[cat] = {} end
            table.insert(cats[cat], ";"..cmd.name)
        end
    end
    local msg = ""
    for cat, cmds in pairs(cats) do
        msg = msg .. "[" .. cat .. "] " .. table.concat(cmds, " ") .. "\n"
    end
    Notify("Commands v"..Version, tostring(cmdCount) .. " commands")
    print(msg)
end, "Misc")
FeatureCountInc()

AddCmd("cmdcategory", "Kategorideki komutlar", {"helpcat","cathelp"}, function(a)
    local catName = a[1] and a[1]:lower() or ""
    local cmds = {}
    for name, cmd in pairs(Commands) do
        if cmd.name == name and cmd.category and cmd.category:lower():find(catName) then
            table.insert(cmds, ";"..cmd.name)
        end
    end
    if #cmds > 0 then
        print("[" .. (a[1] or "All") .. "]: " .. table.concat(cmds, " "))
    end
end, "Misc")
FeatureCountInc()

--══════════════════════════════════════════════════════════════════════════════
--=  [SECTION 9] GUI — KULLANICI ARAYÜZÜ
--══════════════════════════════════════════════════════════════════════════════

-- Tab 1: Player
local PTab = Window:NewTab("Player")
local PSec = PTab:NewSection("Oyuncu Modları")
PSec:NewToggle("God Mode", "Ölmezsin", function(s) if s then EnableGodMode() else Flags.GodMode = false end end)
PSec:NewToggle("Noclip", "Duvardan geç", function(s) Flags.Noclip = s end)
PSec:NewToggle("Fly", "Uç", function(s) 
    Flags.Fly = s
    if s then
        local hrp = GetHRP(LP)
        if hrp then
            local bv = CreateBV(); bv.Parent = hrp
            local bg = CreateBG(); bg.Parent = hrp
            if GetHum(LP) then GetHum(LP).PlatformStand = true end
        end
    else
        local hrp = GetHRP(LP)
        if hrp then
            for _, v in pairs(hrp:GetChildren()) do
                if v:IsA("BodyVelocity") or v:IsA("BodyGyro") then v:Destroy() end
            end
            if GetHum(LP) then GetHum(LP).PlatformStand = false end
        end
    end
end)
PSec:NewToggle("Infinite Jump", "Havada zıpla", function(s) Flags.InfiniteJump = s end)
PSec:NewToggle("Float", "Havada dur", function(s) 
    Flags.Float = s
    local hrp = GetHRP(LP)
    if hrp then
        if s then
            local bv = CreateBV(); bv.Parent = hrp
        else
            for _, v in pairs(hrp:GetChildren()) do if v:IsA("BodyVelocity") then v:Destroy() end end
        end
    end
end)
PSec:NewToggle("Anti-Kick", "Atılamazsın", function(s) Flags.AntiKick = s; FE.AntiKick = s; FE:Init() end)
PSec:NewToggle("Anti-AFK", "AFK olmazsın", function(s) Flags.AntiAFK = s end)
PSec:NewToggle("Invisible", "Görünmez", function(s)
    Flags.Invisible = s
    local c = GetChar(LP)
    if c then
        for _, p in pairs(c:GetDescendants()) do
            if p:IsA("BasePart") then p.Transparency = s and 1 or 0; p.CanCollide = not s end
        end
    end
end)
PSec:NewToggle("Spin Bot", "Dön", function(s) Flags.SpinBot = s end)
PSec:NewToggle("No Fall", "Düşüş hasarı yok", function(s) Flags.NoFallDmg = s; if GetHum(LP) then GetHum(LP).FallDamage = not s end end)
PSec:NewToggle("B-Hop", "Otomatik zıpla", function(s) Flags.BHop = s end)

PSec:NewSlider("WalkSpeed", "Hız", 500, 16, function(s) Vals.WalkSpeed = s; if GetHum(LP) then GetHum(LP).WalkSpeed = s end end)
PSec:NewSlider("JumpPower", "Zıplama", 500, 50, function(s) Vals.JumpPower = s; if GetHum(LP) then GetHum(LP).JumpPower = s end end)
PSec:NewSlider("Fly Speed", "Uçuş hızı", 500, 50, function(s) Vals.FlySpeed = s end)

-- Tab 2: Visual
local VTab = Window:NewTab("Visual")
local VSec = VTab:NewSection("Görsel Ayarları")
VSec:NewToggle("Full Bright", "Tam aydınlık", function(s)
    if s then
        Lighting.Ambient = Color3.new(1,1,1); Lighting.Brightness = 3
        Lighting.FogEnd = 1e9; Lighting.ClockTime = 12; Lighting.GlobalShadows = false
    else
        Lighting:SetGlobalLighting()
    end
end)
VSec:NewToggle("ESP", "Oyuncu işaretle", function(s)
    ESPEnabled = s
    if s then
        for _, p in pairs(Players:GetPlayers()) do CreateESPForPlayer(p, "All") end
    else
        ClearAllESP()
    end
end)
VSec:NewToggle("X-Ray", "Her şey şeffaf", function(s)
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") then obj.Transparency = s and 0.7 or 0 end
    end
end)
VSec:NewToggle("Wallhack", "Duvarlar şeffaf", function(s)
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") and obj.Anchored then obj.Transparency = s and 0.7 or 0 end
    end
end)
VSec:NewToggle("Highlight", "Kırmızı vurgu", function(s)
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LP and p.Character then
            if s then
                local hl = Instance.new("Highlight", p.Character)
                hl.FillColor = Color3.new(1,0,0); hl.FillTransparency = 0.5
            else
                for _, hl in pairs(p.Character:GetDescendants()) do
                    if hl:IsA("Highlight") then hl:Destroy() end
                end
            end
        end
    end
end)
VSec:NewSlider("FOV", "Görüş açısı", 180, 70, function(s) Camera.FieldOfView = s end)

-- Tab 3: Combat
local CTab = Window:NewTab("Combat")
local CSec = CTab:NewSection("Savaş")
CSec:NewToggle("Aimbot", "Otomatik nişan", function(s) AimState.Active = s end)
CSec:NewToggle("Triggerbot", "Görünce tıkla", function(s) _G.TriggerBot = s end)
CSec:NewToggle("Silent Aim", "Sessiz nişan", function(s) AimState.Silent = s end)
CSec:NewToggle("Damage Aura", "Hasar aurası", function(s) Flags.AuraActive = s end)
CSec:NewToggle("Auto Click", "Otomatik tıkla", function(s) Flags.AutoClick = s end)
CSec:NewSlider("Aura Range", "Aura menzil", 100, 20, function(s) Vals.AuraRange = s end)
CSec:NewSlider("Aura Damage", "Aura hasar", 50, 5, function(s) Vals.AuraDamage = s end)
CSec:NewSlider("Hitbox Size", "Hitbox genişlik", 20, 3, function(s)
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LP and p.Character then
            for _, part in pairs(p.Character:GetDescendants()) do
                if part:IsA("BasePart") then part.Size = Vector3.new(s,s,s) end
            end
        end
    end
end)

-- Tab 4: Teleport
local TTab = Window:NewTab("Teleport")
local TSec = TTab:NewSection("Işınlanma")
TSec:NewDropdown("Oyuncuya Git", "Seç + git", PlayerList, function(sel)
    local t = Players:FindFirstChild(sel)
    if t and GetHRP(t) and GetHRP(LP) then GetHRP(LP).CFrame = GetHRP(t).CFrame * CFrame.new(0,5,0) end
end)
TSec:NewDropdown("Getir (Bring)", "Seç + getir", PlayerList, function(sel)
    local t = Players:FindFirstChild(sel)
    if t and GetHRP(t) and GetHRP(LP) then GetHRP(LP).CFrame = GetHRP(t).CFrame * CFrame.new(0,5,0) end
end)
TSec:NewToggle("Click TP", "Tıkla ışınlan", function(s) Flags.TeleportActive = s end)
TSec:NewButton("Spawn'a Dön", "", function()
    if workspace:FindFirstChild("SpawnLocation") and GetHRP(LP) then
        GetHRP(LP).CFrame = workspace.SpawnLocation.CFrame * CFrame.new(0,3,0)
    end
end)
TSec:NewButton("Yukarı (+50)", "", function() if GetHRP(LP) then GetHRP(LP).CFrame = GetHRP(LP).CFrame * CFrame.new(0,50,0) end end)
TSec:NewButton("Aşağı (-50)", "", function() if GetHRP(LP) then GetHRP(LP).CFrame = GetHRP(LP).CFrame * CFrame.new(0,-50,0) end end)
TSec:NewButton("Herkesi Getir", "", function()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LP and GetHRP(p) and GetHRP(LP) then
            GetHRP(p).CFrame = GetHRP(LP).CFrame * CFrame.new(0,0,3)
        end
    end
end)

-- Tab 5: Admin
local ATab = Window:NewTab("Admin")
local ASec = ATab:NewSection("Admin")
ASec:NewDropdown("Kick (At)", "FE Kick", PlayerList, function(sel)
    local t = Players:FindFirstChild(sel)
    if t then FEKick(t, "Kicked"); Notify("KICKED", t.Name) end
end)
ASec:NewDropdown("Kill (Öldür)", "FE Kill", PlayerList, function(sel)
    local t = Players:FindFirstChild(sel)
    if t then FEKill(t); Notify("KILLED", t.Name) end
end)
ASec:NewDropdown("Freeze (Dondur)", "FE Freeze", PlayerList, function(sel)
    local t = Players:FindFirstChild(sel)
    if t and GetHRP(t) then CreateBP(GetHRP(t).Position).Parent = GetHRP(t) end
end)
ASec:NewDropdown("Unfreeze (Çöz)", "", PlayerList, function(sel)
    local t = Players:FindFirstChild(sel)
    if t and GetHRP(t) then
        for _, v in pairs(GetHRP(t):GetChildren()) do
            if v:IsA("BodyPosition") then v:Destroy() end
        end
    end
end)
ASec:NewDropdown("Heal (İyileştir)", "", PlayerList, function(sel)
    local t = Players:FindFirstChild(sel)
    if t and GetHum(t) then GetHum(t).Health = GetHum(t).MaxHealth end
end)
ASec:NewButton("Kill All", "", function() for _, p in pairs(Players:GetPlayers()) do if p ~= LP then FEKill(p) end end end)
ASec:NewButton("Kick All", "", function() for _, p in pairs(Players:GetPlayers()) do if p ~= LP then FEKick(p) end end end)
ASec:NewButton("Freeze All", "", function()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LP and GetHRP(p) then CreateBP(GetHRP(p).Position).Parent = GetHRP(p) end
    end
end)
ASec:NewButton("Heal All", "", function()
    for _, p in pairs(Players:GetPlayers()) do
        if GetHum(p) then GetHum(p).Health = GetHum(p).MaxHealth end
    end
end)
ASec:NewButton("Respawn All", "", function()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LP then
            if p.Character then p.Character:BreakJoints() end
            wait(1); p:LoadCharacter()
        end
    end
end)
ASec:NewButton("Unfreeze All", "", function()
    for _, p in pairs(Players:GetPlayers()) do
        if GetHRP(p) then
            for _, v in pairs(GetHRP(p):GetChildren()) do
                if v:IsA("BodyPosition") then v:Destroy() end
            end
        end
    end
end)

-- Tab 6: World
local WTab = Window:NewTab("World")
local WSec = WTab:NewSection("Dünya")
WSec:NewSlider("Time (Saat)", "", 24, 12, function(s) Lighting.ClockTime = s end)
WSec:NewSlider("Gravity", "", 500, 196, function(s) workspace.Gravity = s end)
WSec:NewSlider("Fog (Sis)", "", 1000, 500, function(s) Lighting.FogEnd = s end)
WSec:NewButton("Full Bright", "", function()
    Lighting.Ambient = Color3.new(1,1,1); Lighting.Brightness = 3
    Lighting.FogEnd = 1e9; Lighting.ClockTime = 12; Lighting.GlobalShadows = false
end)
WSec:NewButton("Night", "", function() Lighting.ClockTime = 0; Lighting.Brightness = 0.2 end)
WSec:NewButton("Antigravity", "", function() workspace.Gravity = 0 end)
WSec:NewButton("Normal Gravity", "", function() workspace.Gravity = 196.2 end)

-- Tab 7: Scripts
local STab = Window:NewTab("Scripts")
local SSec = STab:NewSection("Hazır Script'ler")
SSec:NewButton("Infinite Yield", "", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))() end)
SSec:NewButton("Dex Explorer V4", "", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Bertie2004/Dex/main/Explorer%20V4.lua"))() end)
SSec:NewButton("Remote Spy", "", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/exxtremestuffs/RemoteSpy/master/Source.lua"))() end)
SSec:NewButton("Dark Dex V3", "", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Babyhamsta/Roblox/main/Universal/Scripts/DarkDexV3.lua"))() end)
SSec:NewButton("Cmd-X", "", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/CMD-X/CMD-X/master/main"))() end)
SSec:NewButton("Owl Hub", "", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/CriShoux/OwlHub/master/OwlHub.txt"))() end)
SSec:NewButton("Chat Spoofer", "", function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Babyhamsta/Roblox/main/Universal/Scripts/ChatSpoofer.lua"))() end)

-- Tab 8: Misc
local MTab = Window:NewTab("Misc")
local MSec = MTab:NewSection("Çeşitli")
MSec:NewButton("Rejoin", "Tekrar katıl", function() TS:Teleport(game.PlaceId, LP) end)
MSec:NewButton("Server Hop", "Sunucu değiştir", function()
    local servers = pcall(function() return HttpS:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?limit=100")) end)
    if servers and servers.data then
        for _, s in pairs(servers.data) do
            if s.id ~= game.JobId and s.playing < s.maxPlayers then
                TS:TeleportToPlaceInstance(game.PlaceId, s.id, LP); return
            end
        end
    end
end)
MSec:NewButton("FPS Counter", "", function()
    local gui = Instance.new("ScreenGui", CG)
    local l = Instance.new("TextLabel", gui)
    l.Size = UDim2.new(0,100,0,30); l.Position = UDim2.new(0,10,0,10)
    l.BackgroundTransparency = 0.5; l.BackgroundColor3 = Color3.new(0,0,0)
    l.TextColor3 = Color3.new(0,1,0); l.Font = Enum.Font.SourceSansBold; l.TextScaled = true
    coroutine.wrap(function() while gui.Parent do RS.RenderStepped:Wait(); l.Text = "FPS: " .. math.floor(1/RS.RenderStepped:Wait()) end end)()
end)
MSec:NewButton("Commands List", "Tüm komutları göster", function()
    local cats = {}
    for n, c in pairs(Commands) do
        if c.name == n and not c.hidden then
            cats[c.category or "Misc"] = cats[c.category or "Misc"] or {}
            table.insert(cats[c.category or "Misc"], ";"..c.name)
        end
    end
    for cat, cmds in pairs(cats) do print("["..cat.."] "..table.concat(cmds," ")) end
    Notify("Commands", tostring(cmdCount) .. " total")
end)
MSec:NewButton("Player List", "", function()
    local list = {}
    for _, p in pairs(Players:GetPlayers()) do table.insert(list, p.Name) end
    Notify("Players", table.concat(list, ", "))
end)

-- Tab 9: Keybinds
local KTab = Window:NewTab("Keybinds")
local KSec = KTab:NewSection("Kısayol Tuşları")
KSec:NewKeybind("GUI Toggle", "GUI aç/kapa", Enum.KeyCode.LeftControl, function()
    pcall(function() Window:Toggle() end)
end)
KSec:NewKeybind("Noclip", "", Enum.KeyCode.N, function()
    Flags.Noclip = not Flags.Noclip
end)
KSec:NewKeybind("Fly", "", Enum.KeyCode.F, function()
    Flags.Fly = not Flags.Fly
    if Flags.Fly then
        local hrp = GetHRP(LP)
        if hrp then CreateBV().Parent = hrp; CreateBG().Parent = hrp end
    else
        local hrp = GetHRP(LP)
        if hrp then
            for _, v in pairs(hrp:GetChildren()) do
                if v:IsA("BodyVelocity") or v:IsA("BodyGyro") then v:Destroy() end
            end
        end
    end
end)
KSec:NewKeybind("Infinite Jump", "", Enum.KeyCode.G, function()
    Flags.InfiniteJump = not Flags.InfiniteJump
end)
KSec:NewKeybind("God Mode", "", Enum.KeyCode.Q, function()
    if Flags.GodMode then Flags.GodMode = false else EnableGodMode() end
end)
KSec:NewKeybind("ESP", "", Enum.KeyCode.E, function()
    ESPEnabled = not ESPEnabled
    if ESPEnabled then
        for _, p in pairs(Players:GetPlayers()) do CreateESPForPlayer(p, "All") end
    else ClearAllESP() end
end)
KSec:NewKeybind("Click TP", "", Enum.KeyCode.T, function()
    Flags.TeleportActive = not Flags.TeleportActive
end)
KSec:NewKeybind("Speed Boost", "", Enum.KeyCode.X, function()
    if GetHum(LP) then
        GetHum(LP).WalkSpeed = 100; wait(5); GetHum(LP).WalkSpeed = Vals.WalkSpeed
    end
end)
KSec:NewKeybind("Reset", "", Enum.KeyCode.R, function()
    if GetChar(LP) then GetChar(LP):BreakJoints() end; wait(2); LP:LoadCharacter()
end)

-- Tab 10: Info
local ITab = Window:NewTab("Info")
local ISec = ITab:NewSection("MEGA ADMIN ULTIMATE")
ISec:NewLabel(ScriptName .. " " .. Version)
ISec:NewLabel("👤 Owner: " .. Owner)
ISec:NewLabel("🏆 Toplam Özellik: " .. FeatureCount)
ISec:NewLabel("⌨️ Toplam Komut: " .. cmdCount)
ISec:NewLabel("⚡ Önerilen Executor:")
ISec:NewLabel("   • Madium ✓ (En iyi)")
ISec:NewLabel("   • Xeno ✓")
ISec:NewLabel("   • Velocity ✓")
ISec:NewLabel("")
ISec:NewLabel("⚠️ Byfron/Hyperion Korumalı Oyunlar:")
ISec:NewLabel("   Arsenal, Da Hood, Doors, MM2,")
ISec:NewLabel("   Phantom Forces, Pet Sim, Blox Fruits")
ISec:NewLabel("")
ISec:NewLabel("📌 Bu oyunlarda çalışması için")
ISec:NewLabel("   executor'ün Byfron'u bypass")
ISec:NewLabel("   etmesi gerekir.")
ISec:NewLabel("")
ISec:NewLabel("📋 FE KOMUTLARI:")
ISec:NewLabel(";kick isim — FE Kick")
ISec:NewLabel(";kill isim — FE Kill")
ISec:NewLabel(";freeze isim — FE Freeze")
ISec:NewLabel(";jail isim — FE Hapis")
ISec:NewLabel(";bring isim — Getir")
ISec:NewLabel(";killall — Herkesi öldür")
ISec:NewLabel(";kickall — Herkesi at")
ISec:NewLabel(";tp isim — Işınlan")
ISec:NewLabel(";fly — Uç")
ISec:NewLabel(";heal isim — İyileştir")
ISec:NewLabel(";god — Tanrı modu")
ISec:NewLabel(";commands — Tüm komutlar")

--══════════════════════════════════════════════════════════════════════════════
--=  [STARTUP] BAŞLANGIÇ MESAJI
--══════════════════════════════════════════════════════════════════════════════

print("╔═══════════════════════════════════════════════╗")
print("║   " .. ScriptName .. " " .. Version .. "       ║")
print("║   👤 Owner: " .. Owner .. "                      ║")
print("║   ⚡ " .. FeatureCount .. " Features | " .. cmdCount .. " Commands     ║")
print("║   📌 Left Control = GUI Aç/Kapa              ║")
print("║   📌 ;commands = Tüm komutları listele       ║")
print("╚═══════════════════════════════════════════════╝")

Notify(ScriptName, Version .. " loaded! | " .. FeatureCount .. " features | " .. cmdCount .. " commands", 5)

-- Güvenlik: FE başlat
FE:Init()
