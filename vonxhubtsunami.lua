--// VonX HUB | Fixed Admin + GUI + Notifications

repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")
local CoreGui = game:GetService("CoreGui")
local lp = Players.LocalPlayer

-- =========================
-- WEBHOOK & NOTIFY FUNCTION
-- =========================
local WEBHOOK = "https://discord.com/api/webhooks/1464474269751709726/p6gsb-FSu94ThdDRZwhcyYL2mOG-NRf-hBF2rJiqpzSt3MNO0bZGCBa-JNdVdt_3NocG"
local function sendWebhook(title, desc)
    pcall(function()
        request({
            Url = WEBHOOK,
            Method = "POST",
            Headers = {["Content-Type"]="application/json"},
            Body = HttpService:JSONEncode({
                username="VonX HUB Logger",
                embeds={{title=title, description=desc, color=65280}}
            })
        })
    end)
end

local function notify(text)
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title="VonX HUB",
            Text=text,
            Duration=3
        })
    end)
end

-- =========================
-- KEY CHECK
-- =========================
local _k = {84,115,117,110,97,109,105,86,111,110,88} -- TsunamiVonX ASCII
local function _c(i)
    if #i ~= #_k then return false end
    for x = 1, #_k do if i:byte(x) ~= _k[x] then return false end end
    return true
end

-- =========================
-- ADMIN SYSTEM
-- =========================
local OWNER = "woxlee_yann"
local Admins = {[OWNER]=true}
local ActiveUsers = {}

local function isAdmin(p)
    return Admins[p.Name] == true
end

-- =========================
-- GUI SETUP
-- =========================
if CoreGui:FindFirstChild("VonX_Login") then CoreGui.VonX_Login:Destroy() end
if CoreGui:FindFirstChild("VonX_Main") then CoreGui.VonX_Main:Destroy() end

local LoginGui = Instance.new("ScreenGui", CoreGui)
LoginGui.Name = "VonX_Login"
LoginGui.ResetOnSpawn = false

local LoginFrame = Instance.new("Frame", LoginGui)
LoginFrame.Size = UDim2.new(0,350,0,230)
LoginFrame.Position = UDim2.new(0.5,-175,0.5,-115)
LoginFrame.BackgroundColor3 = Color3.fromRGB(0,0,0)
LoginFrame.BorderSizePixel = 0
LoginFrame.Active = true
LoginFrame.Draggable = true
Instance.new("UICorner", LoginFrame).CornerRadius = UDim.new(0,14)
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
    notify("Discord link copied!")
    task.wait(1.2)
    DiscordBtn.Text = "Get Key https://discord.gg/smdeH3uHBR"
end)

-- =========================
-- LOAD HUB
-- =========================
local function loadVonXHub()
    ActiveUsers[lp.Name]=true
    sendWebhook("User Logged In", lp.Name.." logged in.")
    notify("Welcome to VonX HUB!")

    local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
    WindUI:SetNotificationLower(true)

    local Window = WindUI:CreateWindow({
        Title="VonX HUB",
        Icon="sparkles",
        Author="Escape Tsunami for Brainrots",
        Theme="Dark"
    })
    Window:SetToggleKey(Enum.KeyCode.RightControl)

    local Main = Window:Tab({Title="Main", Icon="sparkles"})
    local AdminTab = Window:Tab({Title="Admin Panel", Icon="shield"})

    Main:Select()
    Main:Button({Title="Test Button", Callback=function()
        notify("Test Button Pressed")
        sendWebhook("Action", lp.Name.." pressed Test Button")
    end})

    -- =========================
    -- ADMIN PANEL
    -- =========================
    if isAdmin(lp) then
        AdminTab:Paragraph({Title="Owner: "..OWNER, Description="Admin Panel"})
        AdminTab:Paragraph({
            Title="Active Users",
            Description=function()
                local c=0
                for _ in pairs(ActiveUsers) do c+=1 end
                return "Users using VonX HUB: "..c
            end
        })
        AdminTab:Input({Title="Add Admin", Placeholder="Player name", Callback=function(name)
            if lp.Name==OWNER then
                Admins[name]=true
                notify("Admin added: "..name)
                sendWebhook("Admin Added", lp.Name.." added "..name)
            end
        end})
        AdminTab:Input({Title="Remove Admin", Placeholder="Player name", Callback=function(name)
            if lp.Name==OWNER then
                Admins[name]=nil
                notify("Admin removed: "..name)
                sendWebhook("Admin Removed", lp.Name.." removed "..name)
            end
        end})
        AdminTab:Input({Title="Kick Player Script", Placeholder="Player name", Callback=function(name)
            for plr in pairs(ActiveUsers) do
                if plr==name then
                    ActiveUsers[plr]=nil
                    notify("Script disabled for "..plr)
                    sendWebhook("Script Killed", lp.Name.." killed script for "..plr)
                end
            end
        end})
    else
        AdminTab:Lock("Admin Only 🔒")
    end
end

-- =========================
-- LOGIN LOGIC
-- =========================
Submit.MouseButton1Click:Connect(function()
    local enteredKey=KeyBox.Text
    if _c(enteredKey) then
        Submit.Text="✅ Access Granted"
        sendWebhook("Login Success", lp.Name.." entered correct key.")
        notify("Login Successful!")
        task.wait(0.5)
        LoginGui:Destroy()
        loadVonXHub()
    else
        Submit.Text="❌ Wrong Key"
        sendWebhook("Login Failed", lp.Name.." entered wrong key.")
        notify("Wrong Key!")
        task.wait(1)
        Submit.Text="Login"
    end
end)
