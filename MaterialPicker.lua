-- MaterialPicker.lua
-- Sistema para cambiar materiales de las partes

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local editorUI = playerGui:WaitForChild("EditorStudio")

-- Crear panel de material picker
local materialPicker = Instance.new("Frame")
materialPicker.Name = "MaterialPicker"
materialPicker.Size = UDim2.new(0, 200, 0, 350)
materialPicker.Position = UDim2.new(0.5, -100, 0.5, -175)
materialPicker.BackgroundColor3 = Color3.fromRGB(46, 46, 46)
materialPicker.BorderSizePixel = 0
materialPicker.Visible = false
materialPicker.ZIndex = 10
materialPicker.Parent = editorUI

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = materialPicker

-- Título
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
title.Text = "Materials"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 18
title.Font = Enum.Font.GothamBold
title.Parent = materialPicker

-- Scroll para materiales
local scroll = Instance.new("ScrollingFrame")
scroll.Size = UDim2.new(1, -10, 1, -50)
scroll.Position = UDim2.new(0, 5, 0, 45)
scroll.BackgroundTransparency = 1
scroll.BorderSizePixel = 0
scroll.ScrollBarThickness = 6
scroll.Parent = materialPicker

-- Lista de materiales
local materials = {
	"Plastic", "SmoothPlastic", "Neon", "Metal", "Wood", 
	"WoodPlanks", "Marble", "Granite", "Brick", "Concrete",
	"CorrodedMetal", "DiamondPlate", "Foil", "Grass", "Ice",
	"Sand", "Fabric", "Glass", "ForceField"
}

for i, material in ipairs(materials) do
	local matBtn = Instance.new("TextButton")
	matBtn.Size = UDim2.new(1, -10, 0, 35)
	matBtn.Position = UDim2.new(0, 5, 0, (i-1) * 40)
	matBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
	matBtn.Text = material
	matBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	matBtn.TextSize = 14
	matBtn.Font = Enum.Font.Gotham
	matBtn.Parent = scroll
	
	local btnCorner = Instance.new("UICorner")
	btnCorner.CornerRadius = UDim.new(0, 6)
	btnCorner.Parent = matBtn
	
	matBtn.MouseButton1Click:Connect(function()
		ReplicatedStorage.EditorEvent:FireServer("setMaterial", {material = material})
		materialPicker.Visible = false
	end)
end

scroll.CanvasSize = UDim2.new(0, 0, 0, #materials * 40)

-- Botón para abrir material picker
local matBtn = Instance.new("TextButton")
matBtn.Name = "MaterialBtn"
matBtn.Size = UDim2.new(0, 70, 0, 80)
matBtn.Position = UDim2.new(0, 580, 1, -90)
matBtn.BackgroundColor3 = Color3.fromRGB(255, 170, 0)
matBtn.Text = "Material"
matBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
matBtn.TextSize = 14
matBtn.Font = Enum.Font.GothamBold
local playerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")
local editorUI = playerGui:WaitForChild("EditorStudio")
local mobileControls = editorUI:WaitForChild("MobileControls")
matBtn.Parent = mobileControls

local matCorner = Instance.new("UICorner")
matCorner.CornerRadius = UDim.new(0, 6)
matCorner.Parent = matBtn

matBtn.MouseButton1Click:Connect(function()
	materialPicker.Visible = not materialPicker.Visible
end)

print("Material Picker cargado")
