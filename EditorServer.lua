-- EditorServer.lua
-- Sistema completo de servidor para editor estilo Roblox Studio

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Carpeta para objetos del editor
local editorFolder = Instance.new("Folder")
editorFolder.Name = "EditorObjects"
editorFolder.Parent = workspace

-- Evento remoto
local editorEvent = Instance.new("RemoteEvent")
editorEvent.Name = "EditorEvent"
editorEvent.Parent = ReplicatedStorage

-- Sistema de Grid
local gridEnabled = true
local gridSize = 2

-- Tabla para almacenar objetos seleccionados por jugador
local selectedObjects = {}

-- Función para crear diferentes tipos de partes
local function createPart(partType, position)
	local part
	
	if partType == "Block" then
		part = Instance.new("Part")
		part.Shape = Enum.PartType.Block
		part.Size = Vector3.new(4, 4, 4)
		
	elseif partType == "Sphere" then
		part = Instance.new("Part")
		part.Shape = Enum.PartType.Ball
		part.Size = Vector3.new(4, 4, 4)
		
	elseif partType == "Cylinder" then
		part = Instance.new("Part")
		part.Shape = Enum.PartType.Cylinder
		part.Size = Vector3.new(4, 4, 4)
		
	elseif partType == "Wedge" then
		part = Instance.new("WedgePart")
		part.Size = Vector3.new(4, 4, 4)
		
	elseif partType == "Spawn" then
		part = Instance.new("SpawnLocation")
		part.Size = Vector3.new(6, 1, 6)
		part.Transparency = 0.5
		
	elseif partType == "Model" then
		local model = Instance.new("Model")
		model.Name = "CustomModel"
		part = Instance.new("Part")
		part.Size = Vector3.new(4, 4, 4)
		part.Parent = model
		model.PrimaryPart = part
		model.Parent = editorFolder
		return model
	else
		part = Instance.new("Part")
		part.Size = Vector3.new(4, 4, 4)
	end
	
	part.Anchored = true
	part.Position = position or Vector3.new(0, 10, 0)
	part.Color = Color3.fromRGB(math.random(100, 255), math.random(100, 255), math.random(100, 255))
	part.Material = Enum.Material.SmoothPlastic
	part.TopSurface = Enum.SurfaceType.Smooth
	part.BottomSurface = Enum.SurfaceType.Smooth
	
	-- Añadir SelectionBox para visualización
	local selectionBox = Instance.new("SelectionBox")
	selectionBox.Name = "SelectionBox"
	selectionBox.Adornee = part
	selectionBox.LineThickness = 0.05
	selectionBox.Color3 = Color3.fromRGB(0, 162, 255)
	selectionBox.Visible = false
	selectionBox.Parent = part
	
	part.Parent = editorFolder
	return part
end

-- Función para snap al grid
local function snapToGrid(position)
	if not gridEnabled then return position end
	return Vector3.new(
		math.floor(position.X / gridSize + 0.5) * gridSize,
		math.floor(position.Y / gridSize + 0.5) * gridSize,
		math.floor(position.Z / gridSize + 0.5) * gridSize
	)
end

-- Función para mover objeto
local function movePart(part, offset)
	if part then
		local newPos = part.Position + offset
		part.Position = snapToGrid(newPos)
	end
end

-- Función para escalar objeto
local function scalePart(part, scale)
	if part then
		part.Size = part.Size * scale
	end
end

-- Función para rotar objeto
local function rotatePart(part, rotation)
	if part then
		part.CFrame = part.CFrame * CFrame.Angles(math.rad(rotation.X), math.rad(rotation.Y), math.rad(rotation.Z))
	end
end

-- Función para pintar objeto
local function paintPart(part, color)
	if part then
		part.Color = color
	end
end

-- Función para duplicar objeto
local function duplicatePart(part)
	if part then
		local clone = part:Clone()
		clone.Position = part.Position + Vector3.new(5, 0, 0)
		clone.Parent = editorFolder
		return clone
	end
end

-- Sistema de Undo/Redo
local undoStack = {}
local redoStack = {}

local function addToUndo(action)
	table.insert(undoStack, action)
	redoStack = {} -- Limpiar redo al hacer nueva acción
end

-- Manejo de eventos del cliente
editorEvent.OnServerEvent:Connect(function(player, action, data)
	
	if action == "createPart" then
		local partType = data.partType or "Block"
		local position = data.position or Vector3.new(0, 10, 0)
		local part = createPart(partType, snapToGrid(position))
		
		addToUndo({
			action = "create",
			part = part
		})
		
		print(player.Name .. " creó un " .. partType)
		
	elseif action == "select" then
		local part = data.part
		if part and part:IsA("BasePart") then
			-- Deseleccionar anterior
			if selectedObjects[player.UserId] then
				local oldPart = selectedObjects[player.UserId]
				if oldPart:FindFirstChild("SelectionBox") then
					oldPart.SelectionBox.Visible = false
				end
			end
			
			-- Seleccionar nuevo
			selectedObjects[player.UserId] = part
			if part:FindFirstChild("SelectionBox") then
				part.SelectionBox.Visible = true
			end
		end
		
	elseif action == "move" then
		local part = selectedObjects[player.UserId]
		local offset = data.offset or Vector3.new(0, 0, 0)
		movePart(part, offset)
		
	elseif action == "scale" then
		local part = selectedObjects[player.UserId]
		local scale = data.scale or 1.1
		scalePart(part, scale)
		
	elseif action == "rotate" then
		local part = selectedObjects[player.UserId]
		local rotation = data.rotation or Vector3.new(0, 45, 0)
		rotatePart(part, rotation)
		
	elseif action == "paint" then
		local part = selectedObjects[player.UserId]
		local color = data.color or Color3.fromRGB(255, 255, 255)
		paintPart(part, color)
		
	elseif action == "delete" then
		local part = selectedObjects[player.UserId]
		if part then
			addToUndo({
				action = "delete",
				part = part:Clone(),
				position = part.Position
			})
			part:Destroy()
			selectedObjects[player.UserId] = nil
		end
		
	elseif action == "action" then
		local actionType = data.action
		
		if actionType == "Undo" then
			if #undoStack > 0 then
				local lastAction = table.remove(undoStack)
				table.insert(redoStack, lastAction)
				
				if lastAction.action == "create" then
					lastAction.part:Destroy()
				elseif lastAction.action == "delete" then
					lastAction.part.Parent = editorFolder
				end
			end
			
		elseif actionType == "Redo" then
			if #redoStack > 0 then
				local lastAction = table.remove(redoStack)
				table.insert(undoStack, lastAction)
				
				if lastAction.action == "create" then
					lastAction.part.Parent = editorFolder
				elseif lastAction.action == "delete" then
					lastAction.part:Destroy()
				end
			end
			
		elseif actionType == "Copy" then
			local part = selectedObjects[player.UserId]
			if part then
				local clone = duplicatePart(part)
				selectedObjects[player.UserId] = clone
			end
			
		elseif actionType == "Play" then
			print("Modo Play activado")
			-- Aquí puedes implementar lógica para probar el juego
			
		elseif actionType == "Stop" then
			print("Modo Stop activado")
			
		elseif actionType == "Save" then
			print("Guardando proyecto...")
			-- Implementar sistema de guardado
		end
		
	elseif action == "toggleGrid" then
		gridEnabled = not gridEnabled
		print("Grid:", gridEnabled and "Activado" or "Desactivado")
		
	elseif action == "setGridSize" then
		gridSize = data.size or 2
		print("Grid size:", gridSize)
		
	elseif action == "setMaterial" then
		local part = selectedObjects[player.UserId]
		if part then
			local materialName = data.material
			local material = Enum.Material[materialName]
			if material then
				part.Material = material
				print(player.Name .. " cambió material a " .. materialName)
			end
		end
	end
end)

-- Crear plano base
local basePlate = Instance.new("Part")
basePlate.Name = "Baseplate"
basePlate.Size = Vector3.new(512, 1, 512)
basePlate.Position = Vector3.new(0, 0, 0)
basePlate.Anchored = true
basePlate.Color = Color3.fromRGB(100, 100, 100)
basePlate.Material = Enum.Material.Grass
basePlate.Locked = true
basePlate.Parent = workspace

print("Editor Server cargado completamente")
