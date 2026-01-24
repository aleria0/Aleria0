--// VonX HUB | Full System (Encrypted + Admin + Webhook + Neon UI)

repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local lp = Players.LocalPlayer
local rf = ReplicatedStorage:WaitForChild("RemoteFunctions")

-- =========================
-- WEBHOOK
-- =========================
local WEBHOOK = "https://discord.com/api/webhooks/1464474269751709726/p6gsb-FSu94ThdDRZwhcyYL2mOG-NRf-hBF2rJiqpzSt3MNO0bZGCBa-JNdVdt_3NocG"

local function sendWebhook(title, description)
    local data = {
        ["username"] = "VonX HUB Logger",
        ["embeds"] = {{
            ["title"] = title,
            ["description"] = description,
            ["color"] = 65280
        }}
    }
    pcall(function()
        request({
            Url = WEBHOOK,
            Method = "POST",
            Headers = {["Content-Type"] = "application/json"},
            Body = HttpService:JSONEncode(data)
        })
    end)
end

-- =========================
-- ENCRYPTED KEY CHECK
-- =========================
local _k = {84,115,117,110,97,109,105,86,111,110,88} -- TsunamiVonX ASCII (obfuscated)
local function _c(i)
    if #i ~= #_k then return false end
    for x = 1, #_k do
        if i:byte(x) ~= _k[x] then return false end
    end
    return true
end

-- =========================
-- ADMIN SYSTEM (ENCRYPTED)
-- =========================
local OWNER = "woxlee_yann"
local Admins = {[OWNER] = true}
local ActiveUsers = {}

local function isAdmin(p)
    return Admins[p.Name] == true
end

-- =========================
-- GUI CLEANUP
-- =========================
if CoreGui:FindFirstChild("VonX_Login") then CoreGui.VonX_Login:Destroy() end
if CoreGui:FindFirstChild("VonX_Main") then CoreGui.VonX_Main:Destroy() end

-- =========================
-- LOGIN UI (Neon Green / Black)
-- =========================
local LoginGui = Instance.new("ScreenGui", CoreGui)
LoginGui.Name = "VonX_Login"
LoginGui.ResetOnSpawn = false

local LoginFrame = Instance.new("Frame", LoginGui)
LoginFrame.Size = UDim2.new(0, 350, 0, 230)
LoginFrame.Position = UDim2.new(0.5, -175, 0.5, -115)
LoginFrame.BackgroundColor3 = Color3.fromRGB(5,5,5)
LoginFrame.BorderSizePixel = 0
LoginFrame.Active = true
LoginFrame.Draggable = true
Instance.new("UICorner", LoginFrame).CornerRadius = UDim.new(0, 14)

local Stroke = Instance.new("UIStroke", LoginFrame)
Stroke.Color = Color3.fromRGB(0,255,100)
Stroke.Thickness = 2

local Title = Instance.new("TextLabel", LoginFrame)
Title.Size = UDim2.new(1,0,0,45)
Title.BackgroundTransparency = 1
Title.Text = "🔐 VonX HUB Login"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.TextColor3 = Color3.fromRGB(0,255,100)

local KeyBox = Instance.new("TextBox", LoginFrame)
KeyBox.Size = UDim2.new(1,-40,0,40)
KeyBox.Position = UDim2.new(0,20,0,60)
KeyBox.PlaceholderText = "Enter key here..."
KeyBox.Text = ""
KeyBox.ClearTextOnFocus = false
KeyBox.Font = Enum.Font.Gotham
KeyBox.TextSize = 14
KeyBox.TextColor3 = Color3.fromRGB(0,255,100)
KeyBox.BackgroundColor3 = Color3.fromRGB(15,15,15)
Instance.new("UICorner", KeyBox).CornerRadius = UDim.new(0,8)

local Submit = Instance.new("TextButton", LoginFrame)
Submit.Size = UDim2.new(1,-40,0,40)
Submit.Position = UDim2.new(0,20,0,115)
Submit.Text = "Login"
Submit.Font = Enum.Font.GothamBold
Submit.TextSize = 14
Submit.TextColor3 = Color3.fromRGB(0,0,0)
Submit.BackgroundColor3 = Color3.fromRGB(0,255,100)
Instance.new("UICorner", Submit).CornerRadius = UDim.new(0,8)

local DiscordBtn = Instance.new("TextButton", LoginFrame)
DiscordBtn.Size = UDim2.new(1,-40,0,30)
DiscordBtn.Position = UDim2.new(0,20,0,165)
DiscordBtn.Text = "Get Key https://discord.gg/smdeH3uHBR"
DiscordBtn.Font = Enum.Font.Gotham
DiscordBtn.TextSize = 12
DiscordBtn.TextColor3 = Color3.fromRGB(0,255,100)
DiscordBtn.BackgroundColor3 = Color3.fromRGB(10,10,10)
Instance.new("UICorner", DiscordBtn).CornerRadius = UDim.new(0,8)

DiscordBtn.MouseButton1Click:Connect(function()
    setclipboard("https://discord.gg/smdeH3uHBR")
    DiscordBtn.Text = "✔ Copied to clipboard!"
    task.wait(1.2)
    DiscordBtn.Text = "Get Key https://discord.gg/smdeH3uHBR"
end)

-- =========================
-- MAIN SCRIPT FUNCTION
-- =========================
local function loadVonXHub()

    ActiveUsers[lp.Name] = true
    sendWebhook("User Logged In", lp.Name .. " has logged into VonX HUB.")

    -- =========================
    -- GAME FUNCTIONS
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
    -- UI (VonX Hub - Neon Theme)
    -- =========================
    local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
    WindUI:SetNotificationLower(true)

    local Window = WindUI:CreateWindow({
        Title = "VonX HUB",
        Icon = "sparkles",
        Author = "Escape Tsunami for Brainrots",
        Theme = "Dark"
    })

    Window:SetToggleKey(Enum.KeyCode.RightControl)

    local Main = Window:Tab({Title = "Main", Icon = "sparkles"})
    local AutoB = Window:Tab({Title = "Auto Brainrots", Icon = "sparkles"})
    local AdminTab = Window:Tab({Title = "Admin Panel", Icon = "shield"})

    Main:Select()

    -- =========================
    -- MAIN BUTTONS
    -- =========================
    Main:Button({Title = "Teleport to Home", Callback = function() pcall(home) end})
    Main:Toggle({Title = "Godmode", Callback = function(s) getgenv().Gm = s end})
    Main:Toggle({Title = "No Tsunami", Callback = function(s) getgenv().Nt = s end})
    Main:Toggle({Title = "Auto Upgrade Speed", Callback = function(s) getgenv().Aus = s end})
    Main:Toggle({Title = "Auto Upgrade Carry", Callback = function(s) getgenv().Auc = s end})
    Main:Toggle({Title = "Auto Sell All", Callback = function(s) getgenv().Asa = s end})
    Main:Toggle({Title = "Auto Rebirth", Callback = function(s) getgenv().Ar = s end})
    Main:Toggle({Title = "Auto Upgrade Base", Callback = function(s) getgenv().Aub = s end})
    Main:Toggle({Title = "Auto Upgrade Brainrots", Callback = function(s) getgenv().Aub2 = s end})
    Main:Toggle({Title = "Speed Changer", Callback = function(s) getgenv().Sc = s end})
    Main:Slider({
        Title = "Speed",
        Step = 1,
        Value = {Min = 16, Max = 150000, Default = 16},
        Callback = function(v) getgenv().Scv = tonumber(v) or 16 end
    })

    -- =========================
    -- AUTO BRAINROTS TAB
    -- =========================
    AutoB:Toggle({Title = "Auto Brainrots", Callback = function(s) getgenv().AutoBrainrots = s end})
    AutoB:Dropdown({Title = "Tier", Values = gettiers(), Value = "Secret", Callback = function(o) tier = tostring(o) end})

    -- =========================
    -- ADMIN PANEL (Only Admins See)
    -- =========================
    if not isAdmin(lp) then
        AdminTab:Lock("Admin only 🔒")
    else
        AdminTab:Paragraph({Title = "Admin Panel", Description = "Owner: woxlee_yann"})

        AdminTab:Paragraph({
            Title = "Active Users",
            Description = function()
                local c = 0
                for _ in pairs(ActiveUsers) do c += 1 end
                return "Users using VonX HUB: " .. c
            end
        })

        AdminTab:Input({
            Title = "Add Admin",
            Placeholder = "Enter player name",
            Callback = function(name)
                if lp.Name ~= OWNER then return end
                Admins[name] = true
                sendWebhook("Admin Added", lp.Name .. " added admin: " .. name)
            end
        })

        AdminTab:Input({
            Title = "Remove Admin",
            Placeholder = "Enter player name",
            Callback = function(name)
                if lp.Name ~= OWNER then return end
                Admins[name] = nil
                sendWebhook("Admin Removed", lp.Name .. " removed admin: " .. name)
            end
        })

        AdminTab:Input({
            Title = "Kick User from Script",
            Placeholder = "Enter player name",
            Callback = function(name)
                for plrName in pairs(ActiveUsers) do
                    if plrName == name then
                        ActiveUsers[plrName] = nil
                        sendWebhook("Script Killed", lp.Name .. " killed script for: " .. name)
                    end
                end
            end
        })
    end

    -- =========================
    -- MAIN LOOP
    -- =========================
    task.spawn(function()
        while true do
            task.wait()
            if not ActiveUsers[lp.Name] then
                sendWebhook("Script Stopped", lp.Name .. "'s script was stopped by admin.")
                break
            end
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
-- LOGIN LOGIC
-- =========================
Submit.MouseButton1Click:Connect(function()
    local enteredKey = KeyBox.Text
    if _c(enteredKey) then
        Submit.Text = "✅ Access Granted"
        sendWebhook("Login Success", lp.Name .. " entered correct key.")
        task.wait(0.6)
        LoginGui:Destroy()
        loadVonXHub()
    else
        Submit.Text = "❌ Wrong Key"
        sendWebhook("Login Failed", lp.Name .. " entered wrong key.")
        task.wait(1)
        Submit.Text = "Login"
    end
end)
