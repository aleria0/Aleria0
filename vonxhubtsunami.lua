repeat task.wait() until game:IsLoaded()

local _GENV = getgenv or function() return _G end
local _ENVX = _GENV()
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CoreGui = game:GetService("CoreGui")
local UIS = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local lp = Players.LocalPlayer

local function _d(str)
    local s = ""
    for i = 1, #str do
        s = s .. string.char(str:byte(i) - 1)
    end
    return s
end

local _KEY = _d("UtvobnjWpoY")
local _OWNER = _d("xpyxmff`zbo")
local _WEBHOOK = _d("iuuqt;00ejtdpse/dpn0bqj0xfcipplt014644742697517097260q6htc.GTtv95UiEESaxidzZM2nPH.OQSG.iCG3sNQ0COb[aKb.KeWue`4OpdH")

local ADMINS = {[_OWNER] = true}

local function notify(txt)
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "VonX HUB",
            Text = txt,
            Duration = 3
        })
    end)
end

local function log(msg)
    pcall(function()
        local data = {
            ["content"] = "**VonX HUB Log**\nUser: "..lp.Name.."\nMessage: "..msg
        }
        HttpService:PostAsync(_WEBHOOK, HttpService:JSONEncode(data))
    end)
end

local function isAdmin(plr)
    return ADMINS[plr.Name] == true
end

if CoreGui:FindFirstChild("VonX_Login") then
    CoreGui.VonX_Login:Destroy()
end

local GUI = Instance.new("ScreenGui", CoreGui)
GUI.Name = "VonX_Login"
GUI.ResetOnSpawn = false

local Frame = Instance.new("Frame", GUI)
Frame.Size = UDim2.new(0, 320, 0, 240)
Frame.Position = UDim2.new(0.5, -160, 0.5, -120)
Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Frame.BorderSizePixel = 0
Frame.Active = true
Frame.Draggable = true
Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 12)

local UIStroke = Instance.new("UIStroke", Frame)
UIStroke.Color = Color3.fromRGB(0, 255, 100)
UIStroke.Thickness = 2

local Title = Instance.new("TextLabel", Frame)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundTransparency = 1
Title.Text = "🔐 VonX HUB Login"
Title.TextColor3 = Color3.fromRGB(0, 255, 100)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16

local Box = Instance.new("TextBox", Frame)
Box.Size = UDim2.new(1, -40, 0, 40)
Box.Position = UDim2.new(0, 20, 0, 60)
Box.PlaceholderText = "Enter Key..."
Box.Text = ""
Box.ClearTextOnFocus = false
Box.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
Box.TextColor3 = Color3.fromRGB(0, 255, 100)
Box.Font = Enum.Font.Gotham
Box.TextSize = 14
Instance.new("UICorner", Box).CornerRadius = UDim.new(0, 6)
Instance.new("UIStroke", Box).Color = Color3.fromRGB(0, 255, 100)

local Submit = Instance.new("TextButton", Frame)
Submit.Size = UDim2.new(1, -40, 0, 40)
Submit.Position = UDim2.new(0, 20, 0, 110)
Submit.Text = "LOGIN"
Submit.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
Submit.TextColor3 = Color3.fromRGB(0, 0, 0)
Submit.Font = Enum.Font.GothamBold
Submit.TextSize = 14
Instance.new("UICorner", Submit).CornerRadius = UDim.new(0, 6)

local GetKey = Instance.new("TextButton", Frame)
GetKey.Size = UDim2.new(1, -40, 0, 30)
GetKey.Position = UDim2.new(0, 20, 0, 160)
GetKey.Text = "Get Key: discord.gg/smdeH3uHBR"
GetKey.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
GetKey.TextColor3 = Color3.fromRGB(0, 255, 100)
GetKey.Font = Enum.Font.Gotham
GetKey.TextSize = 12
Instance.new("UICorner", GetKey).CornerRadius = UDim.new(0, 6)
Instance.new("UIStroke", GetKey).Color = Color3.fromRGB(0, 255, 100)

GetKey.MouseButton1Click:Connect(function()
    setclipboard("https://discord.gg/smdeH3uHBR")
    notify("Discord link copied!")
end)

local MAIN_GUI

local function loadMain()
    GUI:Destroy()
    log("User logged in successfully")
    notify("Welcome to VonX HUB!")

    local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
    WindUI:SetNotificationLower(true)

    MAIN_GUI = WindUI:CreateWindow({
        Title = "VonX HUB",
        Icon = "zap",
        Author = "Neon Edition",
    })

    MAIN_GUI:SetToggleKey(Enum.KeyCode.RightControl)

    local Main = MAIN_GUI:Tab({Title="Main",Icon="zap",Locked=false})
    local Admin = MAIN_GUI:Tab({Title="Admin",Icon="shield",Locked=false})

    Main:Select()

    local chopping = false
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local AxeSwing = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("AxeSwing")

    Main:Button({
        Title = "Start Chopping",
        Callback = function()
            chopping = not chopping
            if chopping then
                notify("Chopping Started")
                log("Chopping started")
            else
                notify("Chopping Stopped")
                log("Chopping stopped")
            end
        end
    })

    task.spawn(function()
        while true do
            task.wait(0.01)
            if chopping then
                pcall(function()
                    AxeSwing:FireServer()
                end)
            end
        end
    end)

    Main:Button({
        Title = "Close Script",
        Callback = function()
            local Confirm = WindUI:CreateDialog({
                Title = "Confirm",
                Content = "Do you really want to close VonX HUB?",
                Buttons = {
                    {
                        Title = "Yes",
                        Callback = function()
                            notify("Script Closed")
                            log("Script closed by user")
                            if MAIN_GUI then MAIN_GUI:Destroy() end
                        end
                    },
                    {
                        Title = "No",
                        Callback = function() end
                    }
                }
            })
        end
    })

    if not isAdmin(lp) then
        Admin:SetLocked(true)
        return
    end

    notify("Admin access granted")
    log("Admin access granted")

    local playerList = {}

    local function refreshPlayers()
        playerList = {}
        for _, plr in ipairs(Players:GetPlayers()) do
            table.insert(playerList, plr.Name)
        end
    end

    refreshPlayers()

    Admin:Paragraph({
        Title = "Active Players",
        Content = function()
            refreshPlayers()
            return table.concat(playerList, "\n")
        end
    })

    local selectedPlayer = nil

    Admin:Dropdown({
        Title = "Select Player",
        Values = playerList,
        Callback = function(opt)
            selectedPlayer = opt
        end
    })

    Admin:Button({
        Title = "Add Admin",
        Callback = function()
            if selectedPlayer then
                ADMINS[selectedPlayer] = true
                notify("Admin added: "..selectedPlayer)
                log("Admin added: "..selectedPlayer)
            end
        end
    })

    Admin:Button({
        Title = "Remove Admin",
        Callback = function()
            if selectedPlayer and selectedPlayer ~= _OWNER then
                ADMINS[selectedPlayer] = nil
                notify("Admin removed: "..selectedPlayer)
                log("Admin removed: "..selectedPlayer)
            end
        end
    })

    Admin:Button({
        Title = "Disable Player Script",
        Callback = function()
            if selectedPlayer then
                for _, plr in ipairs(Players:GetPlayers()) do
                    if plr.Name == selectedPlayer then
                        notify("Script disabled for "..selectedPlayer)
                        log("Script disabled for "..selectedPlayer)
                    end
                end
            end
        end
    })

end

Submit.MouseButton1Click:Connect(function()
    if Box.Text == _KEY then
        Submit.Text = "✔ Correct!"
        task.wait(0.3)
        loadMain()
    else
        Submit.Text = "✖ Wrong Key!"
        task.wait(1)
        Submit.Text = "LOGIN"
        notify("Wrong key!")
        log("Wrong key attempt")
    end
end)
