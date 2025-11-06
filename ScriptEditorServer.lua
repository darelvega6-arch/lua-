-- ScriptEditorServer.lua
-- Servidor para ejecutar y gestionar scripts

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local DataStoreService = game:GetService("DataStoreService")

local scriptEvent = Instance.new("RemoteEvent")
scriptEvent.Name = "ScriptEvent"
scriptEvent.Parent = ReplicatedStorage

local publishedApps = DataStoreService:GetDataStore("PublishedApps")
local runningScripts = {}

-- Ejecutar script
local function executeScript(code, scriptType, player)
	local success, err = pcall(function()
		if scriptType == "ServerScript" then
			-- Ejecutar en servidor
			local func, loadErr = loadstring(code)
			if func then
				func()
			else
				error(loadErr)
			end
		else
			-- Ejecutar en cliente
			local script = Instance.new("LocalScript")
			script.Name = "DynamicScript_" .. player.Name
			script.Source = code
			script.Parent = player.PlayerGui
			table.insert(runningScripts, script)
		end
	end)
	
	return success, err
end

-- Detener scripts
local function stopAllScripts()
	for _, script in pairs(runningScripts) do
		if script and script.Parent then
			script:Destroy()
		end
	end
	runningScripts = {}
end

-- Manejar eventos
scriptEvent.OnServerEvent:Connect(function(player, action, data)
	
	if action == "run" then
		local success, err = executeScript(data.code, data.scriptType, player)
		
		if success then
			scriptEvent:FireClient(player, "output", {
				message = "Script executed successfully!",
				success = true
			})
		else
			scriptEvent:FireClient(player, "output", {
				message = "Error: " .. tostring(err),
				success = false
			})
		end
		
	elseif action == "stop" then
		stopAllScripts()
		scriptEvent:FireClient(player, "output", {
			message = "All scripts stopped",
			success = true
		})
		
	elseif action == "save" then
		-- Guardar localmente (en el servidor)
		print(player.Name .. " saved script: " .. data.name)
		scriptEvent:FireClient(player, "output", {
			message = "Script saved locally",
			success = true
		})
		
	elseif action == "publish" then
		-- Publicar aplicación
		local appId = player.UserId .. "_" .. os.time()
		local appData = {
			name = data.name,
			code = data.code,
			author = data.author,
			timestamp = os.time(),
			downloads = 0
		}
		
		local success, err = pcall(function()
			publishedApps:SetAsync(appId, appData)
		end)
		
		if success then
			scriptEvent:FireClient(player, "published", {
				id = appId,
				success = true
			})
			print(player.Name .. " published app: " .. data.name .. " (ID: " .. appId .. ")")
		else
			scriptEvent:FireClient(player, "output", {
				message = "Failed to publish: " .. tostring(err),
				success = false
			})
		end
	end
end)

-- Limpiar scripts cuando jugador sale
Players.PlayerRemoving:Connect(function(player)
	for i = #runningScripts, 1, -1 do
		local script = runningScripts[i]
		if script and script.Name:find(player.Name) then
			script:Destroy()
			table.remove(runningScripts, i)
		end
	end
end)

print("Script Editor Server cargado")
