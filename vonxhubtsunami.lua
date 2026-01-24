repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local lp = Players.LocalPlayer

-- =========================
-- KEY SYSTEM
-- =========================

if CoreGui:FindFirstChild("VonxKeyUI") then
    CoreGui:FindFirstChild("VonxKeyUI"):Destroy()
end

-- Şifreli key (Base64 ile saklıyoruz)
local encodedKey = "VHN1bmFtaVZvblg=" -- Bu "TsunamiVonX" base64 hali

local function decodeKey(str)
    local b='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
    str = string.gsub(str,'[^'..b..'=]','')
    return (str:gsub('.', function(x)
        if x == '=' then return '' end
        local r,f='',(b:find(x)-1)
        for i=6,1,-1 do r=r..(f%2^i - f%2^(i-1) > 0 and '1' or '0') end
        return r
    end):gsub('%d%d%d%d%d%d%d%d', function(x)
        local c=0
        for i=1,8 do c=c + (x:sub(i,i)=='1' and 2^(8-i) or 0) end
        return string.char(c)
    end))
end

local CORRECT_KEY = decodeKey(encodedKey)

-- GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "VonxKeyUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CoreGui

local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 320, 0, 220)
Frame.Position = UDim2.new(0.5, -160, 0.5, -110)
Frame.BackgroundColor3 = Color3.fromRGB(10,10,10)
Frame.BorderSizePixel = 0
Frame.Active = true
Frame.Draggable = true
Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 12)

-- Başlık
local Title = Instance.new("TextLabel", Frame)
Title.Size = UDim2.new(1,0,0,50)
Title.Position = UDim2.new(0,0,0,0)
Title.BackgroundTransparency = 1
Title.Text = "🔐 VonX HUB Key System"
Title.TextColor3 = Color3.fromRGB(0,255,0)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18

-- TextBox
local TextBox = Instance.new("TextBox", Frame)
TextBox.Size = UDim2.new(1,-40,0,40)
TextBox.Position = UDim2.new(0,20,0,70)
TextBox.PlaceholderText = "Enter key here..."
TextBox.Text = ""
TextBox.ClearTextOnFocus = false
TextBox.BackgroundColor3 = Color3.fromRGB(20,20,20)
TextBox.TextColor3 = Color3.fromRGB(0,255,0)
TextBox.Font = Enum.Font.Gotham
TextBox.TextSize = 14
Instance.new("UICorner", TextBox).CornerRadius = UDim.new(0,6)

-- Submit Button
local Submit = Instance.new("TextButton", Frame)
Submit.Size = UDim2.new(1,-40,0,40)
Submit.Position = UDim2.new(0,20,0,120)
Submit.Text = "Submit Key"
Submit.BackgroundColor3 = Color3.fromRGB(0,255,0)
Submit.TextColor3 = Color3.fromRGB(0,0,0)
Submit.Font = Enum.Font.GothamBold
Submit.TextSize = 14
Instance.new("UICorner", Submit).CornerRadius = UDim.new(0,6)

-- Discord Button
local DiscordBtn = Instance.new("TextButton", Frame)
DiscordBtn.Size = UDim2.new(1,-40,0,30)
DiscordBtn.Position = UDim2.new(0,20,0,170)
DiscordBtn.BackgroundColor3 = Color3.fromRGB(0,255,0)
DiscordBtn.TextColor3 = Color3.fromRGB(0,0,0)
DiscordBtn.Text = "Get Key - Discord"
DiscordBtn.Font = Enum.Font.GothamBold
DiscordBtn.TextSize = 14
Instance.new("UICorner", DiscordBtn).CornerRadius = UDim.new(0,6)

DiscordBtn.MouseButton1Click:Connect(function()
    setclipboard("https://discord.gg/smdeH3uHBR")
    DiscordBtn.Text = "Copied! ✅"
    task.wait(1)
    DiscordBtn.Text = "Get Key - Discord"
end)

-- =========================
-- KEY LOGIC
-- =========================

local function loadVonxHub()
    -- Buraya VonX HUB scriptini çağıracaksın
    print("VonX HUB loaded!") -- Test
end

Submit.MouseButton1Click:Connect(function()
    if TextBox.Text == CORRECT_KEY then
        Submit.Text = "✅ Key Correct!"
        task.wait(0.5)
        ScreenGui:Destroy()
        loadVonxHub()
    else
        Submit.Text = "❌ Wrong Key!"
        task.wait(1)
        Submit.Text = "Submit Key"
    end
end)
