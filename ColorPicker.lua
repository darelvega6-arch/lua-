-- ColorPicker.lua
-- Sistema de selector de colores para la herramienta Paint

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local editorUI = playerGui:WaitForChild("EditorStudio")

-- Crear panel de color picker
local colorPicker = Instance.new("Frame")
colorPicker.Name = "ColorPicker"
colorPicker.Size = UDim2.new(0, 250, 0, 250)
colorPicker.Position = UDim2.new(0.5, -125, 0.5, -125)
colorPicker.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
colorPicker.BorderSizePixel = 0
colorPicker.Visible = false
colorPicker.ZIndex = 10
colorPicker.Parent = editorUI

-- Título
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
title.BorderSizePixel = 0
title.Text = "Colors"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 14
title.Font = Enum.Font.GothamBold
title.Parent = colorPicker

-- Paleta de colores predefinidos
local colors = {
	Color3.fromRGB(255, 0, 0),     -- Rojo
	Color3.fromRGB(255, 127, 0),   -- Naranja
	Color3.fromRGB(255, 255, 0),   -- Amarillo
	Color3.fromRGB(0, 255, 0),     -- Verde
	Color3.fromRGB(0, 255, 255),   -- Cyan
	Color3.fromRGB(0, 0, 255),     -- Azul
	Color3.fromRGB(127, 0, 255),   -- Púrpura
	Color3.fromRGB(255, 0, 255),   -- Magenta
	Color3.fromRGB(255, 255, 255), -- Blanco
	Color3.fromRGB(200, 200, 200), -- Gris claro
	Color3.fromRGB(100, 100, 100), -- Gris
	Color3.fromRGB(0, 0, 0),       -- Negro
}

local selectedColor = Color3.fromRGB(255, 255, 255)

for i, color in ipairs(colors) do
	local row = math.floor((i-1) / 4)
	local col = (i-1) % 4
	
	local colorBtn = Instance.new("TextButton")
	colorBtn.Size = UDim2.new(0, 50, 0, 50)
	colorBtn.Position = UDim2.new(0, 15 + col * 55, 0, 40 + row * 55)
	colorBtn.BackgroundColor3 = color
	colorBtn.Text = ""
	colorBtn.BorderSizePixel = 1
	colorBtn.BorderColor3 = Color3.fromRGB(60, 60, 60)
	colorBtn.Parent = colorPicker
	
	colorBtn.MouseButton1Click:Connect(function()
		selectedColor = color
		ReplicatedStorage.EditorEvent:FireServer("paint", {color = color})
		colorPicker.Visible = false
	end)
end

-- Botón de cerrar
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 30, 0, 25)
closeBtn.Position = UDim2.new(1, -35, 0, 2)
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
closeBtn.BorderSizePixel = 0
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextSize = 14
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Parent = colorPicker

closeBtn.MouseButton1Click:Connect(function()
	colorPicker.Visible = false
end)

-- Mostrar color picker cuando se selecciona Paint
local toolbar = editorUI:WaitForChild("Toolbar")
local paintBtn = toolbar:FindFirstChild("PaintBtn")

if paintBtn then
	paintBtn.MouseButton1Click:Connect(function()
		colorPicker.Visible = not colorPicker.Visible
	end)
end

print("Color Picker cargado")
