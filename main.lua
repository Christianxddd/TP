local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")

local gui = Instance.new("ScreenGui")
gui.Name = "TPPanel"
gui.ResetOnSpawn = false
gui.Parent = game.CoreGui

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 280, 0, 120)
frame.Position = UDim2.new(0.4, 0, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.Text = "Teleport Panel"
title.Position = UDim2.new(0, 0, 0, 0)

local function createButton(text, yPos, callback)
    local btn = Instance.new("TextButton", frame)
    btn.Size = UDim2.new(1, -20, 0, 35)
    btn.Position = UDim2.new(0, 10, 0, yPos)
    btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 18
    btn.Text = text
    btn.BorderSizePixel = 0
    btn.AutoButtonColor = true
    btn.MouseButton1Click:Connect(callback)
    return btn
end

local function createInputWindow(prompt, callback)
    local inputGui = Instance.new("ScreenGui", game.CoreGui)
    inputGui.Name = "TPInputGui"

    local inputFrame = Instance.new("Frame", inputGui)
    inputFrame.Size = UDim2.new(0, 320, 0, 130)
    inputFrame.Position = UDim2.new(0.5, -160, 0.5, -65)
    inputFrame.BackgroundColor3 = Color3.fromRGB(20,20,20)
    inputFrame.BorderSizePixel = 0
    inputFrame.Active = true
    inputFrame.Draggable = true

    local corner = Instance.new("UICorner", inputFrame)
    corner.CornerRadius = UDim.new(0, 10)

    local textLabel = Instance.new("TextLabel", inputFrame)
    textLabel.Size = UDim2.new(1, -20, 0, 30)
    textLabel.Position = UDim2.new(0, 10, 0, 10)
    textLabel.BackgroundTransparency = 1
    textLabel.TextColor3 = Color3.new(1,1,1)
    textLabel.Font = Enum.Font.GothamBold
    textLabel.TextSize = 18
    textLabel.Text = prompt

    local textBox = Instance.new("TextBox", inputFrame)
    textBox.Size = UDim2.new(1, -20, 0, 35)
    textBox.Position = UDim2.new(0, 10, 0, 50)
    textBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    textBox.TextColor3 = Color3.new(1,1,1)
    textBox.Font = Enum.Font.Gotham
    textBox.TextSize = 18
    textBox.Text = ""

    local acceptBtn = Instance.new("TextButton", inputFrame)
    acceptBtn.Size = UDim2.new(0.5, -15, 0, 30)
    acceptBtn.Position = UDim2.new(0, 10, 0, 95)
    acceptBtn.BackgroundColor3 = Color3.fromRGB(70, 130, 180)
    acceptBtn.TextColor3 = Color3.new(1,1,1)
    acceptBtn.Font = Enum.Font.GothamBold
    acceptBtn.TextSize = 18
    acceptBtn.Text = "Aceptar"

    local cancelBtn = Instance.new("TextButton", inputFrame)
    cancelBtn.Size = UDim2.new(0.5, -15, 0, 30)
    cancelBtn.Position = UDim2.new(0.5, 5, 0, 95)
    cancelBtn.BackgroundColor3 = Color3.fromRGB(180, 70, 70)
    cancelBtn.TextColor3 = Color3.new(1,1,1)
    cancelBtn.Font = Enum.Font.GothamBold
    cancelBtn.TextSize = 18
    cancelBtn.Text = "Cancelar"

    acceptBtn.MouseButton1Click:Connect(function()
        local text = textBox.Text
        if text and text ~= "" then
            callback(text)
        end
        inputGui:Destroy()
    end)

    cancelBtn.MouseButton1Click:Connect(function()
        inputGui:Destroy()
    end)
end

-- Teleportarte a jugador
createButton("📍 Teleport a jugador", 40, function()
    createInputWindow("Ingresa el nombre del jugador", function(targetName)
        local targetPlayer = Players:FindFirstChild(targetName)
        if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                hrp.CFrame = targetPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
            end
        else
            warn("Jugador no encontrado o sin personaje válido.")
        end
    end)
end)

-- Teleportar jugador a ti
createButton("📲 Teleportar jugador a ti", 85, function()
    createInputWindow("Nombre del jugador para teleportar a ti", function(targetName)
        local targetPlayer = Players:FindFirstChild(targetName)
        if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = targetPlayer.Character.HumanoidRootPart
            local myHrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if hrp and myHrp then
                hrp.CFrame = myHrp.CFrame + Vector3.new(0, 3, 0)
            end
        else
            warn("Jugador no encontrado o sin personaje válido.")
        end
    end)
end)
