--[[
â•”â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•—
â•‘         âš¡ MEGA ADMIN MODERN v3 â€” THORELL EDITION              â•‘
â•‘                                                                  â•‘
â•‘   Modern GUI + Settings + Tek Method (En Ä°yisi)                â•‘
â•‘   Executor: Madium âœ“  Xeno âœ“  Velocity âœ“                      â•‘
â•šâ•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
--]]

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/refs/heads/main/source.lua"))()
local Window = Library.CreateLogo("âš¡ MEGA ADMIN v3", "DarkTheme")

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
local TweenS = game:GetService("TweenService")
local HttpS = game:GetService("HttpService")

--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
--=  UTILITY
--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•

local function GCH() return LP.Character end
local function GHRP() local c = GCH(); return c and c:FindFirstChild("HumanoidRootPart") end
local function GH() local c = GCH(); return c and c:FindFirstChildOfClass("Humanoid") end
local function GTHRP(p) local c = p.Character; return c and c:FindFirstChild("HumanoidRootPart") end
local function GTH(p) local c = p.Character; return c and c:FindFirstChildOfClass("Humanoid") end
local function Nfy(t, x, d) pcall(function() game.StarterGui:SetCore("SendNotification", {Title=t or "", Text=x or "", Duration=d or 3}) end) end

local function GPIR(r)
    local tgs = {}
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LP and GTHRP(p) and GTH(p) and GTH(p).Health > 0 then
            local d = (GTHRP(p).Position - GHRP().Position).Magnitude
            if d <= (r or 99999) then table.insert(tgs, p) end
        end
    end
    return tgs
end

local function GCP(r)
    local closest, cd = nil, r or 99999
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LP and GTHRP(p) and GTH(p) and GTH(p).Health > 0 then
            local d = (GTHRP(p).Position - GHRP().Position).Magnitude
            if d < cd then cd = d; closest = p end
        end
    end
    return closest
end

-- Player list updater
local PL = {}
local function UPL()
    PL = {}
    for _, p in pairs(Players:GetPlayers()) do if p ~= LP then table.insert(PL, p.Name) end end
end
UPL()
Players.PlayerAdded:Connect(UPL)
Players.PlayerRemoving:Connect(UPL)

--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
--=  FE BYPASS MOTORU [TEK METOT â€” EN Ä°YÄ°SÄ°]
--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
-- Best method: Metatable __namecall hook
-- Ã‡alÄ±ÅŸÄ±r: Madium âœ“ Xeno âœ“ Velocity âœ“

local mt = getrawmetatable(game)
local __namecall = mt.__namecall
local hooked = false

local function InitFE()
    if hooked then return end
    hooked = true
    setreadonly(mt, false)
    mt.__namecall = protectfunction or function(f) return f end or function(f) return f end
    mt.__namecall = function(self, ...)
        local method = getnamecallmethod() or ""
        -- Anti-Kick: "kick" iÃ§eren remotekarÄ± engelle
        if Toggles.AntiKick.Value and method == "FireServer" then
            local s = tostring(self):lower()
            if s:find("kick") or s:find("ban") or s:find("remove") then return end
        end
        -- Anti-Tools: tool remotekarÄ±nÄ± engelle
        if Toggles.AntiTools.Value and method == "FireServer" and tostring(self):lower():find("tool") then return end
        return __namecall(self, ...)
    end
    setreadonly(mt, true)
    Nfy("FE Motor", "Aktif | Kick/Tools koruma")
end

--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
--=  SETTINGS / Toggle & Options Store
--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•

Toggles = {}
Options = {}

function Toggle(name, default)
    Toggles[name] = {Value = default}
    return Toggles[name]
end

function Opt(name, default)
    Options[name] = {Value = default}
    return Options[name]
end

-- TÃ¼m toggle'larÄ± tanÄ±mla
Toggle("GodMode", false)
Toggle("Noclip", false)
Toggle("Fly", false)
Toggle("InfiniteJump", false)
Toggle("Invisible", false)
Toggle("AntiKick", false)
Toggle("AntiAFK", false)
Toggle("AntiTools", false)
Toggle("NoFallDamage", false)
Toggle("SpinBot", false)
Toggle("ESP", false)
Toggle("FullBright", false)
Toggle("XRay", false)
Toggle("Highlight", false)
Toggle("Wallhack", false)
Toggle("Aimbot", false)
Toggle("Triggerbot", false)
Toggle("DamageAura", false)
Toggle("AutoClick", false)
Toggle("ClickTP", false)
Toggle("BHop", false)
Toggle("AutoHeal", false)

-- Options
Opt("FlySpeed", 50)
Opt("WalkSpeed", 16)
Opt("JumpPower", 50)
Opt("AuraRange", 20)
Opt("AuraDamage", 5)
Opt("HitboxSize", 3)
Opt("FOV", 70)
Opt("Gravity", 196)
Opt("Time", 12)
Opt("SpinSpeed", 10)

--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
--=  PLAYER TAB
--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•

local PTab = Window:NewTab("ğŸ® Player")
local PSec = PTab:NewSection("â€”â€” MODLAR â€”â€”")
local PSec2 = PTab:NewSection("â€”â€” ANTI â€”â€”")
local PSec3 = PTab:NewSection("â€”â€” HAREKET â€”â€”")
local PSec4 = PTab:NewSection("â€”â€” KARAKTER â€”â€”")

-- GOD MODE [BEST: Looped MaxHealth + Health set]
PSec:NewToggle("God Mode", "Ã–lmezsin â€” Health loop korumasÄ±", function(s)
    Toggles.GodMode.Value = s
    if s then
        local h = GH()
        if h then h.MaxHealth = 9e9; h.Health = 9e9; h.BreakJointsOnDeath = false end
        coroutine.wrap(function()
            while Toggles.GodMode.Value do
                wait(0.3)
                local h2 = GH()
                if h2 then
                    if h2.Health < 1 then h2.Health = 9e9 end
                    h2.MaxHealth = 9e9
                    h2.BreakJointsOnDeath = false
                end
            end
        end)()
        Nfy("God Mode", "âœ… Aktif")
    else
        Nfy("God Mode", "KapalÄ±")
    end
end)

-- NOCLIP [BEST: Stepped CanCollide loop]
PSec:NewToggle("Noclip", "DuvarlarÄ±n iÃ§inden yÃ¼rÃ¼", function(s)
    Toggles.Noclip.Value = s
    Nfy("Noclip", s and "âœ… Aktif" or "KapalÄ±")
end)

-- Noclip loop
RS.Stepped:Connect(function()
    if Toggles.Noclip.Value and GCH() then
        for _, p in pairs(GCH():GetDescendants()) do
            if p:IsA("BasePart") then p.CanCollide = false end
        end
    end
end)

-- FLY [BEST: BodyVelocity + BodyGyro]
PSec:NewToggle("Fly", "UÃ§ â€” Space yukarÄ±, Shift aÅŸaÄŸÄ±", function(s)
    Toggles.Fly.Value = s
    local hrp = GHRP()
    if not hrp then return end
    if s then
        local bv = Instance.new("BodyVelocity"); bv.MaxForce = Vector3.new(1e9,1e9,1e9); bv.P = 1e9; bv.Parent = hrp
        local bg = Instance.new("BodyGyro"); bg.MaxTorque = Vector3.new(1e9,1e9,1e9); bg.P = 1e9; bg.Parent = hrp
        local h = GH(); if h then h.PlatformStand = true end
        Nfy("Fly", "âœ… Aktif")
    else
        for _, v in pairs(hrp:GetChildren()) do
            if v:IsA("BodyVelocity") or v:IsA("BodyGyro") then v:Destroy() end
        end
        local h = GH(); if h then h.PlatformStand = false end
    end
end)

-- Fly loop
RS.Heartbeat:Connect(function()
    if Toggles.Fly.Value and GHRP() then
        local hrp = GHRP()
        local bv = hrp:FindFirstChildOfClass("BodyVelocity")
        local bg = hrp:FindFirstChildOfClass("BodyGyro")
        if bv and bg then
            local md = Vector3.new(
                UIS:IsKeyDown(Enum.KeyCode.D) and 1 or UIS:IsKeyDown(Enum.KeyCode.A) and -1 or 0,
                UIS:IsKeyDown(Enum.KeyCode.Space) and 1 or UIS:IsKeyDown(Enum.KeyCode.LeftShift) and -1 or 0,
                UIS:IsKeyDown(Enum.KeyCode.S) and 1 or UIS:IsKeyDown(Enum.KeyCode.W) and -1 or 0
            )
            bv.Velocity = md.Magnitude > 0 and Camera.CFrame:VectorToObjectSpace(md).Unit * Options.FlySpeed.Value or Vector3.new(0,0,0)
            bg.CFrame = Camera.CFrame
        end
    end
end)

-- INFINITE JUMP [BEST: JumpRequest hook]
PSec3:NewToggle("Infinite Jump", "Havada tekrar zÄ±pla", function(s)
    Toggles.InfiniteJump.Value = s
    Nfy("Inf Jump", s and "âœ… Aktif" or "KapalÄ±")
end)

UIS.JumpRequest:Connect(function()
    if Toggles.InfiniteJump.Value and GH() then GH():ChangeState(Enum.HumanoidStateType.Jumping) end
end)

-- INVISIBLE [BEST: Transparency loop]
PSec3:NewToggle("Invisible", "Seni kimse gÃ¶rmez", function(s)
    Toggles.Invisible.Value = s
    local c = GCH()
    if c then
        for _, p in pairs(c:GetDescendants()) do
            if p:IsA("BasePart") then p.Transparency = s and 1 or 0; p.CanCollide = not s end
        end
    end
end)

-- B-HOP [BEST: Auto jump while moving]
PSec3:NewToggle("B-Hop", "KoÅŸarken otomatik zÄ±pla", function(s)
    Toggles.BHop.Value = s
    if s then
        coroutine.wrap(function()
            while Toggles.BHop.Value do
                wait(0.15)
                if GH() and GH().MoveDirection.Magnitude > 0 then GH():ChangeState(Enum.HumanoidStateType.Jumping) end
            end
        end)()
    end
end)

-- SPIN BOT [BEST: CFrame rotation loop]
PSec3:NewToggle("Spin Bot", "Kendi etrafÄ±nda dÃ¶n", function(s)
    Toggles.SpinBot.Value = s
    if s then
        coroutine.wrap(function()
            while Toggles.SpinBot.Value do
                RS.RenderStepped:Wait()
                if GHRP() then GHRP().CFrame = GHRP().CFrame * CFrame.Angles(0, math.rad(Options.SpinSpeed.Value), 0) end
            end
        end)()
    end
end)

-- WalkSpeed slider
PSec3:NewSlider("Walk Speed", "KoÅŸma hÄ±zÄ±", 500, 16, function(s)
    Options.WalkSpeed.Value = s
    if GH() then GH().WalkSpeed = s end
end)

-- JumpPower slider
PSec3:NewSlider("Jump Power", "ZÄ±plama gÃ¼cÃ¼", 500, 50, function(s)
    Options.JumpPower.Value = s
    if GH() then GH().JumpPower = s end
end)

-- Fly Speed slider
PSec3:NewSlider("Fly Speed", "UÃ§uÅŸ hÄ±zÄ±", 500, 50, function(s) Options.FlySpeed.Value = s end)

-- ANTI-KICK [BEST: Metatable namecall hook]
PSec2:NewToggle("Anti-Kick", "AtÄ±lamazsÄ±n â€” FE Metatable Hook", function(s)
    Toggles.AntiKick.Value = s
    InitFE()
    Nfy("Anti-Kick", s and "âœ… Aktif" or "KapalÄ±")
end)

-- ANTI-AFK [BEST: VirtualUser loop]
PSec2:NewToggle("Anti-AFK", "AFK'den atÄ±lmazsÄ±n", function(s)
    Toggles.AntiAFK.Value = s
    if s then
        coroutine.wrap(function()
            while Toggles.AntiAFK.Value do
                wait(45)
                VU:CaptureController(); VU:ClickButton2(Vector2.new())
            end
        end)()
    end
end)

-- ANTI-TOOLS
PSec2:NewToggle("Anti-Tools", "Tool spamÄ±na karÅŸÄ± koruma", function(s)
    Toggles.AntiTools.Value = s
    InitFE()
end)

-- NO FALL DAMAGE [BEST: Humanoid.FallDamage disable]
PSec2:NewToggle("No Fall Damage", "DÃ¼ÅŸÃ¼ÅŸ hasarÄ± almazsÄ±n", function(s)
    Toggles.NoFallDamage.Value = s
    if GH() then GH().FallDamage = not s end
end)

-- AUTO HEAL [BEST: Health loop]
PSec4:NewToggle("Auto Heal", "CanÄ±n hep full kalsÄ±n", function(s)
    Toggles.AutoHeal.Value = s
    if s then
        coroutine.wrap(function()
            while Toggles.AutoHeal.Value do
                wait(1)
                if GH() and GH().Health < GH().MaxHealth then GH().Health = GH().MaxHealth end
            end
        end)()
    end
end)

PSec4:NewButton("Reset Character", "Karakteri sÄ±fÄ±rla", function()
    local c = GCH()
    if c then c:BreakJoints() end
    wait(2); LP:LoadCharacter()
end)

--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
--=  VISUAL TAB
--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•

local VTab = Window:NewTab("ğŸ‘ï¸ Visual")
local VSec = VTab:NewSection("â€”â€” GÃ–RSEL â€”â€”")
local VSec2 = VTab:NewSection("â€”â€” IÅIK & KAMERA â€”â€”")

-- ESP [BEST: BillboardGui + Highlight]
local ESP_Objects = {}
VSec:NewToggle("ESP", "OyuncularÄ± duvar arkasÄ±ndan gÃ¶r", function(s)
    Toggles.ESP.Value = s
    if s then
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LP and p.Character then
                local hrp = GTHRP(p)
                local head = p.Character:FindFirstChild("Head") or hrp
                if hrp and head then
                    -- Highlight
                    local hl = Instance.new("Highlight", p.Character)
                    hl.FillColor = Color3.new(1,0,0); hl.FillTransparency = 0.5
                    table.insert(ESP_Objects, hl)
                    -- Billboard (isim + mesafe)
                    local bbg = Instance.new("BillboardGui", p.Character)
                    bbg.Adornee = head; bbg.Size = UDim2.new(0,200,0,50); bbg.StudsOffset = Vector3.new(0,3,0)
                    local tl = Instance.new("TextLabel", bbg)
                    tl.Size = UDim2.new(1,0,1,0); tl.BackgroundTransparency = 1
                    tl.Text = p.Name; tl.TextStrokeTransparency = 0.3; tl.TextColor3 = Color3.new(1,1,1)
                    tl.TextScaled = true; tl.Font = Enum.Font.SourceSansBold
                    table.insert(ESP_Objects, bbg)
                end
            end
        end
        -- Distance updater
        coroutine.wrap(function()
            while Toggles.ESP.Value do
                wait(0.5)
                for _, p in pairs(Players:GetPlayers()) do
                    if p ~= LP and p.Character then
                        for _, bbg in pairs(p.Character:GetDescendants()) do
                            if bbg:IsA("BillboardGui") and bbg:FindFirstChildOfClass("TextLabel") then
                                local d = GTHRP(p) and GHRP() and math.floor((GTHRP(p).Position - GHRP().Position).Magnitude) or 0
                                bbg.TextLabel.Text = p.Name .. " [" .. d .. "m]"
                            end
                        end
                    end
                end
            end
        end)()
        Nfy("ESP", "âœ… Aktif")
    else
        for _, obj in pairs(ESP_Objects) do pcall(function() obj:Destroy() end) end
        ESP_Objects = {}
        for _, p in pairs(Players:GetPlayers()) do
            if p.Character then
                for _, c in pairs(p.Character:GetDescendants()) do
                    if c:IsA("BillboardGui") or c:IsA("Highlight") then pcall(function() c:Destroy() end) end
                end
            end
        end
    end
end)

-- HIGHLIGHT [BEST: Highlight]
VSec:NewToggle("Highlight", "KÄ±rmÄ±zÄ± parlak vurgu", function(s)
    Toggles.Highlight.Value = s
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LP and p.Character then
            if s then
                Instance.new("Highlight", p.Character).FillColor = Color3.new(1,0,0); Instance.new("Highlight", p.Character).FillTransparency = 0.5
            else
                for _, hl in pairs(p.Character:GetDescendants()) do if hl:IsA("Highlight") then hl:Destroy() end end
            end
        end
    end
end)

-- FULL BRIGHT [BEST: Lighting override]
VSec2:NewToggle("Full Bright", "Geceyi gÃ¼ndÃ¼z yap", function(s)
    Toggles.FullBright.Value = s
    if s then
        Lighting.Ambient = Color3.new(1,1,1); Lighting.Brightness = 3; Lighting.FogEnd = 1e9
        Lighting.ClockTime = 12; Lighting.GlobalShadows = false
    else
        Lighting:SetGlobalLighting()
    end
end)

-- X-RAY [BEST: All parts transparency]
VSec:NewToggle("X-Ray", "Her ÅŸey ÅŸeffaf", function(s)
    Toggles.XRay.Value = s
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") then obj.Transparency = s and 0.7 or 0 end
    end
end)

-- WALLHACK [BEST: Anchored parts transparent]
VSec:NewToggle("Wallhack", "Duvarlar gÃ¶rÃ¼nmez", function(s)
    Toggles.Wallhack.Value = s
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") and obj.Anchored then obj.Transparency = s and 0.7 or 0 end
    end
end)

VSec2:NewSlider("FOV", "Kamera gÃ¶rÃ¼ÅŸ aÃ§Ä±sÄ±", 180, 70, function(s)
    Options.FOV.Value = s; Camera.FieldOfView = s
end)

VSec2:NewSlider("Gravity", "YerÃ§ekimi kuvveti", 500, 196, function(s)
    Options.Gravity.Value = s; workspace.Gravity = s
end)

VSec2:NewSlider("Time", "Harita saati", 24, 12, function(s)
    Options.Time.Value = s; Lighting.ClockTime = s
end)

--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
--=  TELEPORT TAB
--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•

local TTab = Window:NewTab("ğŸ“ Teleport")
local TSec = TTab:NewSection("â€”â€” IÅINLANMA â€”â€”")

-- CLICK TP [BEST: Mouse.Hit CFrame]
TSec:NewToggle("Click TP", "TÄ±kla gittiÄŸin yere Ä±ÅŸÄ±nlan", function(s)
    Toggles.ClickTP.Value = s
end)

Mouse.Button1Down:Connect(function()
    if Toggles.ClickTP.Value and GHRP() then
        GHRP().CFrame = CFrame.new(Mouse.Hit.X, Mouse.Hit.Y + 3, Mouse.Hit.Z)
    end
end)

TSec:NewDropdown("Oyuncuya IÅŸÄ±nlan", "SeÃ§ ve Ä±ÅŸÄ±nlan", PL, function(sel)
    local t = Players:FindFirstChild(sel)
    if t and GTHRP(t) and GHRP() then GHRP().CFrame = GTHRP(t).CFrame * CFrame.new(0,5,0) end
end)

TSec:NewDropdown("Getir (Bring)", "SeÃ§tiÄŸini yanÄ±na getir", PL, function(sel)
    local t = Players:FindFirstChild(sel)
    if t and GTHRP(t) and GHRP() then GTHRP(t).CFrame = GHRP().CFrame * CFrame.new(0,0,3) end
end)

TSec:NewButton("Herkesi Getir", "TÃ¼m oyuncularÄ± yanÄ±na Ä±ÅŸÄ±nla", function()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LP and GTHRP(p) and GHRP() then GTHRP(p).CFrame = GHRP().CFrame * CFrame.new(0,0,3) end
    end
end)

TSec:NewButton("Spawn'a Git", "HaritanÄ±n baÅŸlangÄ±cÄ±na Ä±ÅŸÄ±nlan", function()
    if GHRP() and workspace:FindFirstChild("SpawnLocation") then
        GHRP().CFrame = workspace.SpawnLocation.CFrame * CFrame.new(0,3,0)
    end
end)

TSec:NewButton("YukarÄ± (+50)", "", function() if GHRP() then GHRP().CFrame = GHRP().CFrame * CFrame.new(0,50,0) end end)
TSec:NewButton("AÅŸaÄŸÄ± (-50)", "", function() if GHRP() then GHRP().CFrame = GHRP().CFrame * CFrame.new(0,-50,0) end end)

--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
--=  COMBAT TAB
--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•

local CTab = Window:NewTab("âš”ï¸ Combat")
local CSec = CTab:NewSection("â€”â€” SAVAÅ â€”â€”")

-- AIMBOT [BEST: Camera CFrame lock to closest head]
CSec:NewToggle("Aimbot", "En yakÄ±n oyuncuya otomatik niÅŸan", function(s)
    Toggles.Aimbot.Value = s
    if s then
        coroutine.wrap(function()
            while Toggles.Aimbot.Value do
                RS.RenderStepped:Wait()
                local t = GCP(Options.FOV.Value * 3)
                if t and t.Character and t.Character:FindFirstChild("Head") and GTH(t) and GTH(t).Health > 0 then
                    Camera.CFrame = CFrame.lookAt(Camera.CFrame.Position, t.Character.Head.Position)
                end
            end
        end)()
    end
end)

-- TRIGGERBOT [BEST: Mouse.Target check]
CSec:NewToggle("Triggerbot", "Hedef niÅŸangahta olunca otomatik tÄ±kla", function(s)
    Toggles.Triggerbot.Value = s
    if s then
        coroutine.wrap(function()
            while Toggles.Triggerbot.Value do
                RS.RenderStepped:Wait()
                local target = Mouse.Target
                if target then
                    for _, p in pairs(Players:GetPlayers()) do
                        if p ~= LP and p.Character and target:IsDescendantOf(p.Character) then
                            mouse1click(); wait(0.05)
                        end
                    end
                end
            end
        end)()
    end
end)

-- DAMAGE AURA [BEST: Loop health reduction in range]
CSec:NewToggle("Damage Aura", "YakÄ±ndaki herkese hasar ver", function(s)
    Toggles.DamageAura.Value = s
    if s then
        coroutine.wrap(function()
            while Toggles.DamageAura.Value do
                wait(0.3)
                for _, target in pairs(GPIR(Options.AuraRange.Value)) do
                    local th = GTH(target)
                    if th and th.Health > 0 then th.Health = th.Health - Options.AuraDamage.Value end
                end
            end
        end)()
    end
end)

-- AUTO CLICK [BEST: mouse1click loop]
CSec:NewToggle("Auto Click", "SÃ¼rekli otomatik tÄ±kla", function(s)
    Toggles.AutoClick.Value = s
    if s then
        coroutine.wrap(function()
            while Toggles.AutoClick.Value do
                mouse1click(); wait(0.05)
            end
        end)()
    end
end)

CSec:NewSlider("Aura Range", "Aura menzili", 100, 20, function(s) Options.AuraRange.Value = s end)
CSec:NewSlider("Aura Damage", "Aura hasarÄ±", 50, 5, function(s) Options.AuraDamage.Value = s end)
CSec:NewSlider("Hitbox Size", "Hitbox geniÅŸliÄŸi", 20, 3, function(s)
    Options.HitboxSize.Value = s
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LP and p.Character then
            for _, part in pairs(p.Character:GetDescendants()) do
                if part:IsA("BasePart") then part.Size = Vector3.new(s, s, s) end
            end
        end
    end
end)

--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
--=  ADMIN TAB
--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•

local ATab = Window:NewTab("ğŸ‘‘ Admin")
local ASec = ATab:NewSection("â€”â€” FE YÃ–NETÄ°CÄ° KOMUTLARI â€”â€”")

-- FE KICK [BEST: BreakJoints + Health zero + Remote attempt]
local function FEKickPlayer(t)
    if not t then return end
    local c = t.Character
    if c then
        if c:FindFirstChildOfClass("Humanoid") then c:FindFirstChildOfClass("Humanoid").Health = 0 end
        c:BreakJoints()
    end
    -- Remote kick attempt
    local kr = game:GetDescendants()
    for _, r in pairs(kr) do
        if r:IsA("RemoteEvent") and r.Name:lower():find("kick") then
            pcall(function() r:FireServer(t) end)
        end
    end
end

local function FEKillPlayer(t)
    if not t or not t.Character then return end
    local h = t.Character:FindFirstChildOfClass("Humanoid")
    if h then h.Health = 0; h:BreakJoints() end
end

ASec:NewDropdown("Kick (At)", "FE Kick â€” Oyuncuyu at", PL, function(sel)
    local t = Players:FindFirstChild(sel)
    if t then FEKickPlayer(t); Nfy("KICK", t.Name) end
end)

ASec:NewButton("Kick All (Hepsini At)", "", function()
    for _, p in pairs(Players:GetPlayers()) do if p ~= LP then FEKickPlayer(p) end end
end)

ASec:NewDropdown("Kill (Ã–ldÃ¼r)", "FE Kill", PL, function(sel)
    local t = Players:FindFirstChild(sel)
    if t then FEKillPlayer(t); Nfy("KILL", t.Name) end
end)

ASec:NewButton("Kill All (Hepsini Ã–ldÃ¼r)", "", function()
    for _, p in pairs(Players:GetPlayers()) do if p ~= LP then FEKillPlayer(p) end end
end)

ASec:NewDropdown("Freeze (Dondur)", "FE Freeze â€” BodyPosition", PL, function(sel)
    local t = Players:FindFirstChild(sel)
    if t and GTHRP(t) then
        local bp = Instance.new("BodyPosition"); bp.Position = GTHRP(t).Position
        bp.MaxForce = Vector3.new(1e9,1e9,1e9); bp.P = 1e9; bp.Parent = GTHRP(t)
    end
end)

ASec:NewButton("Freeze All (Hepsini Dondur)", "", function()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LP and GTHRP(p) then
            local bp = Instance.new("BodyPosition"); bp.Position = GTHRP(p).Position
            bp.MaxForce = Vector3.new(1e9,1e9,1e9); bp.P = 1e9; bp.Parent = GTHRP(p)
        end
    end
end)

ASec:NewDropdown("Unfreeze (Ã‡Ã¶z)", "", PL, function(sel)
    local t = Players:FindFirstChild(sel)
    if t and GTHRP(t) then
        for _, v in pairs(GTHRP(t):GetChildren()) do if v:IsA("BodyPosition") then v:Destroy() end end
    end
end)

ASec:NewButton("Unfreeze All (Hepsini Ã‡Ã¶z)", "", function()
    for _, p in pairs(Players:GetPlayers()) do
        if GTHRP(p) then
            for _, v in pairs(GTHRP(p):GetChildren()) do if v:IsA("BodyPosition") then v:Destroy() end end
        end
    end
end)

ASec:NewDropdown("Jail (Hapis)", "Kafesle", PL, function(sel)
    local t = Players:FindFirstChild(sel)
    if t and GTHRP(t) then
        local pos = GTHRP(t).Position
        for dx = -5, 5, 2 do
            for dz = -5, 5, 2 do
                if math.abs(dx) <= 4 or math.abs(dz) <= 4 then
                    local p = Instance.new("Part"); p.Size = Vector3.new(2,1,2); p.Position = pos + Vector3.new(dx,0,dz)
                    p.Anchored = true; p.BrickColor = BrickColor.new("Bright red"); p.Parent = workspace
                    game:GetService("Debris"):AddItem(p, 60)
                end
            end
        end
        local ceil = Instance.new("Part"); ceil.Size = Vector3.new(12,1,12); ceil.Position = pos + Vector3.new(0,6,0)
        ceil.Anchored = true; ceil.Parent = workspace
        game:GetService("Debris"):AddItem(ceil, 60)
    end
end)

ASec:NewButton("Lag (Sunucuyu YavaÅŸlat)", "", function()
    for i = 1, 1000 do
        local p = Instance.new("Part"); p.Position = Vector3.new(math.random(-100,100),50,math.random(-100,100))
        p.Velocity = Vector3.new(math.random(-100,100),math.random(-100,100),math.random(-100,100)); p.Parent = workspace
        game:GetService("Debris"):AddItem(p, 10)
    end
end)

ASec:NewDropdown("Heal (Ä°yileÅŸtir)", "", PL, function(sel)
    local t = Players:FindFirstChild(sel)
    if t and GTH(t) then GTH(t).Health = GTH(t).MaxHealth end
end)

ASec:NewButton("Heal All", "", function()
    for _, p in pairs(Players:GetPlayers()) do if GTH(p) then GTH(p).Health = GTH(p).MaxHealth end end
end)

--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
--=  SCRIPTS TAB
--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•

local STab = Window:NewTab("ğŸ“œ Scripts")
local SSec = STab:NewSection("â€”â€” HAZIR SCRIPTS (TEK TIKLA) â€”â€”")

local scripts = {
    {"Infinite Yield", "EdgeIY/infiniteyield/master/source"},
    {"Dex Explorer V4", "Bertie2004/Dex/main/Explorer%20V4.lua"},
    {"Remote Spy", "exxtremestuffs/RemoteSpy/master/Source.lua"},
    {"Cmd-X", "CMD-X/CMD-X/master/main"},
    {"Dark Dex V3", "Babyhamsta/Roblox/main/Universal/Scripts/DarkDexV3.lua"},
    {"Chat Spoofer", "Babyhamsta/Roblox/main/Universal/Scripts/ChatSpoofer.lua"},
    {"ESP V3", nil},
}

for _, s in pairs(scripts) do
    local name = s[1]; local url = s[2]
    SSec:NewButton(name, "Tek tÄ±kla Ã§alÄ±ÅŸtÄ±r", function()
        if url then
            pcall(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/" .. url))() end)
        end
    end)
end

--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
--=  MISC TAB
--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•

local MTab = Window:NewTab("ğŸ”§ Misc")
local MSec = MTab:NewSection("â€”â€” Ã‡EÅÄ°TLÄ° â€”â€”")

MSec:NewButton("Rejoin", "Sunucuya yeniden katÄ±l", function()
    TS:Teleport(game.PlaceId, LP)
end)

MSec:NewButton("Server Hop", "FarklÄ± bir sunucuya geÃ§", function()
    local s, d = pcall(function() return HttpS:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?limit=100")) end)
    if s and d and d.data then
        for _, sv in pairs(d.data) do
            if sv.id ~= game.JobId and sv.playing < sv.maxPlayers then
                TS:TeleportToPlaceInstance(game.PlaceId, sv.id, LP); return
            end
        end
    end
end)

MSec:NewButton("FPS Counter", "FPS sayacÄ± gÃ¶ster", function()
    local g = Instance.new("ScreenGui", CG)
    local l = Instance.new("TextLabel", g)
    l.Size = UDim2.new(0,100,0,30); l.Position = UDim2.new(0,10,0,10)
    l.BackgroundTransparency = 0.5; l.BackgroundColor3 = Color3.new(0,0,0)
    l.TextColor3 = Color3.new(0,1,0); l.Font = Enum.Font.SourceSansBold; l.TextScaled = true
    coroutine.wrap(function() while g.Parent do RS.RenderStepped:Wait(); l.Text = "FPS: " .. math.floor(1/RS.RenderStepped:Wait()) end end)()
end)

MSec:NewButton("Player List", "Oyuncu listesini gÃ¶ster", function()
    local names = {}
    for _, p in pairs(Players:GetPlayers()) do table.insert(names, p.Name .. (p == LP and " (SEN)" or "")) end
    Nfy("Players (" .. #Players:GetPlayers() .. ")", table.concat(names, ", "))
end)

--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
--=  SETTINGS TAB
--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•

local STab2 = Window:NewTab("âš™ï¸ Settings")
local SSec2 = STab2:NewSection("â€”â€” TEMA & GÃ–RÃœNÃœM â€”â€”")
local SSec3 = STab2:NewSection("â€”â€” KISAYOL TUÅLARI â€”â€”")
local SSec4 = STab2:NewSection("â€”â€” BÄ°LGÄ° â€”â€”")

-- Theme selector
SSec2:NewDropdown("Tema", "MenÃ¼ temasÄ±nÄ± deÄŸiÅŸtir", {"DarkTheme", "LightTheme", "GrapeTheme", "OceanTheme", "BloodTheme"}, function(sel)
    Library:Destroy()
    Window = Library.CreateLogo("âš¡ MEGA ADMIN v3", sel)
    -- Not: Script yeniden baÅŸlatÄ±lmalÄ±
    Nfy("Tema", sel .. " seÃ§ildi. Script'i tekrar Ã§alÄ±ÅŸtÄ±r.")
end)

-- GUI Toggle key
SSec3:NewKeybind("GUI AÃ§/Kapa", "MenÃ¼yÃ¼ gÃ¶ster/gizle", Enum.KeyCode.LeftControl, function()
    Window:Toggle()
end)

-- Quick keybinds
SSec3:NewKeybind("Noclip", "", Enum.KeyCode.N, function()
    Toggles.Noclip.Value = not Toggles.Noclip.Value
    Nfy("Noclip", Toggles.Noclip.Value and "âœ…" or "KapalÄ±")
end)

SSec3:NewKeybind("Fly", "", Enum.KeyCode.F, function()
    Toggles.Fly.Value = not Toggles.Fly.Value
    if Toggles.Fly.Value then
        local hrp = GHRP()
        if hrp then
            Instance.new("BodyVelocity", hrp).MaxForce = Vector3.new(1e9,1e9,1e9)
            Instance.new("BodyGyro", hrp).MaxTorque = Vector3.new(1e9,1e9,1e9)
        end
    else
        local hrp = GHRP()
        if hrp then
            for _, v in pairs(hrp:GetChildren()) do if v:IsA("BodyVelocity") or v:IsA("BodyGyro") then v:Destroy() end end
        end
    end
end)

SSec3:NewKeybind("God Mode", "", Enum.KeyCode.Q, function()
    local pv = Toggles.GodMode.Value
    Toggles.GodMode.Value = not pv
end)

SSec3:NewKeybind("ESP", "", Enum.KeyCode.E, function()
    -- Toggle ESP via toggle button
    if Toggles.ESP.Value then
        Toggles.ESP.Value = false
        for _, obj in pairs(ESP_Objects) do pcall(function() obj:Destroy() end) end
        ESP_Objects = {}
    else
        Toggles.ESP.Value = true
        -- ESP logic
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LP and p.Character then
                local hrp = GTHRP(p)
                local head = p.Character:FindFirstChild("Head") or hrp
                if hrp and head then
                    local hl = Instance.new("Highlight", p.Character); hl.FillColor = Color3.new(1,0,0); hl.FillTransparency = 0.5
                    table.insert(ESP_Objects, hl)
                    local bbg = Instance.new("BillboardGui", p.Character); bbg.Adornee = head; bbg.Size = UDim2.new(0,200,0,50); bbg.StudsOffset = Vector3.new(0,3,0)
                    local tl = Instance.new("TextLabel", bbg); tl.Size = UDim2.new(1,0,1,0); tl.BackgroundTransparency = 1
                    tl.Text = p.Name; tl.TextStrokeTransparency = 0.3; tl.TextColor3 = Color3.new(1,1,1); tl.TextScaled = true; tl.Font = Enum.Font.SourceSansBold
                    table.insert(ESP_Objects, bbg)
                end
            end
        end
    end
end)

SSec3:NewKeybind("Infinite Jump", "", Enum.KeyCode.G, function()
    Toggles.InfiniteJump.Value = not Toggles.InfiniteJump.Value
    Nfy("Inf Jump", Toggles.InfiniteJump.Value and "âœ…" or "KapalÄ±")
end)

SSec3:NewKeybind("Click TP", "", Enum.KeyCode.T, function()
    Toggles.ClickTP.Value = not Toggles.ClickTP.Value
    Nfy("Click TP", Toggles.ClickTP.Value and "âœ…" or "KapalÄ±")
end)

SSec3:NewKeybind("Speed Boost", "", Enum.KeyCode.X, function()
    if GH() then GH().WalkSpeed = 100; wait(5); GH().WalkSpeed = Options.WalkSpeed.Value end
end)

SSec3:NewKeybind("Reset", "", Enum.KeyCode.R, function()
    if GCH() then GCH():BreakJoints() end; wait(2); LP:LoadCharacter()
end)

-- Info
SSec4:NewLabel("âš¡ MEGA ADMIN v3 â€” THORELL EDITION")
SSec4:NewLabel("ğŸ“Œ Her Ã¶zellikte EN Ä°YÄ° FE method kullanÄ±lÄ±r")
SSec4:NewLabel("ğŸ§ª Test: Madium âœ“ Xeno âœ“ Velocity âœ“")
SSec4:NewLabel("")
SSec4:NewLabel("âš ï¸ Byfron oyunlarÄ± iÃ§in executor bypass gerek")
SSec4:NewLabel("   Arsenal / Da Hood / Doors / MM2 / PF")
SSec4:NewLabel("")
SSec4:NewLabel("KÄ±sayollar:")
SSec4:NewLabel("  LCtrl = GUI | N = Noclip")
SSec4:NewLabel("  F = Fly | Q = God | E = ESP")
SSec4:NewLabel("  G = InfJump | T = ClickTP")
SSec4:NewLabel("  X = Speed | R = Reset")
SSec4:NewLabel("")
SSec4:NewLabel("ğŸ‘¤ Owner: THORELL")
SSec4:NewLabel("âš¡ Built by Naiwles One")

--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
--=  END
--â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•

Nfy("âš¡ MEGA ADMIN v3", "YÃ¼klendi! LCtrl = GUI | " .. #PL .. " oyuncu tespit edildi")

print("â•”â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•—")
print("â•‘  âš¡ MEGA ADMIN v3 â€” THORELL EDITION           â•‘")
print("â•‘  âœ… Modern Menu | Tek Method | Ayarlar       â•‘")
print("â•‘  ğŸ“Œ Left Control = GUI | TÃ¼m Ã¶zellikler hazÄ±râ•‘")
print("â•šâ•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•")
