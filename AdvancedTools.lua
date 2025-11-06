-- AdvancedTools.lua
-- Herramientas avanzadas adicionales para el editor

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local editorUI = playerGui:WaitForChild("EditorStudio")

-- ========== MENÚ DE HERRAMIENTAS AVANZADAS ==========
local advancedMenu = Instance.new("Frame")
advancedMenu.Name = "AdvancedMenu"
advancedMenu.Size = UDim2.new(0, 180, 0, 400)
advancedMenu.Position = UDim2.new(0, 140, 0, 120)
advancedMenu.BackgroundColor3 = Color3.fromRGB(46, 46, 46)
advancedMenu.BorderSizePixel = 0
advancedMenu.Visible = false
advancedMenu.Parent = editorUI

local advCorner = Instance.new("UICorner")
advCorner.CornerRadius = UDim.new(0, 10)
advCorner.Parent = advancedMenu

local advTitle = Instance.new("TextLabel")
advTitle.Size = UDim2.new(1, 0, 0, 35)
advTitle.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
advTitle.Text = "Advanced Tools"
advTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
advTitle.TextSize = 16
advTitle.Font = Enum.Font.GothamBold
advTitle.Parent = advancedMenu

-- Herramientas avanzadas
local advancedTools = {
	{name = "Terrain", icon = "🏔️", desc = "Editor de terreno"},
	{name = "Lighting", icon = "💡", desc = "Configurar iluminación"},
	{name = "Effects", icon = "✨", desc = "Efectos especiales"},
	{name = "Physics", icon = "⚛️", desc = "Propiedades físicas"},
	{name = "Constraints", icon = "🔗", desc = "Restricciones"},
	{name = "Particles", icon = "🎆", desc = "Sistema de partículas"},
	{name = "Sounds", icon = "🔊", desc = "Audio y sonidos"},
	{name = "Scripts", icon = "📜", desc = "Editor de scripts"},
}

for i, tool in ipairs(advancedTools) do
	local toolFrame = Instance.new("Frame")
	toolFrame.Size = UDim2.new(1, -10, 0, 40)
	toolFrame.Position = UDim2.new(0, 5, 0, 40 + (i-1) * 45)
	toolFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
	toolFrame.Parent = advancedMenu
	
	local frameCorner = Instance.new("UICorner")
	frameCorner.CornerRadius = UDim.new(0, 6)
	frameCorner.Parent = toolFrame
	
	local toolBtn = Instance.new("TextButton")
	toolBtn.Size = UDim2.new(1, 0, 1, 0)
	toolBtn.BackgroundTransparency = 1
	toolBtn.Text = tool.icon .. " " .. tool.name
	toolBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	toolBtn.TextSize = 14
	toolBtn.Font = Enum.Font.Gotham
	toolBtn.TextXAlignment = Enum.TextXAlignment.Left
	toolBtn.Parent = toolFrame
	
	local padding = Instance.new("UIPadding")
	padding.PaddingLeft = UDim.new(0, 10)
	padding.Parent = toolBtn
	
	toolBtn.MouseButton1Click:Connect(function()
		print("Herramienta avanzada:", tool.name)
		ReplicatedStorage.EditorEvent:FireServer("advancedTool", {tool = tool.name})
	end)
end

-- Botón para abrir menú avanzado
local advBtn = Instance.new("TextButton")
advBtn.Name = "AdvancedBtn"
advBtn.Size = UDim2.new(0, 60, 0, 60)
advBtn.Position = UDim2.new(1, -70, 1, -340)
advBtn.BackgroundColor3 = Color3.fromRGB(127, 0, 255)
advBtn.Text = "⚙️\nAdv"
advBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
advBtn.TextSize = 14
advBtn.Font = Enum.Font.GothamBold
advBtn.Parent = editorUI

local advBtnCorner = Instance.new("UICorner")
advBtnCorner.CornerRadius = UDim.new(1, 0)
advBtnCorner.Parent = advBtn

advBtn.MouseButton1Click:Connect(function()
	advancedMenu.Visible = not advancedMenu.Visible
end)

-- ========== PANEL DE CONFIGURACIÓN ==========
local settingsPanel = Instance.new("Frame")
settingsPanel.Name = "SettingsPanel"
settingsPanel.Size = UDim2.new(0, 300, 0, 400)
settingsPanel.Position = UDim2.new(0.5, -150, 0.5, -200)
settingsPanel.BackgroundColor3 = Color3.fromRGB(46, 46, 46)
settingsPanel.BorderSizePixel = 0
settingsPanel.Visible = false
settingsPanel.ZIndex = 10
settingsPanel.Parent = editorUI

local settingsCorner = Instance.new("UICorner")
settingsCorner.CornerRadius = UDim.new(0, 10)
settingsCorner.Parent = settingsPanel

local settingsTitle = Instance.new("TextLabel")
settingsTitle.Size = UDim2.new(1, 0, 0, 40)
settingsTitle.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
settingsTitle.Text = "⚙️ Settings"
settingsTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
settingsTitle.TextSize = 18
settingsTitle.Font = Enum.Font.GothamBold
settingsTitle.Parent = settingsPanel

-- Configuraciones
local settings = {
	{name = "Grid Size", values = {"1", "2", "4", "8"}, default = "2"},
	{name = "Camera Speed", values = {"Slow", "Normal", "Fast"}, default = "Normal"},
	{name = "Auto Save", values = {"On", "Off"}, default = "On"},
	{name = "Show Grid", values = {"On", "Off"}, default = "On"},
}

for i, setting in ipairs(settings) do
	local settingFrame = Instance.new("Frame")
	settingFrame.Size = UDim2.new(1, -20, 0, 60)
	settingFrame.Position = UDim2.new(0, 10, 0, 50 + (i-1) * 70)
	settingFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
	settingFrame.Parent = settingsPanel
	
	local settingCorner = Instance.new("UICorner")
	settingCorner.CornerRadius = UDim.new(0, 8)
	settingCorner.Parent = settingFrame
	
	local settingLabel = Instance.new("TextLabel")
	settingLabel.Size = UDim2.new(1, -10, 0, 25)
	settingLabel.Position = UDim2.new(0, 5, 0, 5)
	settingLabel.BackgroundTransparency = 1
	settingLabel.Text = setting.name
	settingLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
	settingLabel.TextSize = 14
	settingLabel.Font = Enum.Font.Gotham
	settingLabel.TextXAlignment = Enum.TextXAlignment.Left
	settingLabel.Parent = settingFrame
	
	-- Botones de opciones
	for j, value in ipairs(setting.values) do
		local optionBtn = Instance.new("TextButton")
		optionBtn.Size = UDim2.new(0, 60, 0, 25)
		optionBtn.Position = UDim2.new(0, 5 + (j-1) * 65, 0, 30)
		optionBtn.BackgroundColor3 = value == setting.default and Color3.fromRGB(0, 162, 255) or Color3.fromRGB(80, 80, 80)
		optionBtn.Text = value
		optionBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
		optionBtn.TextSize = 12
		optionBtn.Font = Enum.Font.Gotham
		optionBtn.Parent = settingFrame
		
		local optionCorner = Instance.new("UICorner")
		optionCorner.CornerRadius = UDim.new(0, 6)
		optionCorner.Parent = optionBtn
		
		optionBtn.MouseButton1Click:Connect(function()
			-- Actualizar visual
			for _, child in pairs(settingFrame:GetChildren()) do
				if child:IsA("TextButton") then
					child.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
				end
			end
			optionBtn.BackgroundColor3 = Color3.fromRGB(0, 162, 255)
			
			-- Enviar al servidor
			ReplicatedStorage.EditorEvent:FireServer("changeSetting", {
				setting = setting.name,
				value = value
			})
		end)
	end
end

-- Botón cerrar settings
local closeSettingsBtn = Instance.new("TextButton")
closeSettingsBtn.Size = UDim2.new(1, -20, 0, 40)
closeSettingsBtn.Position = UDim2.new(0, 10, 1, -50)
closeSettingsBtn.BackgroundColor3 = Color3.fromRGB(0, 162, 255)
closeSettingsBtn.Text = "Close"
closeSettingsBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeSettingsBtn.TextSize = 16
closeSettingsBtn.Font = Enum.Font.GothamBold
closeSettingsBtn.Parent = settingsPanel

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 8)
closeCorner.Parent = closeSettingsBtn

closeSettingsBtn.MouseButton1Click:Connect(function()
	settingsPanel.Visible = false
end)

-- Botón de settings en barra superior
local topBar = editorUI:WaitForChild("TopBar")
local settingsBtn = Instance.new("TextButton")
settingsBtn.Size = UDim2.new(0, 40, 0, 40)
settingsBtn.Position = UDim2.new(1, -50, 0, 5)
settingsBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
settingsBtn.Text = "⚙️"
settingsBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
settingsBtn.TextSize = 20
settingsBtn.Font = Enum.Font.Gotham
settingsBtn.Parent = topBar

local settingsBtnCorner = Instance.new("UICorner")
settingsBtnCorner.CornerRadius = UDim.new(0, 8)
settingsBtnCorner.Parent = settingsBtn

settingsBtn.MouseButton1Click:Connect(function()
	settingsPanel.Visible = not settingsPanel.Visible
end)

-- ========== HERRAMIENTA DE MEDICIÓN ==========
local measureTool = Instance.new("TextButton")
measureTool.Name = "MeasureBtn"
measureTool.Size = UDim2.new(0, 60, 0, 60)
measureTool.Position = UDim2.new(1, -70, 1, -410)
measureTool.BackgroundColor3 = Color3.fromRGB(255, 200, 0)
measureTool.Text = "📐\nMeas"
measureTool.TextColor3 = Color3.fromRGB(255, 255, 255)
measureTool.TextSize = 14
measureTool.Font = Enum.Font.GothamBold
measureTool.Parent = editorUI

local measureCorner = Instance.new("UICorner")
measureCorner.CornerRadius = UDim.new(1, 0)
measureCorner.Parent = measureTool

measureTool.MouseButton1Click:Connect(function()
	print("Herramienta de medición activada")
	ReplicatedStorage.EditorEvent:FireServer("toggleMeasure", {})
end)

-- ========== SNAP TO OBJECT ==========
local snapBtn = Instance.new("TextButton")
snapBtn.Name = "SnapBtn"
snapBtn.Size = UDim2.new(0, 60, 0, 60)
snapBtn.Position = UDim2.new(1, -70, 1, -480)
snapBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 127)
snapBtn.Text = "🧲\nSnap"
snapBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
snapBtn.TextSize = 14
snapBtn.Font = Enum.Font.GothamBold
snapBtn.Parent = editorUI

local snapCorner = Instance.new("UICorner")
snapCorner.CornerRadius = UDim.new(1, 0)
snapCorner.Parent = snapBtn

snapBtn.MouseButton1Click:Connect(function()
	print("Snap to object activado")
	ReplicatedStorage.EditorEvent:FireServer("toggleSnap", {})
end)

print("Advanced Tools cargado")
