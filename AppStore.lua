-- AppStore.lua
-- Tienda de aplicaciones publicadas

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local DataStoreService = game:GetService("DataStoreService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local publishedApps = DataStoreService:GetDataStore("PublishedApps")
local scriptEvent = ReplicatedStorage:WaitForChild("ScriptEvent")

-- UI de la tienda
local storeGui = Instance.new("ScreenGui")
storeGui.Name = "AppStore"
storeGui.ResetOnSpawn = false
storeGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
storeGui.Parent = playerGui

-- Botón para abrir tienda
local openBtn = Instance.new("TextButton")
openBtn.Size = UDim2.new(0, 100, 0, 40)
openBtn.Position = UDim2.new(1, -110, 0, 45)
openBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 255)
openBtn.BorderSizePixel = 0
openBtn.Text = "App Store"
openBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
openBtn.TextSize = 14
openBtn.Font = Enum.Font.GothamBold
openBtn.Parent = storeGui

-- Panel de la tienda
local storePanel = Instance.new("Frame")
storePanel.Size = UDim2.new(0, 600, 0, 500)
storePanel.Position = UDim2.new(0.5, -300, 0.5, -250)
storePanel.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
storePanel.BorderSizePixel = 0
storePanel.Visible = false
storePanel.Parent = storeGui

local storeTitle = Instance.new("TextLabel")
storeTitle.Size = UDim2.new(1, 0, 0, 40)
storeTitle.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
storeTitle.BorderSizePixel = 0
storeTitle.Text = "App Store - Published Applications"
storeTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
storeTitle.TextSize = 16
storeTitle.Font = Enum.Font.GothamBold
storeTitle.Parent = storePanel

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 5)
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
closeBtn.BorderSizePixel = 0
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextSize = 14
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Parent = storePanel

local appsScroll = Instance.new("ScrollingFrame")
appsScroll.Size = UDim2.new(1, -10, 1, -50)
appsScroll.Position = UDim2.new(0, 5, 0, 45)
appsScroll.BackgroundTransparency = 1
appsScroll.BorderSizePixel = 0
appsScroll.ScrollBarThickness = 6
appsScroll.Parent = storePanel

-- Cargar aplicaciones
local function loadApps()
	for _, child in pairs(appsScroll:GetChildren()) do
		if child:IsA("Frame") then
			child:Destroy()
		end
	end
	
	-- Simulación de apps (en producción se cargarían del DataStore)
	local apps = {
		{name = "Rainbow Part Creator", author = "Player1", downloads = 45},
		{name = "Auto Builder", author = "Player2", downloads = 32},
		{name = "Particle Effects", author = "Player3", downloads = 28},
		{name = "Music Player", author = "Player4", downloads = 19},
		{name = "Teleporter System", author = "Player5", downloads = 15},
	}
	
	for i, app in ipairs(apps) do
		local appFrame = Instance.new("Frame")
		appFrame.Size = UDim2.new(1, -10, 0, 80)
		appFrame.Position = UDim2.new(0, 5, 0, (i-1) * 85)
		appFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
		appFrame.BorderSizePixel = 0
		appFrame.Parent = appsScroll
		
		local appName = Instance.new("TextLabel")
		appName.Size = UDim2.new(1, -100, 0, 25)
		appName.Position = UDim2.new(0, 10, 0, 5)
		appName.BackgroundTransparency = 1
		appName.Text = app.name
		appName.TextColor3 = Color3.fromRGB(255, 255, 255)
		appName.TextSize = 15
		appName.Font = Enum.Font.GothamBold
		appName.TextXAlignment = Enum.TextXAlignment.Left
		appName.Parent = appFrame
		
		local appAuthor = Instance.new("TextLabel")
		appAuthor.Size = UDim2.new(1, -100, 0, 20)
		appAuthor.Position = UDim2.new(0, 10, 0, 28)
		appAuthor.BackgroundTransparency = 1
		appAuthor.Text = "by " .. app.author
		appAuthor.TextColor3 = Color3.fromRGB(150, 150, 150)
		appAuthor.TextSize = 12
		appAuthor.Font = Enum.Font.Gotham
		appAuthor.TextXAlignment = Enum.TextXAlignment.Left
		appAuthor.Parent = appFrame
		
		local appDownloads = Instance.new("TextLabel")
		appDownloads.Size = UDim2.new(1, -100, 0, 20)
		appDownloads.Position = UDim2.new(0, 10, 0, 50)
		appDownloads.BackgroundTransparency = 1
		appDownloads.Text = app.downloads .. " downloads"
		appDownloads.TextColor3 = Color3.fromRGB(100, 200, 255)
		appDownloads.TextSize = 11
		appDownloads.Font = Enum.Font.Gotham
		appDownloads.TextXAlignment = Enum.TextXAlignment.Left
		appDownloads.Parent = appFrame
		
		local installBtn = Instance.new("TextButton")
		installBtn.Size = UDim2.new(0, 80, 0, 30)
		installBtn.Position = UDim2.new(1, -90, 0, 25)
		installBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
		installBtn.BorderSizePixel = 0
		installBtn.Text = "Install"
		installBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
		installBtn.TextSize = 13
		installBtn.Font = Enum.Font.GothamBold
		installBtn.Parent = appFrame
		
		installBtn.MouseButton1Click:Connect(function()
			installBtn.Text = "Installed"
			installBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
			print("Installed app:", app.name)
		end)
	end
	
	appsScroll.CanvasSize = UDim2.new(0, 0, 0, #apps * 85)
end

openBtn.MouseButton1Click:Connect(function()
	storePanel.Visible = not storePanel.Visible
	if storePanel.Visible then
		loadApps()
	end
end)

closeBtn.MouseButton1Click:Connect(function()
	storePanel.Visible = false
end)

print("App Store cargado")
