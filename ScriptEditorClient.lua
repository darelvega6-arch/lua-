-- ScriptEditorClient.lua
-- Cliente para el editor de scripts

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local scriptEditor = playerGui:WaitForChild("ScriptEditor")

local scriptEvent = ReplicatedStorage:WaitForChild("ScriptEvent")

local codeBox = scriptEditor.CodeBox.CodeBox
local outputBox = scriptEditor.Properties.OutputBox.OutputBox
local explorerScroll = scriptEditor.Explorer.ScrollingFrame

local scripts = {}
local currentScript = nil

-- Actualizar explorador
local function updateExplorer()
	for _, child in pairs(explorerScroll:GetChildren()) do
		if child:IsA("TextButton") then
			child:Destroy()
		end
	end
	
	for i, script in ipairs(scripts) do
		local btn = Instance.new("TextButton")
		btn.Size = UDim2.new(1, -5, 0, 30)
		btn.Position = UDim2.new(0, 2, 0, (i-1) * 32)
		btn.BackgroundColor3 = script == currentScript and Color3.fromRGB(0, 120, 215) or Color3.fromRGB(40, 40, 40)
		btn.BorderSizePixel = 0
		btn.Text = script.name
		btn.TextColor3 = Color3.fromRGB(255, 255, 255)
		btn.TextSize = 12
		btn.Font = Enum.Font.Gotham
		btn.TextXAlignment = Enum.TextXAlignment.Left
		btn.Parent = explorerScroll
		
		local padding = Instance.new("UIPadding")
		padding.PaddingLeft = UDim.new(0, 10)
		padding.Parent = btn
		
		btn.MouseButton1Click:Connect(function()
			currentScript = script
			codeBox.Text = script.code
			scriptEditor.CodeBox.EditorTitle.ScriptName.Text = script.name
			updateExplorer()
		end)
	end
	
	explorerScroll.CanvasSize = UDim2.new(0, 0, 0, #scripts * 32)
end

-- Botones de la barra superior
local topBar = scriptEditor.TopBar

topBar.NewBtn.MouseButton1Click:Connect(function()
	local newScript = {
		name = "Script" .. (#scripts + 1) .. ".lua",
		code = "-- New Script\nprint('Hello from script " .. (#scripts + 1) .. "')",
		type = "LocalScript"
	}
	table.insert(scripts, newScript)
	currentScript = newScript
	codeBox.Text = newScript.code
	updateExplorer()
	outputBox.Text = "> New script created"
	outputBox.TextColor3 = Color3.fromRGB(0, 255, 100)
end)

topBar.RunBtn.MouseButton1Click:Connect(function()
	if currentScript then
		currentScript.code = codeBox.Text
		local scriptType = scriptEditor.Properties.TypeFrame.LocalBtn.BackgroundColor3 == Color3.fromRGB(0, 170, 255) and "LocalScript" or "ServerScript"
		
		scriptEvent:FireServer("run", {
			code = currentScript.code,
			scriptType = scriptType,
			name = currentScript.name
		})
		
		outputBox.Text = "> Running " .. currentScript.name .. "..."
		outputBox.TextColor3 = Color3.fromRGB(255, 200, 0)
	else
		outputBox.Text = "> Error: No script selected"
		outputBox.TextColor3 = Color3.fromRGB(255, 50, 50)
	end
end)

topBar.StopBtn.MouseButton1Click:Connect(function()
	scriptEvent:FireServer("stop", {})
	outputBox.Text = "> Stopped"
	outputBox.TextColor3 = Color3.fromRGB(255, 100, 100)
end)

topBar.SaveBtn.MouseButton1Click:Connect(function()
	if currentScript then
		currentScript.code = codeBox.Text
		scriptEvent:FireServer("save", {
			name = currentScript.name,
			code = currentScript.code
		})
		outputBox.Text = "> Saved " .. currentScript.name
		outputBox.TextColor3 = Color3.fromRGB(0, 255, 100)
	end
end)

topBar.PublishBtn.MouseButton1Click:Connect(function()
	if currentScript then
		currentScript.code = codeBox.Text
		scriptEvent:FireServer("publish", {
			name = currentScript.name,
			code = currentScript.code,
			author = player.Name
		})
		outputBox.Text = "> Publishing " .. currentScript.name .. "..."
		outputBox.TextColor3 = Color3.fromRGB(150, 0, 255)
	end
end)

-- Recibir mensajes del servidor
scriptEvent.OnClientEvent:Connect(function(action, data)
	if action == "output" then
		outputBox.Text = "> " .. data.message
		outputBox.TextColor3 = data.success and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(255, 50, 50)
	elseif action == "published" then
		outputBox.Text = "> Published successfully! ID: " .. data.id
		outputBox.TextColor3 = Color3.fromRGB(150, 0, 255)
	end
end)

-- Crear script inicial
local initialScript = {
	name = "MainScript.lua",
	code = "-- Main Script\nprint('Welcome to Script Editor!')\n\n-- Create a part\nlocal part = Instance.new('Part')\npart.Size = Vector3.new(4, 4, 4)\npart.Position = Vector3.new(0, 10, 0)\npart.BrickColor = BrickColor.Random()\npart.Parent = workspace",
	type = "LocalScript"
}
table.insert(scripts, initialScript)
currentScript = initialScript
codeBox.Text = initialScript.code
updateExplorer()

print("Script Editor Client cargado")
