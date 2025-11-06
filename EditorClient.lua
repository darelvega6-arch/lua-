-- EditorClient.lua
-- Sistema de cliente para controles táctiles y herramientas del editor

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local mouse = player:GetMouse()
local camera = workspace.CurrentCamera

local editorEvent = ReplicatedStorage:WaitForChild("EditorEvent")

-- Variables de estado
local currentTool = "Select"
local selectedPart = nil
local isDragging = false
local dragStart = nil

-- Configuración de cámara
camera.CameraType = Enum.CameraType.Custom
camera.CFrame = CFrame.new(Vector3.new(0, 50, 50), Vector3.new(0, 0, 0))

-- ========== SISTEMA DE SELECCIÓN ==========
local function selectPart(part)
	if part and part:IsA("BasePart") and part.Parent.Name == "EditorObjects" then
		selectedPart = part
		editorEvent:FireServer("select", {part = part})
		
		-- Actualizar panel de propiedades
		updateProperties(part)
		print("Seleccionado:", part.Name)
	end
end

-- ========== ACTUALIZAR PROPIEDADES ==========
function updateProperties(part)
	local playerGui = player:WaitForChild("PlayerGui")
	local editorUI = playerGui:WaitForChild("EditorStudio")
	local properties = editorUI:WaitForChild("Properties")
	local scroll = properties:FindFirstChild("ScrollingFrame")
	
	if scroll then
		-- Limpiar propiedades anteriores
		for _, child in pairs(scroll:GetChildren()) do
			if child:IsA("Frame") then
				child:Destroy()
			end
		end
		
		-- Crear propiedades
		local props = {
			{name = "Name", value = part.Name, type = "string"},
			{name = "Position", value = tostring(part.Position), type = "vector"},
			{name = "Size", value = tostring(part.Size), type = "vector"},
			{name = "Color", value = tostring(part.Color), type = "color"},
			{name = "Material", value = tostring(part.Material), type = "enum"},
			{name = "Transparency", value = tostring(part.Transparency), type = "number"},
		}
		
		for i, prop in ipairs(props) do
			local propFrame = Instance.new("Frame")
			propFrame.Size = UDim2.new(1, -10, 0, 30)
			propFrame.Position = UDim2.new(0, 5, 0, (i-1) * 35)
			propFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
			propFrame.BorderSizePixel = 0
			propFrame.Parent = scroll
			
			local propLabel = Instance.new("TextLabel")
			propLabel.Size = UDim2.new(0.4, 0, 1, 0)
			propLabel.BackgroundTransparency = 1
			propLabel.Text = prop.name
			propLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
			propLabel.TextSize = 12
			propLabel.Font = Enum.Font.Gotham
			propLabel.TextXAlignment = Enum.TextXAlignment.Left
			propLabel.Parent = propFrame
			
			local propValue = Instance.new("TextLabel")
			propValue.Size = UDim2.new(0.6, 0, 1, 0)
			propValue.Position = UDim2.new(0.4, 0, 0, 0)
			propValue.BackgroundTransparency = 1
			propValue.Text = prop.value
			propValue.TextColor3 = Color3.fromRGB(255, 255, 255)
			propValue.TextSize = 11
			propValue.Font = Enum.Font.Gotham
			propValue.TextXAlignment = Enum.TextXAlignment.Right
			propValue.TextTruncate = Enum.TextTruncate.AtEnd
			propValue.Parent = propFrame
		end
		
		scroll.CanvasSize = UDim2.new(0, 0, 0, #props * 35)
	end
end

-- ========== ACTUALIZAR EXPLORADOR ==========
local function updateExplorer()
	local playerGui = player:WaitForChild("PlayerGui")
	local editorUI = playerGui:WaitForChild("EditorStudio")
	local explorer = editorUI:WaitForChild("Explorer")
	local scroll = explorer:FindFirstChild("ScrollingFrame")
	
	if scroll then
		-- Limpiar explorador
		for _, child in pairs(scroll:GetChildren()) do
			if child:IsA("TextButton") then
				child:Destroy()
			end
		end
		
		-- Listar objetos en workspace
		local editorObjects = workspace:FindFirstChild("EditorObjects")
		if editorObjects then
			local objects = editorObjects:GetChildren()
			
			for i, obj in ipairs(objects) do
				local objBtn = Instance.new("TextButton")
				objBtn.Size = UDim2.new(1, -10, 0, 25)
				objBtn.Position = UDim2.new(0, 5, 0, (i-1) * 30)
				objBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
				objBtn.Text = "  " .. obj.Name
				objBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
				objBtn.TextSize = 12
				objBtn.Font = Enum.Font.Gotham
				objBtn.TextXAlignment = Enum.TextXAlignment.Left
				objBtn.Parent = scroll
				
				objBtn.MouseButton1Click:Connect(function()
					selectPart(obj)
				end)
			end
			
			scroll.CanvasSize = UDim2.new(0, 0, 0, #objects * 30)
		end
	end
end

-- Actualizar explorador cada 2 segundos
spawn(function()
	while wait(2) do
		updateExplorer()
	end
end)

-- ========== CONTROLES DE MOUSE ==========
mouse.Button1Down:Connect(function()
	local target = mouse.Target
	
	if currentTool == "Select" then
		selectPart(target)
		
	elseif currentTool == "Move" then
		if selectedPart then
			isDragging = true
			dragStart = mouse.Hit.Position
		end
		
	elseif currentTool == "Delete" then
		if target and target.Parent.Name == "EditorObjects" then
			editorEvent:FireServer("delete", {})
		end
		
	elseif currentTool == "Paint" then
		if target and target.Parent.Name == "EditorObjects" then
			local randomColor = Color3.fromRGB(math.random(0, 255), math.random(0, 255), math.random(0, 255))
			editorEvent:FireServer("paint", {color = randomColor})
		end
	end
end)

mouse.Button1Up:Connect(function()
	isDragging = false
end)

-- ========== MOVIMIENTO CON DRAG ==========
mouse.Move:Connect(function()
	if isDragging and selectedPart and currentTool == "Move" then
		local currentPos = mouse.Hit.Position
		if dragStart then
			local offset = currentPos - dragStart
			editorEvent:FireServer("move", {offset = offset})
			dragStart = currentPos
		end
	end
end)

-- ========== CONTROLES DE TECLADO ==========
UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	
	if input.KeyCode == Enum.KeyCode.Delete or input.KeyCode == Enum.KeyCode.X then
		editorEvent:FireServer("delete", {})
		
	elseif input.KeyCode == Enum.KeyCode.R then
		-- Rotar 45 grados
		editorEvent:FireServer("rotate", {rotation = Vector3.new(0, 45, 0)})
		
	elseif input.KeyCode == Enum.KeyCode.E then
		-- Escalar más grande
		editorEvent:FireServer("scale", {scale = 1.1})
		
	elseif input.KeyCode == Enum.KeyCode.Q then
		-- Escalar más pequeño
		editorEvent:FireServer("scale", {scale = 0.9})
		
	elseif input.KeyCode == Enum.KeyCode.C and UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
		-- Copiar
		editorEvent:FireServer("action", {action = "Copy"})
		
	elseif input.KeyCode == Enum.KeyCode.Z and UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
		-- Undo
		editorEvent:FireServer("action", {action = "Undo"})
		
	elseif input.KeyCode == Enum.KeyCode.Y and UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
		-- Redo
		editorEvent:FireServer("action", {action = "Redo"})
		
	elseif input.KeyCode == Enum.KeyCode.F5 then
		-- Play
		editorEvent:FireServer("action", {action = "Play"})
		
	elseif input.KeyCode == Enum.KeyCode.F6 then
		-- Stop
		editorEvent:FireServer("action", {action = "Stop"})
	end
end)

-- ========== CONTROLES TÁCTILES (MÓVIL) ==========
local touchStart = nil
local touchObject = nil

UserInputService.TouchStarted:Connect(function(touch, gameProcessed)
	if gameProcessed then return end
	
	touchStart = touch.Position
	local ray = camera:ScreenPointToRay(touch.Position.X, touch.Position.Y)
	local raycastParams = RaycastParams.new()
	raycastParams.FilterType = Enum.RaycastFilterType.Whitelist
	raycastParams.FilterDescendantsInstances = {workspace.EditorObjects}
	
	local result = workspace:Raycast(ray.Origin, ray.Direction * 1000, raycastParams)
	
	if result then
		touchObject = result.Instance
		selectPart(touchObject)
	end
end)

UserInputService.TouchMoved:Connect(function(touch, gameProcessed)
	if touchObject and currentTool == "Move" and touchStart then
		local delta = touch.Position - touchStart
		local offset = Vector3.new(delta.X * 0.01, 0, delta.Y * 0.01)
		editorEvent:FireServer("move", {offset = offset})
		touchStart = touch.Position
	end
end)

UserInputService.TouchEnded:Connect(function(touch, gameProcessed)
	touchStart = nil
	touchObject = nil
end)

-- ========== JOYSTICK MÓVIL ==========
local playerGui = player:WaitForChild("PlayerGui")
local editorUI = playerGui:WaitForChild("EditorStudio")
local mobileControls = editorUI:WaitForChild("MobileControls")
local joystick = mobileControls:WaitForChild("Joystick")
local knob = joystick:WaitForChild("Knob")

local joystickActive = false
local joystickInput = Vector2.new(0, 0)

joystick.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch then
		joystickActive = true
	end
end)

joystick.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch then
		joystickActive = false
		knob.Position = UDim2.new(0.5, -20, 0.5, -20)
		joystickInput = Vector2.new(0, 0)
	end
end)

joystick.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch and joystickActive then
		local center = joystick.AbsolutePosition + joystick.AbsoluteSize / 2
		local delta = Vector2.new(input.Position.X - center.X, input.Position.Y - center.Y)
		local distance = math.min(delta.Magnitude, 30)
		local direction = delta.Unit
		
		joystickInput = direction * (distance / 30)
		knob.Position = UDim2.new(0.5, direction.X * distance - 20, 0.5, direction.Y * distance - 20)
	end
end)

-- Mover cámara con joystick
game:GetService("RunService").RenderStepped:Connect(function()
	if joystickInput.Magnitude > 0.1 then
		local moveSpeed = 0.5
		camera.CFrame = camera.CFrame * CFrame.new(joystickInput.X * moveSpeed, 0, joystickInput.Y * moveSpeed)
	end
end)

print("Editor Client cargado completamente")
