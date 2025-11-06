-- HideWorld.lua
-- Oculta el mundo de Roblox y muestra solo la aplicación

local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")

local player = Players.LocalPlayer

-- Ocultar todos los elementos de Roblox
StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, false)

-- Ocultar el personaje del jugador
if player.Character then
	player.Character:Destroy()
end

player.CharacterAdded:Connect(function(character)
	character:Destroy()
end)

-- Desactivar controles del jugador
local controls = require(player.PlayerScripts:WaitForChild("PlayerModule")):GetControls()
controls:Disable()

-- Ocultar el mouse del juego
local UserInputService = game:GetService("UserInputService")
UserInputService.MouseIconEnabled = true

print("Mundo de Roblox oculto - Solo aplicación visible")
