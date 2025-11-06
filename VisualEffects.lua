-- VisualEffects.lua
-- Sistema de efectos visuales y animaciones para el editor

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local editorUI = playerGui:WaitForChild("EditorStudio")

-- ========== ANIMACIONES DE BOTONES ==========
local function animateButton(button)
	button.MouseEnter:Connect(function()
		local tween = TweenService:Create(button, TweenInfo.new(0.2), {
			Size = button.Size + UDim2.new(0, 5, 0, 5),
			BackgroundColor3 = Color3.fromRGB(
				math.min(button.BackgroundColor3.R * 255 + 20, 255),
				math.min(button.BackgroundColor3.G * 255 + 20, 255),
				math.min(button.BackgroundColor3.B * 255 + 20, 255)
			)
		})
		tween:Play()
	end)
	
	button.MouseLeave:Connect(function()
		local tween = TweenService:Create(button, TweenInfo.new(0.2), {
			Size = button.Size - UDim2.new(0, 5, 0, 5)
		})
		tween:Play()
	end)
	
	button.MouseButton1Down:Connect(function()
		local tween = TweenService:Create(button, TweenInfo.new(0.1), {
			Size = button.Size - UDim2.new(0, 3, 0, 3)
		})
		tween:Play()
	end)
	
	button.MouseButton1Up:Connect(function()
		local tween = TweenService:Create(button, TweenInfo.new(0.1), {
			Size = button.Size + UDim2.new(0, 3, 0, 3)
		})
		tween:Play()
	end)
end

-- Aplicar animaciones a todos los botones
for _, descendant in pairs(editorUI:GetDescendants()) do
	if descendant:IsA("TextButton") then
		animateButton(descendant)
	end
end

-- ========== GRID VISUAL EN WORKSPACE ==========
local function createVisualGrid()
	local gridFolder = Instance.new("Folder")
	gridFolder.Name = "VisualGrid"
	gridFolder.Parent = workspace
	
	local gridSize = 50
	local gridSpacing = 4
	local gridColor = Color3.fromRGB(100, 100, 100)
	
	-- Líneas en X
	for i = -gridSize, gridSize do
		local line = Instance.new("Part")
		line.Size = Vector3.new(gridSize * 2 * gridSpacing, 0.1, 0.1)
		line.Position = Vector3.new(0, 0.05, i * gridSpacing)
		line.Anchored = true
		line.CanCollide = false
		line.Transparency = 0.8
		line.Color = gridColor
		line.Material = Enum.Material.Neon
		line.Parent = gridFolder
	end
	
	-- Líneas en Z
	for i = -gridSize, gridSize do
		local line = Instance.new("Part")
		line.Size = Vector3.new(0.1, 0.1, gridSize * 2 * gridSpacing)
		line.Position = Vector3.new(i * gridSpacing, 0.05, 0)
		line.Anchored = true
		line.CanCollide = false
		line.Transparency = 0.8
		line.Color = gridColor
		line.Material = Enum.Material.Neon
		line.Parent = gridFolder
	end
	
	return gridFolder
end

local visualGrid = createVisualGrid()

-- ========== HIGHLIGHT PARA OBJETOS ==========
local function addHighlight(part)
	if not part:FindFirstChild("Highlight") then
		local highlight = Instance.new("Highlight")
		highlight.Name = "Highlight"
		highlight.Adornee = part
		highlight.FillColor = Color3.fromRGB(0, 162, 255)
		highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
		highlight.FillTransparency = 0.5
		highlight.OutlineTransparency = 0
		highlight.Parent = part
	end
end

-- ========== EFECTOS DE PARTÍCULAS ==========
local function createSpawnEffect(position)
	local part = Instance.new("Part")
	part.Size = Vector3.new(1, 1, 1)
	part.Position = position
	part.Anchored = true
	part.CanCollide = false
	part.Transparency = 1
	part.Parent = workspace
	
	local particles = Instance.new("ParticleEmitter")
	particles.Texture = "rbxasset://textures/particles/sparkles_main.dds"
	particles.Rate = 100
	particles.Lifetime = NumberRange.new(0.5, 1)
	particles.Speed = NumberRange.new(5, 10)
	particles.SpreadAngle = Vector2.new(180, 180)
	particles.Color = ColorSequence.new(Color3.fromRGB(0, 162, 255))
	particles.Size = NumberSequence.new(0.5, 0)
	particles.Transparency = NumberSequence.new(0, 1)
	particles.LightEmission = 1
	particles.Parent = part
	
	wait(0.5)
	particles.Enabled = false
	wait(1)
	part:Destroy()
end

-- ========== INDICADOR DE HERRAMIENTA ACTIVA ==========
local toolIndicator = Instance.new("Frame")
toolIndicator.Name = "ToolIndicator"
toolIndicator.Size = UDim2.new(0, 150, 0, 40)
toolIndicator.Position = UDim2.new(0.5, -75, 0, 115)
toolIndicator.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
toolIndicator.BackgroundTransparency = 0.3
toolIndicator.BorderSizePixel = 0
toolIndicator.Parent = editorUI

local indicatorCorner = Instance.new("UICorner")
indicatorCorner.CornerRadius = UDim.new(0, 20)
indicatorCorner.Parent = toolIndicator

local indicatorText = Instance.new("TextLabel")
indicatorText.Size = UDim2.new(1, 0, 1, 0)
indicatorText.BackgroundTransparency = 1
indicatorText.Text = "🔍 Select Tool"
indicatorText.TextColor3 = Color3.fromRGB(255, 255, 255)
indicatorText.TextSize = 16
indicatorText.Font = Enum.Font.GothamBold
indicatorText.Parent = toolIndicator

-- Animación de aparición
local function showToolIndicator(toolName, icon)
	indicatorText.Text = icon .. " " .. toolName
	toolIndicator.BackgroundTransparency = 0.3
	
	local tween = TweenService:Create(toolIndicator, TweenInfo.new(2), {
		BackgroundTransparency = 1
	})
	tween:Play()
	
	local textTween = TweenService:Create(indicatorText, TweenInfo.new(2), {
		TextTransparency = 1
	})
	textTween:Play()
	
	wait(2)
	indicatorText.TextTransparency = 0
end

-- ========== NOTIFICACIONES ==========
local function showNotification(message, duration, color)
	local notification = Instance.new("Frame")
	notification.Size = UDim2.new(0, 300, 0, 60)
	notification.Position = UDim2.new(1, 320, 0, 60)
	notification.BackgroundColor3 = color or Color3.fromRGB(46, 46, 46)
	notification.BorderSizePixel = 0
	notification.Parent = editorUI
	
	local notifCorner = Instance.new("UICorner")
	notifCorner.CornerRadius = UDim.new(0, 10)
	notifCorner.Parent = notification
	
	local notifText = Instance.new("TextLabel")
	notifText.Size = UDim2.new(1, -20, 1, 0)
	notifText.Position = UDim2.new(0, 10, 0, 0)
	notifText.BackgroundTransparency = 1
	notifText.Text = message
	notifText.TextColor3 = Color3.fromRGB(255, 255, 255)
	notifText.TextSize = 14
	notifText.Font = Enum.Font.Gotham
	notifText.TextWrapped = true
	notifText.TextXAlignment = Enum.TextXAlignment.Left
	notifText.Parent = notification
	
	-- Animación de entrada
	local tweenIn = TweenService:Create(notification, TweenInfo.new(0.3), {
		Position = UDim2.new(1, -310, 0, 60)
	})
	tweenIn:Play()
	
	-- Esperar y salir
	wait(duration or 3)
	
	local tweenOut = TweenService:Create(notification, TweenInfo.new(0.3), {
		Position = UDim2.new(1, 320, 0, 60)
	})
	tweenOut:Play()
	
	wait(0.3)
	notification:Destroy()
end

-- ========== CURSOR PERSONALIZADO ==========
local customCursor = Instance.new("ImageLabel")
customCursor.Name = "CustomCursor"
customCursor.Size = UDim2.new(0, 32, 0, 32)
customCursor.BackgroundTransparency = 1
customCursor.Image = "rbxasset://textures/Cursors/KeyboardMouse/ArrowCursor.png"
customCursor.ZIndex = 100
customCursor.Visible = false
customCursor.Parent = editorUI

local mouse = player:GetMouse()

game:GetService("RunService").RenderStepped:Connect(function()
	customCursor.Position = UDim2.new(0, mouse.X, 0, mouse.Y)
end)

-- ========== EFECTOS DE SELECCIÓN ==========
local function createSelectionRing(part)
	local ring = Instance.new("Part")
	ring.Name = "SelectionRing"
	ring.Size = Vector3.new(part.Size.X + 2, 0.1, part.Size.Z + 2)
	ring.Position = part.Position - Vector3.new(0, part.Size.Y/2, 0)
	ring.Anchored = true
	ring.CanCollide = false
	ring.Transparency = 0.5
	ring.Color = Color3.fromRGB(0, 162, 255)
	ring.Material = Enum.Material.Neon
	ring.Parent = workspace
	
	-- Animación de rotación
	spawn(function()
		while ring.Parent do
			ring.CFrame = ring.CFrame * CFrame.Angles(0, math.rad(2), 0)
			wait(0.03)
		end
	end)
	
	return ring
end

-- ========== MINI MAPA ==========
local miniMap = Instance.new("Frame")
miniMap.Name = "MiniMap"
miniMap.Size = UDim2.new(0, 150, 0, 150)
miniMap.Position = UDim2.new(1, -160, 0, 60)
miniMap.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
miniMap.BackgroundTransparency = 0.3
miniMap.BorderSizePixel = 0
miniMap.Parent = editorUI

local miniMapCorner = Instance.new("UICorner")
miniMapCorner.CornerRadius = UDim.new(0, 10)
miniMapCorner.Parent = miniMap

local miniMapTitle = Instance.new("TextLabel")
miniMapTitle.Size = UDim2.new(1, 0, 0, 25)
miniMapTitle.BackgroundTransparency = 1
miniMapTitle.Text = "Mini Map"
miniMapTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
miniMapTitle.TextSize = 12
miniMapTitle.Font = Enum.Font.GothamBold
miniMapTitle.Parent = miniMap

-- ========== FUNCIONES EXPORTADAS ==========
_G.EditorEffects = {
	showNotification = showNotification,
	createSpawnEffect = createSpawnEffect,
	addHighlight = addHighlight,
	showToolIndicator = showToolIndicator,
	createSelectionRing = createSelectionRing,
	toggleGrid = function()
		visualGrid.Parent = visualGrid.Parent == workspace and nil or workspace
	end
}

print("Visual Effects cargado")
