local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- UI
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "TPPanel"

local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 240, 0, 150)
Main.Position = UDim2.new(0.3, 0, 0.3, 0)
Main.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Main.Active = true
Main.Draggable = true
Main.Name = "Main"

local UICorner = Instance.new("UICorner", Main)
UICorner.CornerRadius = UDim.new(0, 8)

local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, 0, 0, 25)
Title.BackgroundTransparency = 1
Title.Text = "TP Panel"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 18

local Close = Instance.new("TextButton", Main)
Close.Size = UDim2.new(0, 25, 0, 25)
Close.Position = UDim2.new(1, -25, 0, 0)
Close.Text = "X"
Close.TextColor3 = Color3.new(1, 0.4, 0.4)
Close.Font = Enum.Font.SourceSansBold
Close.TextSize = 18
Close.BackgroundTransparency = 1

Close.MouseButton1Click:Connect(function()
	Main.Visible = false
end)

-- Player List Dropdown
local Dropdown = Instance.new("TextBox", Main)
Dropdown.Size = UDim2.new(1, -20, 0, 30)
Dropdown.Position = UDim2.new(0, 10, 0, 35)
Dropdown.PlaceholderText = "Nombre de jugador"
Dropdown.Text = ""
Dropdown.TextColor3 = Color3.new(1, 1, 1)
Dropdown.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
Dropdown.Font = Enum.Font.SourceSans
Dropdown.TextSize = 16

-- TP A Jugador
local TPTo = Instance.new("TextButton", Main)
TPTo.Size = UDim2.new(1, -20, 0, 30)
TPTo.Position = UDim2.new(0, 10, 0, 70)
TPTo.Text = "Teleport a Jugador"
TPTo.BackgroundColor3 = Color3.fromRGB(30, 100, 255)
TPTo.TextColor3 = Color3.new(1, 1, 1)
TPTo.Font = Enum.Font.SourceSansBold
TPTo.TextSize = 16

TPTo.MouseButton1Click:Connect(function()
	local targetName = Dropdown.Text
	local target = Players:FindFirstChild(targetName)
	if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
		LocalPlayer.Character:MoveTo(target.Character.HumanoidRootPart.Position + Vector3.new(0, 3, 0))
	end
end)

-- TP Jugador a Ti
local TPHere = Instance.new("TextButton", Main)
TPHere.Size = UDim2.new(1, -20, 0, 30)
TPHere.Position = UDim2.new(0, 10, 0, 110)
TPHere.Text = "Traer Jugador a Ti"
TPHere.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
TPHere.TextColor3 = Color3.new(1, 1, 1)
TPHere.Font = Enum.Font.SourceSansBold
TPHere.TextSize = 16

TPHere.MouseButton1Click:Connect(function()
	local targetName = Dropdown.Text
	local target = Players:FindFirstChild(targetName)
	if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
		local myPos = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
		if myPos then
			target.Character.HumanoidRootPart.CFrame = myPos.CFrame * CFrame.new(2, 0, 0)
			wait(0.2)
			target.Character:SetPrimaryPartCFrame(myPos.CFrame * CFrame.new(2, 0, 0)) -- doble intento
		end
	end
end)
