--[[ 
    Vonx Hub | Escape Tsunami for Brainrots
    Key System + Admin Panel + Webhook Logs
]]

repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CoreGui = game:GetService("CoreGui")
local HttpService = game:GetService("HttpService")
local rf = ReplicatedStorage.RemoteFunctions
local lp = Players.LocalPlayer

-- =========================
-- 🔐 ENCRYPTED KEY SYSTEM
-- =========================

if CoreGui:FindFirstChild("VonxKeyUI") then
    CoreGui:FindFirstChild("VonxKeyUI"):Destroy()
end

-- Encrypted "TsunamiVonX"
local _k = {84,115,117,110,97,109,105,86,111,110,88}
local function _ck(input)
    if #input ~= #_k then return false end
    for i = 1, #_k do
        if input:byte(i) ~= _k[i] then
            return false
        end
    end
    return true
end

-- =========================
-- 🔒 ADMIN SYSTEM (ENCRYPTED)
-- =========================

-- Encrypted "woxlee_yann"
local _adminName = {119,111,120,108,101,101,95,121,97,110,110}

local function _isAdmin(player)
    local name = player.Name
    if #name ~= #_adminName then return false end
    for i = 1, #_adminName do
        if name:byte(i) ~= _adminName[i] then
            return false
        end
    end
    return true
end

local IS_ADMIN = _isAdmin(lp)

-- =========================
-- 🌐 WEBHOOK LOG SYSTEM
-- =========================

local WEBHOOK_URL = "https://discord.com/api/webhooks/1464474269751709726/p6gsb-FSu94ThdDRZwhcyYL2mOG-NRf-hBF2rJiqpzSt3MNO0bZGCBa-JNdVdt_3NocG"

local function sendLog(title, description)
    local data = {
        ["username"] = "Vonx Hub Logger",
        ["embeds"] = {{
            ["title"] = title,
            ["description"] = description,
            ["color"] = 65280,
            ["footer"] = { ["text"] = "Vonx Hub Logs" },
            ["timestamp"] = DateTime.now():ToIsoDate()
        }}
    }
    local json = HttpService:JSONEncode(data)
    pcall(function()
        syn.request({
            Url = WEBHOOK_URL,
            Method = "POST",
            Headers = {["Content-Type"] = "application/json"},
            Body = json
        })
    end)
end

sendLog("🔐 Script Loaded", "Player: "..lp.Name.." | UserId: "..lp.UserId)

-- =========================
-- 🎨 KEY UI (NEON GREEN / BLACK)
-- =========================

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "VonxKeyUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CoreGui

local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 340, 0, 270)
Frame.Position = UDim2.new(0.5, -170, 0.5, -135)
Frame.BackgroundColor3 = Color3.fromRGB(5, 5, 5)
Frame.BorderSizePixel = 0
Frame.Active = true
Frame.Draggable = true

Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 12)

local Title = Instance.new("TextLabel", Frame)
Title.Size = UDim2.new(1, 0, 0, 45)
Title.BackgroundTransparency = 1
Title.Text = "🔐 VonX HUB Login"
Title.TextColor3 = Color3.fromRGB(0, 255, 0)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 17

local TextBox = Instance.new("TextBox", Frame)
TextBox.Size = UDim2.new(1, -40, 0, 42)
TextBox.Position = UDim2.new(0, 20, 0, 60)
TextBox.PlaceholderText = "Enter key here..."
TextBox.Text = ""
TextBox.ClearTextOnFocus = false
TextBox.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
TextBox.TextColor3 = Color3.fromRGB(0, 255, 0)
TextBox.Font = Enum.Font.Gotham
TextBox.TextSize = 14

Instance.new("UICorner", TextBox).CornerRadius = UDim.new(0, 8)

local Submit = Instance.new("TextButton", Frame)
Submit.Size = UDim2.new(1, -40, 0, 42)
Submit.Position = UDim2.new(0, 20, 0, 115)
Submit.Text = "Submit Key"
Submit.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
Submit.TextColor3 = Color3.fromRGB(0, 0, 0)
Submit.Font = Enum.Font.GothamBold
Submit.TextSize = 14

Instance.new("UICorner", Submit).CornerRadius = UDim.new(0, 8)

-- 🔗 Discord Button (Clickable + Copy)
local GetKeyBtn = Instance.new("TextButton", Frame)
GetKeyBtn.Size = UDim2.new(1, -40, 0, 32)
GetKeyBtn.Position = UDim2.new(0, 20, 0, 165)
GetKeyBtn.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
GetKeyBtn.Text = "Get Key (Click to Copy)"
GetKeyBtn.TextColor3 = Color3.fromRGB(0, 255, 0)
GetKeyBtn.Font = Enum.Font.GothamBold
GetKeyBtn.TextSize = 12

Instance.new("UICorner", GetKeyBtn).CornerRadius = UDim.new(0, 6)

GetKeyBtn.MouseButton1Click:Connect(function()
    setclipboard("https://discord.gg/smdeH3uHBR")
    GetKeyBtn.Text = "Copied! ✅"
    task.wait(1.2)
    GetKeyBtn.Text = "Get Key (Click to Copy)"
end)

-- =========================
-- 🚀 MAIN SCRIPT FUNCTION
-- =========================

local function loadVonxHub()

    sendLog("✅ Login Success", "Player: "..lp.Name.." logged in successfully.")

    -- =========================
    -- Core Functions
    -- =========================

    local function godmode()
        local at = workspace:FindFirstChild("ActiveTsunamis")
        if not at then return end
        for _, v in pairs(at:GetDescendants()) do
            if v:IsA("BasePart") and v.Name == "Hitbox" then
                v:Destroy()
            end
        end
    end

    local function notsu()
        local at = workspace:FindFirstChild("ActiveTsunamis")
        if not at then return end
        for _, v in pairs(at:GetDescendants()) do
            if v:IsA("BasePart") then
                v.Transparency = 1
            end
        end
    end

    local function upgradespeed()
        local remote = rf:FindFirstChild("UpgradeSpeed")
        if remote then remote:InvokeServer(5) end
    end

    local function rebirth()
        local remote = rf:FindFirstChild("Rebirth")
        if remote then remote:InvokeServer() end
    end

    local function upgrade()
        local remote = rf:FindFirstChild("UpgradeBase")
        if remote then remote:InvokeServer() end
    end

    local function upgradec()
        local remote = rf:FindFirstChild("UpgradeCarry")
        if remote then remote:InvokeServer() end
    end

    local function sellall()
        local remote = rf:FindFirstChild("SellAll")
        if remote then remote:InvokeServer() end
    end

    local function upgradeb(slot)
        local remote = rf:FindFirstChild("UpgradeBrainrot")
        if remote then remote:InvokeServer(slot) end
    end

    local function getbase()
        local bases = workspace:FindFirstChild("Bases")
        if not bases then return nil end
        for _, v in pairs(bases:GetChildren()) do
            if v:IsA("Model") and v:GetAttribute("Holder") == lp.UserId then
                return v
            end
        end
        return nil
    end

    local function upgradeallb()
        local base = getbase()
        if not base then return end
        local slots = base:FindFirstChild("Slots")
        if not slots then return end
        for _, v in pairs(slots:GetChildren()) do
            if v:IsA("Model") and v.Name:lower():find("slot") and v:FindFirstChildWhichIsA("Tool") then
                upgradeb(v.Name)
            end
        end
    end

    local function home()
        local base = getbase()
        if not base then return end
        local part = base:FindFirstChild("Home")
        if not part then return end
        pcall(function()
            lp.Character.HumanoidRootPart.CFrame = part.CFrame
        end)
    end

    local function speedchanger()
        local speed = getgenv().Scv or 16
        lp:SetAttribute("CurrentSpeed", speed)
    end

    local tier = ""

    local function gayfunc()
        local plrgui = lp:FindFirstChild("PlayerGui")
        if not plrgui then return end
        for _, v in pairs(plrgui:GetDescendants()) do
            if v:IsA("TextLabel") and v.Text == "Carry limit reached!" then
                local safearea = workspace:FindFirstChild("Misc") and workspace.Misc:FindFirstChild("Ground")
                if safearea then
                    lp.Character.HumanoidRootPart.CFrame = safearea.CFrame + CFrame.new(0, 5, 0)
                end
            end
        end
    end

    local function autobrainrot()
        if not tier or tier == "" then return end
        local ab = workspace:FindFirstChild("ActiveBrainrots")
        if not ab then return end
        local folder = ab:FindFirstChild(tier)
        if not folder then return end
        for _, v in pairs(folder:GetChildren()) do
            if v:IsA("Model") and not v:GetAttribute("Fahh") then
                v:SetAttribute("Fahh", "dih")
                pcall(function()
                    lp.Character.HumanoidRootPart.CFrame = v.PrimaryPart.CFrame
                end)
                task.wait(1)
                local handle = v:FindFirstChild("Handle")
                if handle then
                    local prompt = handle:FindFirstChild("TakePrompt")
                    if prompt then
                        pcall(function()
                            task.wait(1)
                            fireproximityprompt(prompt)
                        end)
                    end
                end
            end
        end
    end

    local function gettiers()
        local tiers = {}
        local ab = workspace:FindFirstChild("ActiveBrainrots")
        if not ab then return tiers end
        for _, v in pairs(ab:GetChildren()) do
            if v:IsA("Folder") then
                table.insert(tiers, v.Name)
            end
        end
        return tiers
    end

    -- =========================
    -- UI (Vonx Hub)
    -- =========================

    local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
    WindUI:SetNotificationLower(true)

    local Window = WindUI:CreateWindow({
        Title = "VonX HUB",
        Icon = "sparkles",
        Author = "Escape Tsunami for Brainrots",
    })

    Window:SetToggleKey(Enum.KeyCode.RightControl)

    local Main = Window:Tab({
        Title = "Main",
        Icon = "sparkles",
        Locked = false,
    })

    local AutoB = Window:Tab({
        Title = "Auto Brainrots",
        Icon = "sparkles",
        Locked = false,
    })

    local AdminTab
    if IS_ADMIN then
        AdminTab = Window:Tab({
            Title = "Admin Panel",
            Icon = "shield",
            Locked = false,
        })
    end

    Main:Select()

    Main:Button({
        Title = "Teleport to Home",
        Locked = false,
        Callback = function()
            pcall(home)
        end
    })

    Main:Toggle({
        Title = "Godmode",
        Icon = "sparkles",
        Type = "Toggle",
        Value = false,
        Callback = function(state) getgenv().Gm = state end
    })

    Main:Toggle({
        Title = "No Tsunami (still can die)",
        Icon = "sparkles",
        Type = "Toggle",
        Value = false,
        Callback = function(state) getgenv().Nt = state end
    })

    Main:Toggle({
        Title = "Auto Upgrade Speed",
        Icon = "sparkles",
        Type = "Toggle",
        Value = false,
        Callback = function(state) getgenv().Aus = state end
    })

    Main:Toggle({
        Title = "Auto Upgrade Carry",
        Icon = "sparkles",
        Type = "Toggle",
        Value = false,
        Callback = function(state) getgenv().Auc = state end
    })

    Main:Toggle({
        Title = "Auto Sell All",
        Icon = "sparkles",
        Type = "Toggle",
        Value = false,
        Callback = function(state) getgenv().Asa = state end
    })

    Main:Toggle({
        Title = "Auto Rebirth",
        Icon = "sparkles",
        Type = "Toggle",
        Value = false,
        Callback = function(state) getgenv().Ar = state end
    })

    Main:Toggle({
        Title = "Auto Upgrade Base",
        Icon = "sparkles",
        Type = "Toggle",
        Value = false,
        Callback = function(state) getgenv().Aub = state end
    })

    Main:Toggle({
        Title = "Auto Upgrade Brainrots",
        Icon = "sparkles",
        Type = "Toggle",
        Value = false,
        Callback = function(state) getgenv().Aub2 = state end
    })

    Main:Toggle({
        Title = "Speed Changer",
        Icon = "sparkles",
        Type = "Toggle",
        Value = false,
        Callback = function(state) getgenv().Sc = state end
    })

    Main:Slider({
        Title = "Speed",
        Step = 1,
        Value = {
            Min = 16,
            Max = 150000,
            Default = 16,
        },
        Callback = function(value)
            getgenv().Scv = tonumber(value) or 16
        end
    })

    AutoB:Toggle({
        Title = "Auto Brainrots",
        Icon = "sparkles",
        Type = "Toggle",
        Value = false,
        Callback = function(state) getgenv().AutoBrainrots = state end
    })

    AutoB:Dropdown({
        Title = "Tier",
        Values = gettiers(),
        Value = "Secret",
        Callback = function(option)
            tier = tostring(option)
        end
    })

    -- =========================
    -- 🛡️ ADMIN PANEL (ONLY OWNER)
    -- =========================

    if IS_ADMIN and AdminTab then

        AdminTab:Button({
            Title = "View Active Users",
            Locked = false,
            Callback = function()
                local count = #Players:GetPlayers()
                WindUI:Notify("Users", "Active users in server: "..count, 5)
                sendLog("👑 Admin Action", lp.Name.." checked active users: "..count)
            end
        })

        AdminTab:Button({
            Title = "Disable Script For All (Client)",
            Locked = false,
            Callback = function()
                getgenv().Gm = false
                getgenv().Nt = false
                getgenv().Aus = false
                getgenv().Auc = false
                getgenv().Asa = false
                getgenv().Ar = false
                getgenv().Aub = false
                getgenv().Aub2 = false
                getgenv().Sc = false
                getgenv().AutoBrainrots = false
                WindUI:Notify("Admin", "All features disabled for your client.", 5)
                sendLog("👑 Admin Action", lp.Name.." disabled all features on client.")
            end
        })

        AdminTab:Button({
            Title = "Log Server Info",
            Locked = false,
            Callback = function()
                local players = Players:GetPlayers()
                local names = {}
                for _, plr in pairs(players) do
                    table.insert(names, plr.Name)
                end
                sendLog("📊 Server Info", "Players ("..#players.."):\n"..table.concat(names, ", "))
                WindUI:Notify("Admin", "Server info sent to webhook.", 5)
            end
        })

    end

    -- =========================
    -- Main Loop
    -- =========================

    task.spawn(function()
        while true do
            task.wait()
            if getgenv().Gm then pcall(godmode) end
            if getgenv().Nt then pcall(notsu) end
            if getgenv().Aus then pcall(upgradespeed) end
            if getgenv().Auc then pcall(upgradec) end
            if getgenv().Asa then pcall(sellall) end
            if getgenv().Ar then pcall(rebirth) end
            if getgenv().Aub then pcall(upgrade) end
            if getgenv().Aub2 then pcall(upgradeallb) end
            if getgenv().Sc then pcall(speedchanger) end
            if getgenv().AutoBrainrots then
                pcall(function()
                    godmode()
                    notsu()
                    gayfunc()
                    autobrainrot()
                end)
            end
        end
    end)
end

-- =========================
-- KEY CHECK LOGIC
-- =========================

Submit.MouseButton1Click:Connect(function()
    local enteredKey = TextBox.Text
    if _ck(enteredKey) then
        Submit.Text = "✅ Key Correct!"
        task.wait(0.5)
        ScreenGui:Destroy()
        loadVonxHub()
    else
        Submit.Text = "❌ Wrong Key!"
        sendLog("❌ Wrong Key Attempt", "Player: "..lp.Name.." entered: "..enteredKey)
        task.wait(1)
        Submit.Text = "Submit Key"
    end
end)
