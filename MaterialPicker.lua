-- MaterialPicker.lua
-- Sistema para cambiar materiales de las partes

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local editorUI = playerGui:WaitForChild("EditorStudio")

local materialPicker = Instance.new("Frame")
materialPicker.Name = "MaterialPicker"
materialPicker.Size = UDim2.new(0, 200, 0, 300)
materialPicker.Position = UDim2.new(0.5, -100, 0.5, -150)
materialPicker.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
materialPicker.BorderSizePixel = 0
materialPicker.Visible = false
materialPicker.ZIndex = 10
materialPicker.Parent = editorUI

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
title.BorderSizePixel = 0
title.Text = "Materials"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 14
title.Font = Enum.Font.GothamBold
title.Parent = materialPicker

local scroll = Instance.new("ScrollingFrame")
scroll.Size = UDim2.new(1, 0, 1, -30)
scroll.Position = UDim2.new(0, 0, 0, 30)
scroll.BackgroundTransparency = 1
scroll.BorderSizePixel = 0
scroll.ScrollBarThickness = 4
scroll.Parent = materialPicker

local materials = {
	"Plastic", "SmoothPlastic", "Neon", "Metal", "Wood", 
	"Brick", "Concrete", "Grass", "Glass"
}

for i, material in ipairs(materials) do
	local matBtn = Instance.new("TextButton")
	matBtn.Size = UDim2.new(1, 0, 0, 30)
	matBtn.Position = UDim2.new(0, 0, 0, (i-1) * 30)
	matBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
	matBtn.BorderSizePixel = 0
	matBtn.Text = material
	matBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	matBtn.TextSize = 13
	matBtn.Font = Enum.Font.Gotham
	matBtn.Parent = scroll
	
	matBtn.MouseButton1Click:Connect(function()
		ReplicatedStorage.EditorEvent:FireServer("setMaterial", {material = material})
		materialPicker.Visible = false
	end)
end

scroll.CanvasSize = UDim2.new(0, 0, 0, #materials * 30)

local mobileControls = editorUI:WaitForChild("MobileControls")

local matBtn = Instance.new("TextButton")
matBtn.Name = "MaterialBtn"
matBtn.Size = UDim2.new(0, 70, 0, 80)
matBtn.Position = UDim2.new(0, 580, 0, 10)
matBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
matBtn.BorderSizePixel = 0
matBtn.Text = "Material"
matBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
matBtn.TextSize = 14
matBtn.Font = Enum.Font.GothamBold
matBtn.Parent = mobileControls

matBtn.MouseButton1Click:Connect(function()
	materialPicker.Visible = not materialPicker.Visible
end)

print("Material Picker cargado")
