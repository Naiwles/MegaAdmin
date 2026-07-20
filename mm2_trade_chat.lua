-- MM2 TRADE SCAM â€” THORELL EDITION (Madium icin)
-- Basit, temiz, calisir. 0 obfuscation, 0 external UI

local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local RS = game:GetService("RunService")

-- Basit notify
local function Nfy(t, x)
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {Title = t or "", Text = x or "", Duration = 4})
    end)
end

-- Ana durum
local frozen = false
local tradeClone = nil
local accepted = false

-- ===== KOMUT SISTEMI =====
LP.Chatted:Connect(function(msg)
    if msg:sub(1,1) ~= ";" then return end
    local parts = msg:sub(2):split(" ")
    local cmd = parts[1]:lower()
    
    if cmd == "freeze" or cmd == "frz" then
        -- Trade arayuzunu bul ve dondur
        local tradeFound = false
        for _, obj in pairs(LP.PlayerGui:GetDescendants()) do
            if obj:IsA("Frame") and obj.Visible and obj.AbsoluteSize.X > 200 then
                local name = obj.Name:lower()
                -- MM2 trade frame'ini bul (genellikle "trade" iceren veya en buyuk frame)
                if name:find("trade") or name:find("offer") then
                    -- Clone yap
                    tradeClone = obj:Clone()
                    tradeClone.Parent = LP.PlayerGui
                    tradeClone.Name = "FrozenTrade"
                    tradeClone.Position = obj.Position
                    obj.Visible = false
                    tradeFound = true
                    frozen = true
                    Nfy("FREEZE", "Trade donduruldu! Itemlari al")
                    break
                end
            end
        end
        
        if not tradeFound then
            -- Ikinci yontem: En buyuk frame'i bul (genellikle trade UI)
            local largest = nil
            local largestSize = 0
            for _, obj in pairs(LP.PlayerGui:GetDescendants()) do
                if obj:IsA("Frame") and obj.Visible then
                    local size = obj.AbsoluteSize.X * obj.AbsoluteSize.Y
                    if size > largestSize then
                        largestSize = size
                        largest = obj
                    end
                end
            end
            if largest and largestSize > 50000 then
                tradeClone = largest:Clone()
                tradeClone.Parent = LP.PlayerGui
                tradeClone.Name = "FrozenTrade"
                tradeClone.Position = largest.Position
                largest.Visible = false
                frozen = true
                Nfy("FREEZE", "Trade donduruldu (auto-detect)")
            else
                Nfy("HATA", "Trade bulunamadi! Trade'i ac ve ;freeze yaz")
            end
        end
    
    elseif cmd == "accept" or cmd == "force" then
        -- Force accept: remote eventleri dene
        local denendi = 0
        for _, obj in pairs(game:GetDescendants()) do
            if obj:IsA("RemoteEvent") then
                local n = obj.Name:lower()
                if n:find("accept") or n:find("confirm") or n:find("trade") then
                    pcall(function()
                        obj:FireServer()
                        obj:FireServer(true)
                        obj:FireServer(LP)
                        obj:FireServer(Players:GetChildren())
                        denendi = denendi + 1
                    end)
                end
            end
            if obj:IsA("RemoteFunction") then
                local n = obj.Name:lower()
                if n:find("accept") or n:find("confirm") or n:find("trade") then
                    pcall(function()
                        obj:InvokeServer()
                        obj:InvokeServer(true)
                        denendi = denendi + 1
                    end)
                end
            end
        end
        
        if denendi > 0 then
            accepted = true
            Nfy("FORCE ACCEPT", denendi.." remote tetiklendi! Trade gecti mi kontrol et")
        else
            Nfy("HATA", "Accept remote bulunamadi. :(")
        end
    
    elseif cmd == "unfreeze" or cmd == "reset" then
        frozen = false
        local ft = LP.PlayerGui:FindFirstChild("FrozenTrade")
        if ft then ft:Destroy() end
        -- Orijinal trade'i geri getir
        for _, obj in pairs(LP.PlayerGui:GetDescendants()) do
            if obj:IsA("Frame") and obj.Name:lower():find("trade") then
                obj.Visible = true
            end
        end
        Nfy("UNFREEZE", "Trade cozuldu")
    
    elseif cmd == "tradescan" then
        -- Trade framelerini tara ve goster
        local say = 0
        for _, obj in pairs(LP.PlayerGui:GetDescendants()) do
            if obj:IsA("Frame") and obj.Visible then
                say = say + 1
            end
        end
        Nfy("TARAMA", "Frame bulundu: "..say)
    end
end)

-- Baslangic mesaji
Nfy("MM2 TRADE SCAM", "Yuklendi! Trade'i ac, sonra chat'e ;freeze yaz")

print("=== MM2 TRADE SCAM ===")
print("Komutlar:")
print("  ;freeze  - Trade'i dondur")
print("  ;accept  - Force accept")
print("  ;unfreeze - Coz")
print("  ;tradescan - Frame say")
print("======================")
