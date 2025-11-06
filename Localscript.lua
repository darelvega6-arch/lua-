-- EditorLocal
-- Controla las teclas del jugador y comunica acciones al servidor

local ServerScriptService = game:GetService("ServerScriptService")
local RemoteEvent = ServerScriptService:WaitForChild("EditorEvent")

local player = game.Players.LocalPlayer
local mouse = player:GetMouse()

-- Crear bloque con la tecla C
mouse.KeyDown:Connect(function(key)
	if key == "c" then
		RemoteEvent:FireServer("create", {position = Vector3.new(0, 5, 0)})
	end
end)

-- Mover bloque con teclas de dirección
mouse.KeyDown:Connect(function(key)
	local moveDistance = 2
	local currentBlock

	for _, part in pairs(workspace.EditorObjects:GetChildren()) do
		if part.Name == player.Name .. "_Block" then
			currentBlock = part
		end
	end

	if currentBlock then
		local pos = currentBlock.Position
		if key == "w" then pos += Vector3.new(0, 0, -moveDistance)
		elseif key == "s" then pos += Vector3.new(0, 0, moveDistance)
		elseif key == "a" then pos += Vector3.new(-moveDistance, 0, 0)
		elseif key == "d" then pos += Vector3.new(moveDistance, 0, 0)
		end
		RemoteEvent:FireServer("move", {position = pos})
	end
end)

-- Eliminar bloque con la tecla X
mouse.KeyDown:Connect(function(key)
	if key == "x" then
		RemoteEvent:FireServer("delete", {})
	end
end)
