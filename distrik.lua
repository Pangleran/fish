-- loadstring(game:HttpGet("https://raw.githubusercontent.com/Pangleran/rblx/refs/heads/main/distrik.lua"))()

local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")
local StarterPlayer = game:GetService("StarterPlayer")
local VirtualUser = game:GetService("VirtualUser")
local LP = Players.LocalPlayer

local function alive(i)
    if not i then return false end
    local ok = pcall(function() return i.Parent end)
    return ok and i.Parent ~= nil
end
local function validPart(p) return p and alive(p) and p:IsA("BasePart") end
local function clamp(n,lo,hi) if n<lo then return lo elseif n>hi then return hi else return n end end
local function now() return os.clock() end
local function dist(a,b) return (a-b).Magnitude end

local function firstBasePart(inst)
    if not alive(inst) then return nil end
    if inst:IsA("BasePart") then return inst end
    if inst:IsA("Model") then
        if inst.PrimaryPart and inst.PrimaryPart:IsA("BasePart") and alive(inst.PrimaryPart) then return inst.PrimaryPart end
        local p = inst:FindFirstChildWhichIsA("BasePart", true)
        if validPart(p) then return p end
    end
    if inst:IsA("Tool") then
        local h = inst:FindFirstChild("Handle") or inst:FindFirstChildWhichIsA("BasePart")
        if validPart(h) then return h end
    end
    return nil
end

local function makeBillboard(text, color3)
    local g = Instance.new("BillboardGui")
    g.Name = "VD_Tag"
    g.AlwaysOnTop = true
    g.Size = UDim2.new(0, 200, 0, 36)
    g.StudsOffset = Vector3.new(0, 3, 0)
    local l = Instance.new("TextLabel")
    l.Name = "Label"
    l.BackgroundTransparency = 1
    l.Size = UDim2.new(1, 0, 1, 0)
    l.Font = Enum.Font.GothamBold
    l.Text = text
    l.TextSize = 14
    l.TextColor3 = color3 or Color3.new(1,1,1)
    l.TextStrokeTransparency = 0
    l.TextStrokeColor3 = Color3.new(0,0,0)
    l.Parent = g
    return g
end

local function ensureBoxESP(part, name, color)
    if not validPart(part) then return end
    local a = part:FindFirstChild(name)
    if not a then
        local ok, obj = pcall(function()
            local b = Instance.new("BoxHandleAdornment")
            b.Name = name
            b.Adornee = part
            b.ZIndex = 10
            b.AlwaysOnTop = true
            b.Transparency = 0.5
            b.Size = part.Size + Vector3.new(0.2,0.2,0.2)
            b.Color3 = color
            b.Parent = part
            return b
        end)
        if ok then a = obj end
    else
        a.Color3 = color
        a.Size = part.Size + Vector3.new(0.2,0.2,0.2)
    end
end

local function clearChild(o, n)
    if o and alive(o) then
        local c = o:FindFirstChild(n)
        if c then pcall(function() c:Destroy() end) end
    end
end

local function ensureHighlight(model, fill)
    if not (model and model:IsA("Model") and alive(model)) then return end
    local hl = model:FindFirstChild("VD_HL")
    if not hl then
        local ok, obj = pcall(function()
            local h = Instance.new("Highlight")
            h.Name = "VD_HL"
            h.Adornee = model
            h.FillTransparency = 0.5
            h.OutlineTransparency = 0
            h.Parent = model
            return h
        end)
        if ok then hl = obj else return end
    end
    hl.FillColor = fill
    hl.OutlineColor = fill
    hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
end

local function clearHighlight(model)
    if model and model:FindFirstChild("VD_HL") then
        pcall(function() model.VD_HL:Destroy() end)
    end
end

local Window   = Rayfield:CreateWindow({Name="Violence District",LoadingTitle="Violence District",LoadingSubtitle="Pangleran",ConfigurationSaving={Enabled=true,FolderName="VD_Suite",FileName="vd_config"},KeySystem=false})
local TabPlayer= Window:CreateTab("Player")
local TabESP   = Window:CreateTab("ESP")
local TabWorld = Window:CreateTab("World")
local TabMisc  = Window:CreateTab("Misc")

local function getRole(p)
    local tn = p.Team and p.Team.Name and p.Team.Name:lower() or ""
    if tn:find("killer") then return "Killer" end
    if tn:find("survivor") then return "Survivor" end
    return "Survivor"
end

local killerTypeName = "Killer"
local killerColors = {
    Jason = Color3.fromRGB(255, 60, 60),
    Stalker = Color3.fromRGB(255, 120, 60),
    Masked = Color3.fromRGB(255, 160, 60),
    Hidden = Color3.fromRGB(255, 60, 160),
    Abysswalker = Color3.fromRGB(120, 60, 255),
    Killer = Color3.fromRGB(255, 0, 0),
}
local function currentKillerColor()
    return killerColors[killerTypeName] or killerColors.Killer
end

local knownKillers = {Jason=true, Stalker=true, Masked=true, Hidden=true, Abysswalker=true}
do
    local r = ReplicatedStorage:FindFirstChild("Remotes")
    if r then
        local k = r:FindFirstChild("Killers")
        if k then
            for _,ch in ipairs(k:GetChildren()) do
                if ch:IsA("Folder") then knownKillers[ch.Name] = true end
            end
        end
    end
end

local function refreshKillerESPLabels()
    for _,pl in ipairs(Players:GetPlayers()) do
        if pl ~= LP and getRole(pl)=="Killer" then
            if pl.Character then
                local head = pl.Character:FindFirstChild("Head")
                if head then
                    local tag = head:FindFirstChild("VD_Tag")
                    if tag then
                        local l = tag:FindFirstChild("Label")
                        if l then l.Text = pl.Name.." ["..tostring(killerTypeName).."]" end
                    end
                end
            end
        end
    end
end

local function setKillerType(name)
    if name and knownKillers[name] and killerTypeName ~= name then
        killerTypeName = name
        refreshKillerESPLabels()
    end
end

local survivorColor = Color3.fromRGB(0,255,0)
local killerBaseColor = killerColors.Killer
local playerESPEnabled = false
local playerConns = {}

local function applyPlayerESP(p)
    if p == LP then return end
    local c = p.Character
    if not (c and alive(c)) then return end
    local col = (getRole(p)=="Killer") and currentKillerColor() or survivorColor

    if playerESPEnabled then
        if c:IsDescendantOf(Workspace) then ensureHighlight(c, col) end
    else
        clearHighlight(c)
    end
end

local function watchPlayer(p)
    if playerConns[p] then for _,cn in ipairs(playerConns[p]) do cn:Disconnect() end end
    playerConns[p] = {}
    table.insert(playerConns[p], p.CharacterAdded:Connect(function()
        task.delay(0.15, function() applyPlayerESP(p) end)
    end))
    table.insert(playerConns[p], p:GetPropertyChangedSignal("Team"):Connect(function() applyPlayerESP(p) end))
    if p.Character then applyPlayerESP(p) end
end
local function unwatchPlayer(p)
    if p.Character then
        clearHighlight(p.Character)
    end
    if playerConns[p] then for _,cn in ipairs(playerConns[p]) do cn:Disconnect() end end
    playerConns[p] = nil
end

TabESP:CreateSection("Players")
TabESP:CreateToggle({Name="Player ESP (Chams)",CurrentValue=false,Flag="PlayerESP",Callback=function(s) playerESPEnabled=s for _,pl in ipairs(Players:GetPlayers()) do if pl~=LP then applyPlayerESP(pl) end end end})

for _,p in ipairs(Players:GetPlayers()) do if p~=LP then watchPlayer(p) end end
Players.PlayerAdded:Connect(watchPlayer)
Players.PlayerRemoving:Connect(unwatchPlayer)

local worldColors = {
    Generator = Color3.fromRGB(0,170,255),
    Gate = Color3.fromRGB(255,225,0),
}
local worldEnabled = {Generator=false,Gate=false}
local validCats = {Generator=true,Gate=true}
local worldReg = {Generator={},Gate={}}
local mapAdd, mapRem = {}, {}

local function pickRep(model, cat)
    if not (model and alive(model)) then return nil end
    if cat == "Generator" then
        local hb = model:FindFirstChild("HitBox", true)
        if validPart(hb) then return hb end
    end
    return firstBasePart(model)
end

local function genLabelData(model)
    local pct = tonumber(model:GetAttribute("RepairProgress")) or 0
    if pct>=0 and pct<=1.001 then pct = pct*100 end
    pct = clamp(pct,0,100)
    local repairers = tonumber(model:GetAttribute("PlayersRepairingCount")) or 0
    local paused = (model:GetAttribute("ProgressPaused")==true)
    local kickcount = tonumber(model:GetAttribute("kickcount")) or 0
    local abyss50 = (model:GetAttribute("Abyss50Triggered")==true)
    local parts = {"Gen "..tostring(math.floor(pct+0.5)).."%" }
    if repairers>0 then parts[#parts+1]="("..repairers.."p)" end
    if paused then parts[#parts+1]="⏸" end
    if abyss50 then parts[#parts+1]="⚠" end
    if kickcount and kickcount>0 then parts[#parts+1]="K:"..kickcount end
    local text = table.concat(parts," ")
    local hue = clamp((pct/100)*0.33,0,0.33)
    local labelColor = Color3.fromHSV(hue,1,1)
    return text, labelColor
end

local function ensureWorldEntry(cat, model)
    if not alive(model) or worldReg[cat][model] then return end
    local rep = pickRep(model, cat)
    if not validPart(rep) then return end
    worldReg[cat][model] = {part = rep}
end
local function removeWorldEntry(cat, model)
    local e = worldReg[cat][model]
    if not e then return end
    clearChild(e.part, "VD_"..cat)
    clearChild(e.part, "VD_Text_"..cat)
    worldReg[cat][model] = nil
end

local function registerFromDescendant(obj)
    if not alive(obj) then return end
    if obj:IsA("Model") then
        if validCats[obj.Name] then
            ensureWorldEntry(obj.Name, obj)
            return
        end
    end
    if obj:IsA("BasePart") and obj.Parent and obj.Parent:IsA("Model") then
        if validCats[obj.Parent.Name] then
            ensureWorldEntry(obj.Parent.Name, obj.Parent)
            return
        end
    end
end
local function unregisterFromDescendant(obj)
    if not obj then return end
    if obj:IsA("Model") then
        if validCats[obj.Name] then
            removeWorldEntry(obj.Name, obj)
            return
        end
    end
    if obj:IsA("BasePart") and obj.Parent and obj.Parent:IsA("Model") then
        if validCats[obj.Parent.Name] then
            local e = worldReg[obj.Parent.Name][obj.Parent]
            if e and e.part == obj then removeWorldEntry(obj.Parent.Name, obj.Parent) end
            return
        end
        if isPumpkinModelName(obj.Parent.Name) then
            local e = worldReg.Pumpkin[obj.Parent]
            if e and e.part == obj then removeWorldEntry("Pumpkin", obj.Parent) end
            return
        end
    end
end
local function attachRoot(root)
    if not root or mapAdd[root] then return end
    mapAdd[root] = root.DescendantAdded:Connect(registerFromDescendant)
    mapRem[root] = root.DescendantRemoving:Connect(unregisterFromDescendant)
    for _,d in ipairs(root:GetDescendants()) do registerFromDescendant(d) end
end
local function refreshRoots()
    for _,cn in pairs(mapAdd) do if cn then cn:Disconnect() end end
    for _,cn in pairs(mapRem) do if cn then cn:Disconnect() end end
    mapAdd, mapRem = {}, {}
    local r1 = Workspace:FindFirstChild("Map")
    local r2 = Workspace:FindFirstChild("Map1")
    if r1 then attachRoot(r1) end
    if r2 then attachRoot(r2) end
end
refreshRoots()
Workspace.ChildAdded:Connect(function(ch) if ch.Name=="Map" or ch.Name=="Map1" then attachRoot(ch) end end)

local worldLoopThread=nil
local function anyWorldEnabled() for _,v in pairs(worldEnabled) do if v then return true end end return false end
local function startWorldLoop()
    if worldLoopThread then return end
    worldLoopThread = task.spawn(function()
        while anyWorldEnabled() do
            for cat,models in pairs(worldReg) do
                if worldEnabled[cat] then
                    local col, tagName, textName = worldColors[cat], "VD_"..cat, "VD_Text_"..cat
                    local n = 0
                    for model,entry in pairs(models) do
                        local part = entry.part
                        if model and alive(model) then
                            if not validPart(part) or (model:IsA("Model") and not part:IsDescendantOf(model)) then
                                entry.part = pickRep(model, cat); part = entry.part
                            end
                            if validPart(part) then
                                ensureBoxESP(part, tagName, col)
                                local bb = part:FindFirstChild(textName)
                                if not bb then
                                    local newbb = makeBillboard(cat, col)
                                    newbb.Name = textName
                                    newbb.Parent = part
                                    bb = newbb
                                end
                                local lbl = bb:FindFirstChild("Label")
                                if lbl then
                                    if cat=="Generator" then local txt,lblCol=genLabelData(model) lbl.Text=txt lbl.TextColor3=lblCol
                                    else lbl.Text=cat lbl.TextColor3=col end
                                end
                            end
                        else
                            removeWorldEntry(cat, model)
                        end
                        n = n + 1
                        if n % 60 == 0 then task.wait() end
                    end
                end
            end
            task.wait(0.25)
        end
        worldLoopThread=nil
    end)
end
local function setWorldToggle(cat, state)
    worldEnabled[cat] = state
    if state then
        if not worldLoopThread then startWorldLoop() end
    else
        for _,entry in pairs(worldReg[cat]) do
            if entry and entry.part then
                clearChild(entry.part,"VD_"..cat); clearChild(entry.part,"VD_Text_"..cat)
            end
        end
    end
end

TabWorld:CreateSection("Toggles")
TabWorld:CreateToggle({Name="Generators",CurrentValue=false,Flag="Gen",Callback=function(s) setWorldToggle("Generator", s) end})
TabWorld:CreateToggle({Name="Gates",CurrentValue=false,Flag="Gate",Callback=function(s) setWorldToggle("Gate", s) end})

local abilityNotifyEnabled = true
TabMisc:CreateSection("Notifications")
TabMisc:CreateToggle({Name="Killer Ability Notify",CurrentValue=true,Flag="AbilityNotify",Callback=function(s) abilityNotifyEnabled=s end})

local remoteHooks=setmetatable({},{__mode="k"})
local abilityAllow = {
    ["Killer.ActivatePower"]      = "Ability Activated",
    ["Jason.Instinct"]            = "Instinct",
    ["Masked.Activatepower"]      = "Dash",
    ["Hidden.M2"]                 = "M2",
    ["Stalker.StartStalking"]     = "Stalk",
    ["Abysswalker.corrupt"]       = "Corrupt",
}

local function connectRemote(inst)
    if remoteHooks[inst] then return end
    local isRE,isBE=inst:IsA("RemoteEvent"),inst:IsA("BindableEvent")
    if not(isRE or isBE) then return end
    local full = inst:GetFullName()
    local underKillers = full:find("ReplicatedStorage.Remotes.Killers",1,true)~=nil

    local function hook(fn)
        local conn
        if isRE then conn=inst.OnClientEvent:Connect(fn) else conn=inst.Event:Connect(fn) end
        remoteHooks[inst]=conn
    end

    if underKillers then
        local seg = string.split(full,".")
        for i=#seg,1,-1 do
            if seg[i]=="Killers" then
                local kn = seg[i+1]
                if kn and knownKillers[kn] then
                    hook(function(...)
                        setKillerType(kn)
                        local key = kn.."."..inst.Name
                        local label = abilityAllow[key]
                        if label and abilityNotifyEnabled then
                            Rayfield:Notify({Title="Killer Ability",Content=kn..": "..label,Duration=4})
                        end
                    end)
                else
                    local key = (kn or "Killer").."."..inst.Name
                    if abilityAllow[key] then
                        hook(function(...)
                            if abilityNotifyEnabled then
                                local who = knownKillers[kn or ""] and kn or killerTypeName
                                Rayfield:Notify({Title="Killer Ability",Content=tostring(who)..": "..abilityAllow[key],Duration=4})
                            end
                        end)
                    end
                end
                break
            end
        end
    end
end

for _,d in ipairs(ReplicatedStorage:GetDescendants()) do if d:IsA("RemoteEvent") or d:IsA("BindableEvent") then connectRemote(d) end end
ReplicatedStorage.DescendantAdded:Connect(function(d) if d:IsA("RemoteEvent") or d:IsA("BindableEvent") then connectRemote(d) end end)

TabPlayer:CreateSection("AFK")
local antiAFKConn=nil
local function setAntiAFK(state)
    if state and not antiAFKConn then
        antiAFKConn = LP.Idled:Connect(function()
            local cam = Workspace.CurrentCamera and Workspace.CurrentCamera.CFrame or CFrame.new()
            VirtualUser:Button2Down(Vector2.new(0,0), cam); task.wait(1); VirtualUser:Button2Up(Vector2.new(0,0), cam)
        end)
    elseif not state and antiAFKConn then
        antiAFKConn:Disconnect(); antiAFKConn=nil
    end
end
TabPlayer:CreateToggle({Name="Anti AFK",CurrentValue=false,Flag="AntiAFK",Callback=function(s) setAntiAFK(s) end})

local function isKillerTeam() local tn=LP.Team and LP.Team.Name and LP.Team.Name:lower() or "" return tn:find("killer",1,true)~=nil end
local guiWhitelist = {Rayfield=true,DevConsoleMaster=true,RobloxGui=true,PlayerList=true,Chat=true,BubbleChat=true,Backpack=true}
local skillExactNames = {SkillCheckPromptGui=true,["SkillCheckPromptGui-con"]=true,SkillCheckEvent=true,SkillCheckFailEvent=true,SkillCheckResultEvent=true}
local function isExactSkill(inst) local n=inst and inst.Name if not n then return false end if skillExactNames[n] then return true end return n:lower():find("skillcheck",1,true)~=nil end
local function hardDelete(obj)
    pcall(function()
        if obj:IsA("ProximityPrompt") then obj.Enabled=false obj.HoldDuration=1e9 end
        if obj:IsA("ScreenGui") or obj:IsA("BillboardGui") or obj:IsA("SurfaceGui") then
            if obj:IsA("ScreenGui") and guiWhitelist[obj.Name] then return end
            obj.Enabled=false obj.Visible=false obj.ResetOnSpawn=false obj:Destroy()
        else
            obj:Destroy()
        end
    end)
end
local function nukeSkillExactOnce()
    local pg=LP:FindFirstChild("PlayerGui")
    if pg then
        for _,g in ipairs(pg:GetChildren()) do if isExactSkill(g) then hardDelete(g) end end
        for _,d in ipairs(pg:GetDescendants()) do if isExactSkill(d) then hardDelete(d) end end
    end
    for _,g in ipairs(StarterGui:GetChildren()) do if isExactSkill(g) then hardDelete(g) end end
    local rem=ReplicatedStorage:FindFirstChild("Remotes")
    if rem then for _,d in ipairs(rem:GetDescendants()) do if isExactSkill(d) then hardDelete(d) end end end
end
local noSkillEnabled=false
local noSkillToggleUser=false
local hookSkillInstalled=false
local rsAddConn, pgAddConn, pgDescConn, sgAddConn, remAddConn, wsAddConn
local charAddConns={}
local function installSkillBlock()
    if hookSkillInstalled then return end
    if typeof(hookmetamethod)=="function" and typeof(getnamecallmethod)=="function" then
        local old
        old = hookmetamethod(game,"__namecall",function(self,...)
            local m=getnamecallmethod()
            if noSkillEnabled and typeof(self)=="Instance" and isExactSkill(self) and (m=="FireServer" or m=="InvokeServer") then
                return nil
            end
            return old(self,...)
        end)
        hookSkillInstalled=true
    end
end
local function startNoSkill()
    installSkillBlock()
    nukeSkillExactOnce()
    local pg=LP:FindFirstChild("PlayerGui")
    if pg then
        if pgAddConn then pgAddConn:Disconnect() end
        pgAddConn = pg.ChildAdded:Connect(function(ch) if noSkillEnabled and isExactSkill(ch) then hardDelete(ch) end end)
        if pgDescConn then pgDescConn:Disconnect() end
        pgDescConn = pg.DescendantAdded:Connect(function(d) if noSkillEnabled and isExactSkill(d) then hardDelete(d) end end)
    end
    if sgAddConn then sgAddConn:Disconnect() end
    sgAddConn = StarterGui.ChildAdded:Connect(function(ch) if noSkillEnabled and isExactSkill(ch) then hardDelete(ch) end end)
    local rem=ReplicatedStorage:FindFirstChild("Remotes")
    if rem then
        if remAddConn then remAddConn:Disconnect() end
        remAddConn = rem.DescendantAdded:Connect(function(d) if noSkillEnabled and isExactSkill(d) then hardDelete(d) end end)
    end
    if rsAddConn then rsAddConn:Disconnect() end
    rsAddConn = ReplicatedStorage.DescendantAdded:Connect(function(d)
        if not noSkillEnabled then return end
        if d:IsA("ScreenGui") or d:IsA("BillboardGui") or d:IsA("SurfaceGui") or d:IsA("RemoteEvent") or d:IsA("RemoteFunction") or d:IsA("BindableEvent") then
            if isExactSkill(d) then hardDelete(d) end
        end
    end)
    for _,pl in ipairs(Players:GetPlayers()) do
        if charAddConns[pl] then charAddConns[pl]:Disconnect() end
        charAddConns[pl] = pl.CharacterAdded:Connect(function(ch)
            if not noSkillEnabled then return end
            task.wait(0.1)
            for _,d in ipairs(ch:GetDescendants()) do if isExactSkill(d) then hardDelete(d) end end
        end)
        if pl.Character then for _,d in ipairs(pl.Character:GetDescendants()) do if isExactSkill(d) then hardDelete(d) end end end
    end
    if wsAddConn then wsAddConn:Disconnect() end
    wsAddConn = Workspace.DescendantAdded:Connect(function(d) if noSkillEnabled and isExactSkill(d) then hardDelete(d) end end)
end
local function stopNoSkill()
    if pgAddConn then pgAddConn:Disconnect() pgAddConn=nil end
    if pgDescConn then pgDescConn:Disconnect() pgDescConn=nil end
    if sgAddConn then sgAddConn:Disconnect() sgAddConn=nil end
    if remAddConn then remAddConn:Disconnect() remAddConn=nil end
    if rsAddConn then rsAddConn:Disconnect() rsAddConn=nil end
    if wsAddConn then wsAddConn:Disconnect() wsAddConn=nil end
    for pl,cn in pairs(charAddConns) do if cn then cn:Disconnect() end charAddConns[pl]=nil end
end
local function evalNoSkill()
    if noSkillToggleUser and not isKillerTeam() then
        if not noSkillEnabled then noSkillEnabled=true startNoSkill() end
    else
        if noSkillEnabled then noSkillEnabled=false stopNoSkill() end
    end
end
LP:GetPropertyChangedSignal("Team"):Connect(evalNoSkill)
TabMisc:CreateSection("Skillcheck")
TabMisc:CreateToggle({Name="No Skillchecks",CurrentValue=false,Flag="NoSkill",Callback=function(s) noSkillToggleUser=s evalNoSkill() end})

do
    local autoRepairEnabled = false
    local SCAN_INTERVAL = 1.0
    local REPAIR_TICK   = 0.25
    local AVOID_RADIUS  = 80
    local MOVE_DIST     = 35
    local UP_OFFSET     = Vector3.new(0, 3, 0)
    local gens = {}
    local current = nil
    local lastScan = 0

    local function findRemotes()
        local r = ReplicatedStorage:FindFirstChild("Remotes")
        if not r then return nil,nil end
        local g = r:FindFirstChild("Generator")
        if not g then return nil,nil end
        local repair = g:FindFirstChild("RepairEvent")
        local anim   = g:FindFirstChild("RepairAnim")
        return repair, anim
    end
    local RepairEvent, RepairAnim = findRemotes()

    local function ensureRemotes()
        if RepairEvent and RepairEvent.Parent then return end
        RepairEvent, RepairAnim = findRemotes()
    end

    local function getGenPartFromModel(m)
        if not (m and alive(m)) then return nil end
        local hb = m:FindFirstChild("HitBox", true)
        if validPart(hb) then return hb end
        return firstBasePart(m)
    end

    local function genProgress(m)
        local p = tonumber(m:GetAttribute("RepairProgress")) or 0
        if p <= 1.001 then p = p * 100 end
        return clamp(p,0,100)
    end

    local function genPaused(m)
        return (m:GetAttribute("ProgressPaused")==true)
    end

    local function rescanGenerators()
        gens = {}
        local function scanRoot(root)
            if not root then return end
            for _,d in ipairs(root:GetDescendants()) do
                if d:IsA("Model") and d.Name=="Generator" then
                    local part = getGenPartFromModel(d)
                    if validPart(part) then
                        table.insert(gens, {model=d, part=part})
                    end
                end
            end
        end
        scanRoot(Workspace:FindFirstChild("Map"))
        scanRoot(Workspace:FindFirstChild("Map1"))
    end

    local function nearestKillerDistanceTo(pos)
        local bd = 1e9
        for _,pl in ipairs(Players:GetPlayers()) do
            if pl ~= LP and getRole(pl)=="Killer" then
                local ch = pl.Character
                local hrp = ch and ch:FindFirstChild("HumanoidRootPart")
                if hrp then
                    local d = (hrp.Position - pos).Magnitude
                    if d < bd then bd = d end
                end
            end
        end
        return bd
    end

    local function lpHRP()
        return LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
    end

    local function chooseTarget()
        local best = nil
        local bestScore = -1
        for _,g in ipairs(gens) do
            local m = g.model
            if alive(m) then
                local prog = genProgress(m)
                if prog < 100 and not genPaused(m) then
                    local pos = g.part.Position
                    local kd = nearestKillerDistanceTo(pos)
                    local score = (kd >= AVOID_RADIUS and 1000 or 0) + prog
                    if score > bestScore then
                        bestScore = score
                        best = g
                    end
                end
            end
        end
        return best
    end

    local function safeFromKiller(target)
        if not target or not target.part then return false end
        local kd = nearestKillerDistanceTo(target.part.Position)
        return kd >= AVOID_RADIUS
    end

    local function closeEnough(target)
        local hrp = lpHRP(); if not hrp then return false end
        return (hrp.Position - target.part.Position).Magnitude <= MOVE_DIST
    end

    local function tpNear(part)
        local cf = part.CFrame * CFrame.new(0,0,-3)
        local hrp = lpHRP()
        if hrp then
            hrp.CFrame = cf + UP_OFFSET
        end
    end

    local function doRepair(target)
        ensureRemotes()
        if RepairAnim and RepairAnim.FireServer then pcall(function() RepairAnim:FireServer(target.model) end) end
        if RepairEvent and RepairEvent.FireServer then pcall(function() RepairEvent:FireServer(target.model) end) end
    end

    task.spawn(function()
        while true do
            local t = now()
            if t - lastScan >= SCAN_INTERVAL then
                lastScan = t
                rescanGenerators()
            end
            task.wait(0.2)
        end
    end)

    task.spawn(function()
        while true do
            if autoRepairEnabled then
                if (not current) or (not alive(current.model)) or genProgress(current.model) >= 100 or genPaused(current.model) or (not safeFromKiller(current)) then
                    current = chooseTarget()
                end

                if current and alive(current.model) and genProgress(current.model) < 100 then
                    local me = lpHRP()
                    if me and nearestKillerDistanceTo(me.Position) < AVOID_RADIUS then
                        local alt = chooseTarget()
                        if alt and alt ~= current then current = alt end
                    end

                    if not closeEnough(current) then
                        tpNear(current.part)
                    end

                    doRepair(current)
                end
            end
            task.wait(REPAIR_TICK)
        end
    end)

    TabWorld:CreateToggle({
        Name="Auto-Repair Gens",
        CurrentValue=false,
        Flag="AutoRepairGens",
        Callback=function(state)
            autoRepairEnabled = state
            Rayfield:Notify({
                Title="Auto-Repair",
                Content=state and "activated" or "deactivated",
                Duration=4
            })
        end
    })

    ReplicatedStorage.DescendantAdded:Connect(function(d)
        if d:IsA("RemoteEvent") and d.Name=="RepairEvent" then RepairEvent=d end
        if d:IsA("RemoteEvent") and d.Name=="RepairAnim"  then RepairAnim=d end
    end)
end

Rayfield:LoadConfiguration()
