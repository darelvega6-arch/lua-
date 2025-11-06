-- EditorServer
-- Controla la creación, movimiento y eliminación de partes en el editor de juegos

local Players = game:GetService("Players")

-- Carpeta donde se guardan los bloques
local editorFolder = Instance.new("Folder")
editorFolder.Name = "EditorObjects"
editorFolder.Parent = workspace

-- Evento remoto automático (sin ReplicatedStorage)
local RemoteEvent = Instance.new("RemoteEvent")
RemoteEvent.Name = "EditorEvent"
RemoteEvent.Parent = game:GetService("ServerScriptService")

-- Cuando el cliente envía una acción (crear, mover o eliminar)
RemoteEvent.OnServerEvent:Connect(function(player, action, data)
	if action == "create" then
		local part = Instance.new("Part")
		part.Size = Vector3.new(4, 1, 4)
		part.Anchored = true
		part.Position = data.position
		part.Color = Color3.fromRGB(math.random(100,255), math.random(100,255), math.random(100,255))
		part.Name = player.Name .. "_Block"
		part.Parent = editorFolder

	elseif action == "move" then
		for _, part in pairs(editorFolder:GetChildren()) do
			if part.Name == player.Name .. "_Block" then
				part.Position = data.position
			end
		end

	elseif action == "delete" then
		for _, part in pairs(editorFolder:GetChildren()) do
			if part.Name == player.Name .. "_Block" then
				part:Destroy()
			end
		end
	end
end)
