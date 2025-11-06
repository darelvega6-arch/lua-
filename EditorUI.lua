-- EditorUI.lua - Studio Lite
-- Interfaz minimalista sin bordes

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "EditorStudio"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = playerGui

-- ========== BARRA SUPERIOR ==========
local topBar = Instance.new("Frame")
topBar.Name = "TopBar"
topBar.Size = UDim2.new(1, 0, 0, 40)
topBar.Position = UDim2.new(0, 0, 0, 0)
topBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
topBar.BorderSizePixel = 0
topBar.Parent = screenGui

local topBarTitle = Instance.new("TextLabel")
topBarTitle.Size = UDim2.new(0, 200, 1, 0)
topBarTitle.Position = UDim2.new(0, 10, 0, 0)
topBarTitle.BackgroundTransparency = 1
topBarTitle.Text = "Studio Lite"
topBarTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
topBarTitle.TextSize = 18
topBarTitle.Font = Enum.Font.GothamBold
topBarTitle.TextXAlignment = Enum.TextXAlignment.Left
topBarTitle.Parent = topBar

-- ========== TOOLBAR ==========
local toolbar = Instance.new("Frame")
toolbar.Name = "Toolbar"
toolbar.Size = UDim2.new(1, 0, 0, 50)
toolbar.Position = UDim2.new(0, 0, 0, 40)
toolbar.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
toolbar.BorderSizePixel = 0
toolbar.Parent = screenGui

local toolButtons = {
	{name = "Select", color = Color3.fromRGB(0, 162, 255)},
	{name = "Move", color = Color3.fromRGB(0, 200, 100)},
	{name = "Scale", color = Color3.fromRGB(255, 170, 0)},
	{name = "Rotate", color = Color3.fromRGB(200, 85, 200)},
	{name = "Paint", color = Color3.fromRGB(255, 100, 150)},
	{name = "Delete", color = Color3.fromRGB(255, 50, 50)},
}

local selectedTool = "Select"

for i, tool in ipairs(toolButtons) do
	local btn = Instance.new("TextButton")
	btn.Name = tool.name .. "Btn"
	btn.Size = UDim2.new(0, 80, 1, -10)
	btn.Position = UDim2.new(0, 5 + (i-1) * 85, 0, 5)
	btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
	btn.BorderSizePixel = 0
	btn.Text = tool.name
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.TextSize = 14
	btn.Font = Enum.Font.GothamBold
	btn.Parent = toolbar
	
	btn.MouseButton1Click:Connect(function()
		selectedTool = tool.name
		for _, child in pairs(toolbar:GetChildren()) do
			if child:IsA("TextButton") then
				child.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
			end
		end
		btn.BackgroundColor3 = tool.color
	end)
end

-- ========== PANEL DE PARTES ==========
local partsPanel = Instance.new("Frame")
partsPanel.Name = "PartsPanel"
partsPanel.Size = UDim2.new(0, 150, 1, -190)
partsPanel.Position = UDim2.new(0, 0, 0, 90)
partsPanel.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
partsPanel.BorderSizePixel = 0
partsPanel.Parent = screenGui

local partsTitle = Instance.new("TextLabel")
partsTitle.Size = UDim2.new(1, 0, 0, 30)
partsTitle.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
partsTitle.BorderSizePixel = 0
partsTitle.Text = "Parts"
partsTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
partsTitle.TextSize = 14
partsTitle.Font = Enum.Font.GothamBold
partsTitle.Parent = partsPanel

local partTypes = {
	{name = "Block"},
	{name = "Sphere"},
	{name = "Cylinder"},
	{name = "Wedge"},
}

for i, part in ipairs(partTypes) do
	local partBtn = Instance.new("TextButton")
	partBtn.Name = part.name .. "Btn"
	partBtn.Size = UDim2.new(1, -10, 0, 40)
	partBtn.Position = UDim2.new(0, 5, 0, 35 + (i-1) * 45)
	partBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
	partBtn.BorderSizePixel = 0
	partBtn.Text = part.name
	partBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	partBtn.TextSize = 14
	partBtn.Font = Enum.Font.GothamBold
	partBtn.Parent = partsPanel
	
	partBtn.MouseButton1Click:Connect(function()
		game.ReplicatedStorage.EditorEvent:FireServer("createPart", {partType = part.name})
	end)
end

-- ========== EXPLORADOR ==========
local explorer = Instance.new("Frame")
explorer.Name = "Explorer"
explorer.Size = UDim2.new(0, 250, 0.5, -95)
explorer.Position = UDim2.new(1, -250, 0, 90)
explorer.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
explorer.BorderSizePixel = 0
explorer.Parent = screenGui

local explorerTitle = Instance.new("TextLabel")
explorerTitle.Size = UDim2.new(1, 0, 0, 30)
explorerTitle.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
explorerTitle.BorderSizePixel = 0
explorerTitle.Text = "Explorer"
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

-- ========== PROPIEDADES ==========
local properties = Instance.new("Frame")
properties.Name = "Properties"
properties.Size = UDim2.new(0, 250, 0.5, -95)
properties.Position = UDim2.new(1, -250, 0.5, 0)
properties.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
properties.BorderSizePixel = 0
properties.Parent = screenGui

local propertiesTitle = Instance.new("TextLabel")
propertiesTitle.Size = UDim2.new(1, 0, 0, 30)
propertiesTitle.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
propertiesTitle.BorderSizePixel = 0
propertiesTitle.Text = "Properties"
propertiesTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
propertiesTitle.TextSize = 14
propertiesTitle.Font = Enum.Font.GothamBold
propertiesTitle.Parent = properties

local propertiesScroll = Instance.new("ScrollingFrame")
propertiesScroll.Size = UDim2.new(1, 0, 1, -30)
propertiesScroll.Position = UDim2.new(0, 0, 0, 30)
propertiesScroll.BackgroundTransparency = 1
propertiesScroll.BorderSizePixel = 0
propertiesScroll.ScrollBarThickness = 4
propertiesScroll.Parent = properties

-- ========== CONTROLES MÓVILES ==========
local mobileControls = Instance.new("Frame")
mobileControls.Name = "MobileControls"
mobileControls.Size = UDim2.new(1, -400, 0, 100)
mobileControls.Position = UDim2.new(0, 150, 1, -100)
mobileControls.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
mobileControls.BorderSizePixel = 0
mobileControls.Parent = screenGui

-- Joystick
local joystick = Instance.new("Frame")
joystick.Name = "Joystick"
joystick.Size = UDim2.new(0, 80, 0, 80)
joystick.Position = UDim2.new(0, 10, 0, 10)
joystick.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
joystick.BorderSizePixel = 0
joystick.Parent = mobileControls

local joystickKnob = Instance.new("Frame")
joystickKnob.Name = "Knob"
joystickKnob.Size = UDim2.new(0, 30, 0, 30)
joystickKnob.Position = UDim2.new(0.5, -15, 0.5, -15)
joystickKnob.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
joystickKnob.BorderSizePixel = 0
joystickKnob.Parent = joystick

local actionButtons = {
	{name = "Undo", pos = UDim2.new(0, 100, 0, 10)},
	{name = "Redo", pos = UDim2.new(0, 180, 0, 10)},
	{name = "Copy", pos = UDim2.new(0, 260, 0, 10)},
	{name = "Play", pos = UDim2.new(0, 340, 0, 10)},
	{name = "Stop", pos = UDim2.new(0, 420, 0, 10)},
	{name = "Grid", pos = UDim2.new(0, 500, 0, 10)},
}

for _, action in ipairs(actionButtons) do
	local actionBtn = Instance.new("TextButton")
	actionBtn.Name = action.name .. "Btn"
	actionBtn.Size = UDim2.new(0, 70, 0, 80)
	actionBtn.Position = action.pos
	actionBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
	actionBtn.BorderSizePixel = 0
	actionBtn.Text = action.name
	actionBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	actionBtn.TextSize = 14
	actionBtn.Font = Enum.Font.GothamBold
	actionBtn.Parent = mobileControls
	
	actionBtn.MouseButton1Click:Connect(function()
		if action.name == "Grid" then
			game.ReplicatedStorage.EditorEvent:FireServer("toggleGrid", {})
		else
			game.ReplicatedStorage.EditorEvent:FireServer("action", {action = action.name})
		end
	end)
end

print("Editor UI Lite cargado")
