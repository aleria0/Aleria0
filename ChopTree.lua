loadstring([[
local _0xA1B2C3=function(s)local t=""for i=1,#s do t=t..string.char(string.byte(s,i)-1)end return t end
local _0xD4E5F6=function(s)local t=""for i=1,#s do t=t..string.char(string.byte(s,i)+1)end return t end
local _0xKEY="ChopYourVonX"
local _0xOWNER="woxlee_yann"
local _0xWEBHOOK="https://discord.com/api/webhooks/1464474269751709726/p6gsb-FSu94ThdDRZwhcyYL2mOG-NRf-hBF2rJiqpzSt3MNO0bZGCBa-JNdVdt_3NocG"

repeat task.wait() until game:IsLoaded()
local Players=game:GetService("Players")
local ReplicatedStorage=game:GetService("ReplicatedStorage")
local CoreGui=game:GetService("CoreGui")
local HttpService=game:GetService("HttpService")
local UIS=game:GetService("UserInputService")
local lp=Players.LocalPlayer

local AxeSwing=ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("AxeSwing")

local function sendLog(msg)
    pcall(function()
        local data={
            content="",
            embeds={{
                title="VonX HUB Log",
                description=msg,
                color=65280,
                footer={text=os.date("%Y-%m-%d %H:%M:%S")}
            }}
        }
        local req=(syn and syn.request) or (http and http.request) or request
        if req then
            req({
                Url=_0xWEBHOOK,
                Method="POST",
                Headers={["Content-Type"]="application/json"},
                Body=HttpService:JSONEncode(data)
            })
        end
    end)
end

-- HWID (device id benzeri)
local HWID = game:GetService("RbxAnalyticsService"):GetClientId()

-- Admin sistemi
local Admins = {}
Admins[_0xOWNER]=true

-- Script aktif oyuncular
local ActiveUsers = {}

-- GUI yoksa oluştur
if CoreGui:FindFirstChild("VonXHubUI") then
    CoreGui.VonXHubUI:Destroy()
end

-- =========================
-- KEY UI
-- =========================

local ScreenGui=Instance.new("ScreenGui",CoreGui)
ScreenGui.Name="VonXHubUI"
ScreenGui.ResetOnSpawn=false

local Frame=Instance.new("Frame",ScreenGui)
Frame.Size=UDim2.new(0,320,0,200)
Frame.Position=UDim2.new(0.5,-160,0.5,-100)
Frame.BackgroundColor3=Color3.fromRGB(0,0,0)
Frame.BorderSizePixel=0
Frame.Active=true
Frame.Draggable=true
Instance.new("UICorner",Frame).CornerRadius=UDim.new(0,12)

local Title=Instance.new("TextLabel",Frame)
Title.Size=UDim2.new(1,0,0,40)
Title.BackgroundTransparency=1
Title.Text="🟢 VonX HUB Key System"
Title.TextColor3=Color3.fromRGB(0,255,0)
Title.Font=Enum.Font.GothamBold
Title.TextSize=16

local TextBox=Instance.new("TextBox",Frame)
TextBox.Size=UDim2.new(1,-40,0,40)
TextBox.Position=UDim2.new(0,20,0,60)
TextBox.PlaceholderText="Enter Key..."
TextBox.Text=""
TextBox.ClearTextOnFocus=false
TextBox.BackgroundColor3=Color3.fromRGB(10,10,10)
TextBox.TextColor3=Color3.fromRGB(0,255,0)
TextBox.Font=Enum.Font.Gotham
TextBox.TextSize=14
Instance.new("UICorner",TextBox).CornerRadius=UDim.new(0,8)

local Submit=Instance.new("TextButton",Frame)
Submit.Size=UDim2.new(1,-40,0,40)
Submit.Position=UDim2.new(0,20,0,120)
Submit.Text="Unlock"
Submit.BackgroundColor3=Color3.fromRGB(0,255,0)
Submit.TextColor3=Color3.fromRGB(0,0,0)
Submit.Font=Enum.Font.GothamBold
Submit.TextSize=14
Instance.new("UICorner",Submit).CornerRadius=UDim.new(0,8)

-- =========================
-- MAIN HUB
-- =========================

local function loadVonXHub()

    sendLog("User **"..lp.Name.."** logged in.\nHWID: "..HWID)

    ActiveUsers[lp.Name]=true

    -- Ana GUI
    if ScreenGui then ScreenGui:Destroy() end

    local HubGui=Instance.new("ScreenGui",CoreGui)
    HubGui.Name="VonXHubMain"
    HubGui.ResetOnSpawn=false

    local MainFrame=Instance.new("Frame",HubGui)
    MainFrame.Size=UDim2.new(0,450,0,300)
    MainFrame.Position=UDim2.new(0.5,-225,0.5,-150)
    MainFrame.BackgroundColor3=Color3.fromRGB(0,0,0)
    MainFrame.BorderSizePixel=0
    MainFrame.Active=true
    MainFrame.Draggable=true
    Instance.new("UICorner",MainFrame).CornerRadius=UDim.new(0,14)

    local Header=Instance.new("TextLabel",MainFrame)
    Header.Size=UDim2.new(1,0,0,40)
    Header.BackgroundTransparency=1
    Header.Text="🟢 VonX HUB | Chop System"
    Header.TextColor3=Color3.fromRGB(0,255,0)
    Header.Font=Enum.Font.GothamBold
    Header.TextSize=16

    -- Start Chopping Button
    local StartBtn=Instance.new("TextButton",MainFrame)
    StartBtn.Size=UDim2.new(0,200,0,45)
    StartBtn.Position=UDim2.new(0,30,0,70)
    StartBtn.Text="🪓 Start Chopping"
    StartBtn.BackgroundColor3=Color3.fromRGB(0,255,0)
    StartBtn.TextColor3=Color3.fromRGB(0,0,0)
    StartBtn.Font=Enum.Font.GothamBold
    StartBtn.TextSize=14
    Instance.new("UICorner",StartBtn).CornerRadius=UDim.new(0,8)

    -- Stop Button
    local StopBtn=Instance.new("TextButton",MainFrame)
    StopBtn.Size=UDim2.new(0,200,0,45)
    StopBtn.Position=UDim2.new(0,30,0,130)
    StopBtn.Text="🛑 Stop Chopping"
    StopBtn.BackgroundColor3=Color3.fromRGB(255,0,0)
    StopBtn.TextColor3=Color3.fromRGB(255,255,255)
    StopBtn.Font=Enum.Font.GothamBold
    StopBtn.TextSize=14
    Instance.new("UICorner",StopBtn).CornerRadius=UDim.new(0,8)

    -- Durum Label
    local Status=Instance.new("TextLabel",MainFrame)
    Status.Size=UDim2.new(0,200,0,30)
    Status.Position=UDim2.new(0,30,0,190)
    Status.BackgroundTransparency=1
    Status.Text="Status: OFF"
    Status.TextColor3=Color3.fromRGB(255,0,0)
    Status.Font=Enum.Font.GothamBold
    Status.TextSize=14

    local chopping=false

    StartBtn.MouseButton1Click:Connect(function()
        chopping=true
        Status.Text="Status: ON"
        Status.TextColor3=Color3.fromRGB(0,255,0)
        sendLog("🪓 **"..lp.Name.."** started chopping.")
    end)

    StopBtn.MouseButton1Click:Connect(function()
        chopping=false
        Status.Text="Status: OFF"
        Status.TextColor3=Color3.fromRGB(255,0,0)
        sendLog("🛑 **"..lp.Name.."** stopped chopping.")
    end)

    -- Sağ Ctrl ile aç/kapat
    UIS.InputBegan:Connect(function(input,gp)
        if gp then return end
        if input.KeyCode==Enum.KeyCode.RightControl then
            MainFrame.Visible=not MainFrame.Visible
        end
    end)

    -- Chopping loop
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

    -- =========================
    -- ADMIN PANEL
    -- =========================

    if Admins[lp.Name] then

        local AdminFrame=Instance.new("Frame",MainFrame)
        AdminFrame.Size=UDim2.new(0,170,0,200)
        AdminFrame.Position=UDim2.new(1,-190,0,60)
        AdminFrame.BackgroundColor3=Color3.fromRGB(10,10,10)
        AdminFrame.BorderSizePixel=0
        Instance.new("UICorner",AdminFrame).CornerRadius=UDim.new(0,10)

        local AdminTitle=Instance.new("TextLabel",AdminFrame)
        AdminTitle.Size=UDim2.new(1,0,0,30)
        AdminTitle.BackgroundTransparency=1
        AdminTitle.Text="👑 Admin Panel"
        AdminTitle.TextColor3=Color3.fromRGB(0,255,0)
        AdminTitle.Font=Enum.Font.GothamBold
        AdminTitle.TextSize=14

        local UserBox=Instance.new("TextBox",AdminFrame)
        UserBox.Size=UDim2.new(1,-20,0,30)
        UserBox.Position=UDim2.new(0,10,0,40)
        UserBox.PlaceholderText="Player Name"
        UserBox.Text=""
        UserBox.BackgroundColor3=Color3.fromRGB(0,0,0)
        UserBox.TextColor3=Color3.fromRGB(0,255,0)
        UserBox.Font=Enum.Font.Gotham
        UserBox.TextSize=12
        Instance.new("UICorner",UserBox).CornerRadius=UDim.new(0,6)

        local AddAdminBtn=Instance.new("TextButton",AdminFrame)
        AddAdminBtn.Size=UDim2.new(1,-20,0,30)
        AddAdminBtn.Position=UDim2.new(0,10,0,80)
        AddAdminBtn.Text="➕ Add Admin"
        AddAdminBtn.BackgroundColor3=Color3.fromRGB(0,255,0)
        AddAdminBtn.TextColor3=Color3.fromRGB(0,0,0)
        AddAdminBtn.Font=Enum.Font.GothamBold
        AddAdminBtn.TextSize=12
        Instance.new("UICorner",AddAdminBtn).CornerRadius=UDim.new(0,6)

        local RemoveAdminBtn=Instance.new("TextButton",AdminFrame)
        RemoveAdminBtn.Size=UDim2.new(1,-20,0,30)
        RemoveAdminBtn.Position=UDim2.new(0,10,0,120)
        RemoveAdminBtn.Text="➖ Remove Admin"
        RemoveAdminBtn.BackgroundColor3=Color3.fromRGB(255,0,0)
        RemoveAdminBtn.TextColor3=Color3.fromRGB(255,255,255)
        RemoveAdminBtn.Font=Enum.Font.GothamBold
        RemoveAdminBtn.TextSize=12
        Instance.new("UICorner",RemoveAdminBtn).CornerRadius=UDim.new(0,6)

        local KillScriptBtn=Instance.new("TextButton",AdminFrame)
        KillScriptBtn.Size=UDim2.new(1,-20,0,30)
        KillScriptBtn.Position=UDim2.new(0,10,0,160)
        KillScriptBtn.Text="❌ Stop User Script"
        KillScriptBtn.BackgroundColor3=Color3.fromRGB(100,0,0)
        KillScriptBtn.TextColor3=Color3.fromRGB(255,255,255)
        KillScriptBtn.Font=Enum.Font.GothamBold
        KillScriptBtn.TextSize=12
        Instance.new("UICorner",KillScriptBtn).CornerRadius=UDim.new(0,6)

        AddAdminBtn.MouseButton1Click:Connect(function()
            local name=UserBox.Text
            if name~="" then
                Admins[name]=true
                sendLog("👑 **"..lp.Name.."** added admin: "..name)
            end
        end)

        RemoveAdminBtn.MouseButton1Click:Connect(function()
            local name=UserBox.Text
            if name~="" and name~=_0xOWNER then
                Admins[name]=nil
                sendLog("❌ **"..lp.Name.."** removed admin: "..name)
            end
        end)

        KillScriptBtn.MouseButton1Click:Connect(function()
            local name=UserBox.Text
            if name~="" then
                ActiveUsers[name]=false
                sendLog("🛑 **"..lp.Name.."** stopped script for: "..name)
            end
        end)

        -- Admin ekstra özellik: kaç kişi scriptte
        local CountLabel=Instance.new("TextLabel",AdminFrame)
        CountLabel.Size=UDim2.new(1,-20,0,25)
        CountLabel.Position=UDim2.new(0,10,0,195)
        CountLabel.BackgroundTransparency=1
        CountLabel.TextColor3=Color3.fromRGB(0,255,0)
        CountLabel.Font=Enum.Font.GothamBold
        CountLabel.TextSize=12

        task.spawn(function()
            while true do
                task.wait(1)
                local count=0
                for _,v in pairs(ActiveUsers) do
                    if v then count+=1 end
                end
                CountLabel.Text="👥 Active Users: "..count
            end
        end)

    end

    -- Kullanıcının scripti admin tarafından kapatıldıysa
    task.spawn(function()
        while true do
            task.wait(1)
            if ActiveUsers[lp.Name]==false then
                chopping=false
                HubGui:Destroy()
                sendLog("⛔ **"..lp.Name.."** script force stopped.")
                break
            end
        end
    end)
end

-- =========================
-- KEY CHECK
-- =========================

Submit.MouseButton1Click:Connect(function()
    local entered=TextBox.Text
    if entered==_0xKEY then
        Submit.Text="✅ Access Granted"
        task.wait(0.5)
        loadVonXHub()
    else
        Submit.Text="❌ Wrong Key"
        task.wait(1)
        Submit.Text="Unlock"
    end
end)
]])()
