-- ScriptEditorUI.lua
-- Editor de scripts Lua estilo Roblox Studio

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ScriptEditor"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = playerGui

-- ========== BARRA SUPERIOR ==========
local topBar = Instance.new("Frame")
topBar.Size = UDim2.new(1, 0, 0, 35)
topBar.Position = UDim2.new(0, 0, 0, 0)
topBar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
topBar.BorderSizePixel = 0
topBar.Parent = screenGui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(0, 150, 1, 0)
title.Position = UDim2.new(0, 10, 0, 0)
title.BackgroundTransparency = 1
title.Text = "Script Editor"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 16
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = topBar

-- Botones superiores
local btnData = {
	{name = "New", pos = 200, color = Color3.fromRGB(0, 170, 255)},
	{name = "Run", pos = 270, color = Color3.fromRGB(0, 200, 100)},
	{name = "Stop", pos = 340, color = Color3.fromRGB(255, 80, 80)},
	{name = "Save", pos = 410, color = Color3.fromRGB(255, 170, 0)},
	{name = "Publish", pos = 480, color = Color3.fromRGB(150, 0, 255)},
}

for _, btn in ipairs(btnData) do
	local button = Instance.new("TextButton")
	button.Name = btn.name .. "Btn"
	button.Size = UDim2.new(0, 60, 0, 28)
	button.Position = UDim2.new(0, btn.pos, 0, 3)
	button.BackgroundColor3 = btn.color
	button.BorderSizePixel = 0
	button.Text = btn.name
	button.TextColor3 = Color3.fromRGB(255, 255, 255)
	button.TextSize = 13
	button.Font = Enum.Font.GothamBold
	button.Parent = topBar
	
	button.MouseButton1Click:Connect(function()
		game.ReplicatedStorage.ScriptEvent:FireServer(btn.name:lower(), {})
	end)
end

-- ========== EXPLORADOR (Izquierda) ==========
local explorer = Instance.new("Frame")
explorer.Size = UDim2.new(0, 200, 1, -35)
explorer.Position = UDim2.new(0, 0, 0, 35)
explorer.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
explorer.BorderSizePixel = 0
explorer.Parent = screenGui

local explorerTitle = Instance.new("TextLabel")
explorerTitle.Size = UDim2.new(1, 0, 0, 30)
explorerTitle.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
explorerTitle.BorderSizePixel = 0
explorerTitle.Text = "Scripts"
explorerTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
explorerTitle.TextSize = 14
explorerTitle.Font = Enum.Font.GothamBold
explorerTitle.Parent = explorer

local explorerScroll = Instance.new("ScrollingFrame")
explorerScroll.Size = UDim2.new(1, 0, 1, -30)
explorerScroll.Position = UDim2.new(0, 0, 0, 30)
explorerScroll.BackgroundTransparency = 1
explorerScroll.BorderSizePixel = 0
explorerScroll.ScrollBarThickness = 4
explorerScroll.Parent = explorer

-- ========== EDITOR DE CÓDIGO (Centro) ==========
local codeEditor = Instance.new("Frame")
codeEditor.Size = UDim2.new(1, -400, 1, -35)
codeEditor.Position = UDim2.new(0, 200, 0, 35)
codeEditor.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
codeEditor.BorderSizePixel = 0
codeEditor.Parent = screenGui

local editorTitle = Instance.new("Frame")
editorTitle.Size = UDim2.new(1, 0, 0, 30)
editorTitle.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
editorTitle.BorderSizePixel = 0
editorTitle.Parent = codeEditor

local scriptName = Instance.new("TextLabel")
scriptName.Size = UDim2.new(0, 200, 1, 0)
scriptName.Position = UDim2.new(0, 10, 0, 0)
scriptName.BackgroundTransparency = 1
scriptName.Text = "Script.lua"
scriptName.TextColor3 = Color3.fromRGB(200, 200, 200)
scriptName.TextSize = 13
scriptName.Font = Enum.Font.Gotham
scriptName.TextXAlignment = Enum.TextXAlignment.Left
scriptName.Parent = editorTitle

local scriptType = Instance.new("TextLabel")
scriptType.Size = UDim2.new(0, 100, 1, 0)
scriptType.Position = UDim2.new(1, -110, 0, 0)
scriptType.BackgroundTransparency = 1
scriptType.Text = "LocalScript"
scriptType.TextColor3 = Color3.fromRGB(0, 170, 255)
scriptType.TextSize = 12
scriptType.Font = Enum.Font.GothamBold
scriptType.TextXAlignment = Enum.TextXAlignment.Right
scriptType.Parent = editorTitle

local codeBox = Instance.new("TextBox")
codeBox.Name = "CodeBox"
codeBox.Size = UDim2.new(1, -10, 1, -40)
codeBox.Position = UDim2.new(0, 5, 0, 35)
codeBox.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
codeBox.BorderSizePixel = 0
codeBox.Text = "-- Write your Lua code here\nprint('Hello World!')"
codeBox.TextColor3 = Color3.fromRGB(220, 220, 220)
codeBox.TextSize = 14
codeBox.Font = Enum.Font.Code
codeBox.TextXAlignment = Enum.TextXAlignment.Left
codeBox.TextYAlignment = Enum.TextYAlignment.Top
codeBox.MultiLine = true
codeBox.ClearTextOnFocus = false
codeBox.Parent = codeEditor

-- ========== PROPIEDADES (Derecha) ==========
local properties = Instance.new("Frame")
properties.Size = UDim2.new(0, 200, 1, -35)
properties.Position = UDim2.new(1, -200, 0, 35)
properties.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
properties.BorderSizePixel = 0
properties.Parent = screenGui

local propsTitle = Instance.new("TextLabel")
propsTitle.Size = UDim2.new(1, 0, 0, 30)
propsTitle.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
propsTitle.BorderSizePixel = 0
propsTitle.Text = "Properties"
propsTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
propsTitle.TextSize = 14
propsTitle.Font = Enum.Font.GothamBold
propsTitle.Parent = properties

-- Tipo de script
local typeFrame = Instance.new("Frame")
typeFrame.Size = UDim2.new(1, -10, 0, 60)
typeFrame.Position = UDim2.new(0, 5, 0, 40)
typeFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
typeFrame.BorderSizePixel = 0
typeFrame.Parent = properties

local typeLabel = Instance.new("TextLabel")
typeLabel.Size = UDim2.new(1, 0, 0, 20)
typeLabel.BackgroundTransparency = 1
typeLabel.Text = "Script Type"
typeLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
typeLabel.TextSize = 12
typeLabel.Font = Enum.Font.Gotham
typeLabel.TextXAlignment = Enum.TextXAlignment.Left
typeLabel.Parent = typeFrame

local localBtn = Instance.new("TextButton")
localBtn.Size = UDim2.new(0.48, 0, 0, 30)
localBtn.Position = UDim2.new(0, 0, 0, 25)
localBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
localBtn.BorderSizePixel = 0
localBtn.Text = "LocalScript"
localBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
localBtn.TextSize = 11
localBtn.Font = Enum.Font.GothamBold
localBtn.Parent = typeFrame

local serverBtn = Instance.new("TextButton")
serverBtn.Size = UDim2.new(0.48, 0, 0, 30)
serverBtn.Position = UDim2.new(0.52, 0, 0, 25)
serverBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
serverBtn.BorderSizePixel = 0
serverBtn.Text = "ServerScript"
serverBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
serverBtn.TextSize = 11
serverBtn.Font = Enum.Font.GothamBold
serverBtn.Parent = typeFrame

local currentType = "LocalScript"

localBtn.MouseButton1Click:Connect(function()
	currentType = "LocalScript"
	localBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
	serverBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	scriptType.Text = "LocalScript"
	scriptType.TextColor3 = Color3.fromRGB(0, 170, 255)
end)

serverBtn.MouseButton1Click:Connect(function()
	currentType = "ServerScript"
	serverBtn.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
	localBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	scriptType.Text = "ServerScript"
	scriptType.TextColor3 = Color3.fromRGB(255, 100, 100)
end)

-- Output
local outputFrame = Instance.new("Frame")
outputFrame.Size = UDim2.new(1, -10, 0, 150)
outputFrame.Position = UDim2.new(0, 5, 0, 110)
outputFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
outputFrame.BorderSizePixel = 0
outputFrame.Parent = properties

local outputLabel = Instance.new("TextLabel")
outputLabel.Size = UDim2.new(1, 0, 0, 20)
outputLabel.BackgroundTransparency = 1
outputLabel.Text = "Output"
outputLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
outputLabel.TextSize = 12
outputLabel.Font = Enum.Font.Gotham
outputLabel.TextXAlignment = Enum.TextXAlignment.Left
outputLabel.Parent = outputFrame

local outputBox = Instance.new("TextLabel")
outputBox.Name = "OutputBox"
outputBox.Size = UDim2.new(1, -10, 1, -25)
outputBox.Position = UDim2.new(0, 5, 0, 22)
outputBox.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
outputBox.BorderSizePixel = 0
outputBox.Text = "> Ready"
outputBox.TextColor3 = Color3.fromRGB(0, 255, 100)
outputBox.TextSize = 11
outputBox.Font = Enum.Font.Code
outputBox.TextXAlignment = Enum.TextXAlignment.Left
outputBox.TextYAlignment = Enum.TextYAlignment.Top
outputBox.TextWrapped = true
outputBox.Parent = outputFrame

print("Script Editor UI cargado")
