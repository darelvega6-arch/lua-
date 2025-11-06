-- EditorUI.lua
-- Sistema de interfaz completo para editor móvil estilo Roblox Studio

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Crear ScreenGui principal
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "EditorStudio"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = playerGui

-- ========== BARRA SUPERIOR ==========
local topBar = Instance.new("Frame")
topBar.Name = "TopBar"
topBar.Size = UDim2.new(1, 0, 0, 50)
topBar.Position = UDim2.new(0, 0, 0, 0)
topBar.BackgroundColor3 = Color3.fromRGB(46, 46, 46)
topBar.BorderSizePixel = 0
topBar.Parent = screenGui

local topBarTitle = Instance.new("TextLabel")
topBarTitle.Size = UDim2.new(0, 200, 1, 0)
topBarTitle.Position = UDim2.new(0, 10, 0, 0)
topBarTitle.BackgroundTransparency = 1
topBarTitle.Text = "Studio Mobile"
topBarTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
topBarTitle.TextSize = 20
topBarTitle.Font = Enum.Font.GothamBold
topBarTitle.TextXAlignment = Enum.TextXAlignment.Left
topBarTitle.Parent = topBar

-- ========== TOOLBAR (Herramientas) ==========
local toolbar = Instance.new("Frame")
toolbar.Name = "Toolbar"
toolbar.Size = UDim2.new(1, 0, 0, 60)
toolbar.Position = UDim2.new(0, 0, 0, 50)
toolbar.BackgroundColor3 = Color3.fromRGB(53, 53, 53)
toolbar.BorderSizePixel = 0
toolbar.Parent = screenGui

local toolButtons = {
	{name = "Select", icon = "🔍", color = Color3.fromRGB(0, 162, 255)},
	{name = "Move", icon = "✋", color = Color3.fromRGB(0, 255, 127)},
	{name = "Scale", icon = "📏", color = Color3.fromRGB(255, 170, 0)},
	{name = "Rotate", icon = "🔄", color = Color3.fromRGB(255, 85, 255)},
	{name = "Paint", icon = "🎨", color = Color3.fromRGB(255, 0, 127)},
	{name = "Delete", icon = "🗑️", color = Color3.fromRGB(255, 50, 50)},
}

local selectedTool = "Select"

for i, tool in ipairs(toolButtons) do
	local btn = Instance.new("TextButton")
	btn.Name = tool.name .. "Btn"
	btn.Size = UDim2.new(0, 80, 0, 50)
	btn.Position = UDim2.new(0, 10 + (i-1) * 85, 0, 5)
	btn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
	btn.BorderSizePixel = 0
	btn.Text = tool.icon .. "\n" .. tool.name
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.TextSize = 12
	btn.Font = Enum.Font.Gotham
	btn.Parent = toolbar
	
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 8)
	corner.Parent = btn
	
	btn.MouseButton1Click:Connect(function()
		selectedTool = tool.name
		-- Actualizar visual de botón seleccionado
		for _, child in pairs(toolbar:GetChildren()) do
			if child:IsA("TextButton") then
				child.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
			end
		end
		btn.BackgroundColor3 = tool.color
		print("Herramienta seleccionada:", tool.name)
	end)
end

-- ========== PANEL DE PARTES (Izquierda) ==========
local partsPanel = Instance.new("Frame")
partsPanel.Name = "PartsPanel"
partsPanel.Size = UDim2.new(0, 120, 0, 400)
partsPanel.Position = UDim2.new(0, 10, 0, 120)
partsPanel.BackgroundColor3 = Color3.fromRGB(46, 46, 46)
partsPanel.BorderSizePixel = 0
partsPanel.Parent = screenGui

local partsPanelCorner = Instance.new("UICorner")
partsPanelCorner.CornerRadius = UDim.new(0, 10)
partsPanelCorner.Parent = partsPanel

local partsTitle = Instance.new("TextLabel")
partsTitle.Size = UDim2.new(1, 0, 0, 35)
partsTitle.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
partsTitle.Text = "Parts"
partsTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
partsTitle.TextSize = 16
partsTitle.Font = Enum.Font.GothamBold
partsTitle.Parent = partsPanel

local partTypes = {
	{name = "Block", icon = "⬛"},
	{name = "Sphere", icon = "⚫"},
	{name = "Cylinder", icon = "🔵"},
	{name = "Wedge", icon = "🔺"},
	{name = "Spawn", icon = "🚩"},
	{name = "Model", icon = "📦"},
}

for i, part in ipairs(partTypes) do
	local partBtn = Instance.new("TextButton")
	partBtn.Name = part.name .. "Btn"
	partBtn.Size = UDim2.new(1, -10, 0, 50)
	partBtn.Position = UDim2.new(0, 5, 0, 40 + (i-1) * 55)
	partBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
	partBtn.Text = part.icon .. " " .. part.name
	partBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	partBtn.TextSize = 14
	partBtn.Font = Enum.Font.Gotham
	partBtn.Parent = partsPanel
	
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 6)
	corner.Parent = partBtn
	
	partBtn.MouseButton1Click:Connect(function()
		-- Enviar al servidor para crear parte
		game.ReplicatedStorage.EditorEvent:FireServer("createPart", {partType = part.name})
		print("Creando:", part.name)
	end)
end

-- ========== EXPLORADOR (Derecha Superior) ==========
local explorer = Instance.new("Frame")
explorer.Name = "Explorer"
explorer.Size = UDim2.new(0, 200, 0, 300)
explorer.Position = UDim2.new(1, -210, 0, 120)
explorer.BackgroundColor3 = Color3.fromRGB(46, 46, 46)
explorer.BorderSizePixel = 0
explorer.Parent = screenGui

local explorerCorner = Instance.new("UICorner")
explorerCorner.CornerRadius = UDim.new(0, 10)
explorerCorner.Parent = explorer

local explorerTitle = Instance.new("TextLabel")
explorerTitle.Size = UDim2.new(1, 0, 0, 35)
explorerTitle.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
explorerTitle.Text = "Explorer"
explorerTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
explorerTitle.TextSize = 16
explorerTitle.Font = Enum.Font.GothamBold
explorerTitle.Parent = explorer

local explorerScroll = Instance.new("ScrollingFrame")
explorerScroll.Size = UDim2.new(1, -10, 1, -45)
explorerScroll.Position = UDim2.new(0, 5, 0, 40)
explorerScroll.BackgroundTransparency = 1
explorerScroll.BorderSizePixel = 0
explorerScroll.ScrollBarThickness = 6
explorerScroll.Parent = explorer

-- ========== PROPIEDADES (Derecha Inferior) ==========
local properties = Instance.new("Frame")
properties.Name = "Properties"
properties.Size = UDim2.new(0, 200, 0, 250)
properties.Position = UDim2.new(1, -210, 0, 430)
properties.BackgroundColor3 = Color3.fromRGB(46, 46, 46)
properties.BorderSizePixel = 0
properties.Parent = screenGui

local propertiesCorner = Instance.new("UICorner")
propertiesCorner.CornerRadius = UDim.new(0, 10)
propertiesCorner.Parent = properties

local propertiesTitle = Instance.new("TextLabel")
propertiesTitle.Size = UDim2.new(1, 0, 0, 35)
propertiesTitle.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
propertiesTitle.Text = "Properties"
propertiesTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
propertiesTitle.TextSize = 16
propertiesTitle.Font = Enum.Font.GothamBold
propertiesTitle.Parent = properties

local propertiesScroll = Instance.new("ScrollingFrame")
propertiesScroll.Size = UDim2.new(1, -10, 1, -45)
propertiesScroll.Position = UDim2.new(0, 5, 0, 40)
propertiesScroll.BackgroundTransparency = 1
propertiesScroll.BorderSizePixel = 0
propertiesScroll.ScrollBarThickness = 6
propertiesScroll.Parent = properties

-- ========== CONTROLES MÓVILES (Inferior) ==========
local mobileControls = Instance.new("Frame")
mobileControls.Name = "MobileControls"
mobileControls.Size = UDim2.new(0, 300, 0, 120)
mobileControls.Position = UDim2.new(0.5, -150, 1, -130)
mobileControls.BackgroundColor3 = Color3.fromRGB(46, 46, 46)
mobileControls.BorderSizePixel = 0
mobileControls.BackgroundTransparency = 0.3
mobileControls.Parent = screenGui

local mobileCorner = Instance.new("UICorner")
mobileCorner.CornerRadius = UDim.new(0, 15)
mobileCorner.Parent = mobileControls

-- Joystick de movimiento
local joystick = Instance.new("Frame")
joystick.Name = "Joystick"
joystick.Size = UDim2.new(0, 100, 0, 100)
joystick.Position = UDim2.new(0, 10, 0, 10)
joystick.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
joystick.BackgroundTransparency = 0.5
joystick.Parent = mobileControls

local joystickCorner = Instance.new("UICorner")
joystickCorner.CornerRadius = UDim.new(1, 0)
joystickCorner.Parent = joystick

local joystickKnob = Instance.new("Frame")
joystickKnob.Name = "Knob"
joystickKnob.Size = UDim2.new(0, 40, 0, 40)
joystickKnob.Position = UDim2.new(0.5, -20, 0.5, -20)
joystickKnob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
joystickKnob.Parent = joystick

local knobCorner = Instance.new("UICorner")
knobCorner.CornerRadius = UDim.new(1, 0)
knobCorner.Parent = joystickKnob

-- Botones de acción
local actionButtons = {
	{name = "Undo", icon = "↶", pos = UDim2.new(0, 120, 0, 10)},
	{name = "Redo", icon = "↷", pos = UDim2.new(0, 170, 0, 10)},
	{name = "Copy", icon = "📋", pos = UDim2.new(0, 220, 0, 10)},
	{name = "Play", icon = "▶️", pos = UDim2.new(0, 120, 0, 60)},
	{name = "Stop", icon = "⏹️", pos = UDim2.new(0, 170, 0, 60)},
	{name = "Save", icon = "💾", pos = UDim2.new(0, 220, 0, 60)},
}

for _, action in ipairs(actionButtons) do
	local actionBtn = Instance.new("TextButton")
	actionBtn.Name = action.name .. "Btn"
	actionBtn.Size = UDim2.new(0, 40, 0, 40)
	actionBtn.Position = action.pos
	actionBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
	actionBtn.Text = action.icon
	actionBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	actionBtn.TextSize = 18
	actionBtn.Font = Enum.Font.Gotham
	actionBtn.Parent = mobileControls
	
	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 8)
	corner.Parent = actionBtn
	
	actionBtn.MouseButton1Click:Connect(function()
		game.ReplicatedStorage.EditorEvent:FireServer("action", {action = action.name})
		print("Acción:", action.name)
	end)
end

-- ========== GRID SETTINGS (Botón flotante) ==========
local gridBtn = Instance.new("TextButton")
gridBtn.Name = "GridBtn"
gridBtn.Size = UDim2.new(0, 60, 0, 60)
gridBtn.Position = UDim2.new(1, -70, 1, -200)
gridBtn.BackgroundColor3 = Color3.fromRGB(0, 162, 255)
gridBtn.Text = "⊞\nGrid"
gridBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
gridBtn.TextSize = 14
gridBtn.Font = Enum.Font.GothamBold
gridBtn.Parent = screenGui

local gridCorner = Instance.new("UICorner")
gridCorner.CornerRadius = UDim.new(1, 0)
gridCorner.Parent = gridBtn

gridBtn.MouseButton1Click:Connect(function()
	game.ReplicatedStorage.EditorEvent:FireServer("toggleGrid", {})
	print("Toggle Grid")
end)

print("Editor UI cargado completamente")
