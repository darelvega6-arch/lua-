# 💻 Lua Script Editor - Roblox Studio Style

Editor de scripts Lua completo donde los usuarios pueden crear, ejecutar y publicar aplicaciones.

## 🎯 Características

### ✨ Editor de Scripts
- **Editor de código** con syntax highlighting
- **LocalScript** y **ServerScript** support
- **Explorador** de scripts
- **Panel de propiedades**
- **Output** en tiempo real
- **Múltiples scripts** en un proyecto

### 🚀 Funcionalidades
- ✅ Crear nuevos scripts
- ✅ Ejecutar scripts (Run)
- ✅ Detener ejecución (Stop)
- ✅ Guardar scripts
- ✅ Publicar aplicaciones
- ✅ App Store integrada

### 📱 App Store
- Ver aplicaciones publicadas
- Instalar apps de otros usuarios
- Sistema de downloads
- Información de autor

## 📁 Estructura de Archivos

```
ScriptEditorUI.lua       - Interfaz del editor
ScriptEditorClient.lua   - Lógica del cliente
ScriptEditorServer.lua   - Servidor que ejecuta scripts
AppStore.lua             - Tienda de aplicaciones
```

## 🚀 Instalación

### En Roblox Studio:

**PASO 1: Scripts del Cliente**
```
1. Ve a StarterPlayer > StarterPlayerScripts
2. Inserta un LocalScript
3. Copia el contenido de ScriptEditorUI.lua
4. Renombra a "ScriptEditorUI"

5. Inserta otro LocalScript
6. Copia el contenido de ScriptEditorClient.lua
7. Renombra a "ScriptEditorClient"

8. Inserta otro LocalScript
9. Copia el contenido de AppStore.lua
10. Renombra a "AppStore"
```

**PASO 2: Script del Servidor**
```
1. Ve a ServerScriptService
2. Inserta un Script
3. Copia el contenido de ScriptEditorServer.lua
4. Renombra a "ScriptEditorServer"
```

**PASO 3: Configurar DataStore**
```
1. Ve a Game Settings > Security
2. Activa "Enable Studio Access to API Services"
3. Esto permite guardar aplicaciones publicadas
```

## 🎮 Cómo Usar

### Crear un Script:
1. Haz clic en "New" en la barra superior
2. Se creará un nuevo script en el explorador
3. Escribe tu código Lua en el editor

### Ejecutar un Script:
1. Selecciona el script en el explorador
2. Elige el tipo: LocalScript o ServerScript
3. Haz clic en "Run"
4. Verás el output en el panel de propiedades

### Publicar una Aplicación:
1. Escribe tu código
2. Haz clic en "Publish"
3. Tu app se guardará en el App Store
4. Otros usuarios podrán instalarla

### Usar el App Store:
1. Haz clic en "App Store" (botón superior derecho)
2. Navega por las aplicaciones publicadas
3. Haz clic en "Install" para descargar una app
4. La app se ejecutará automáticamente

## 💡 Ejemplos de Código

### Crear una Parte:
```lua
local part = Instance.new("Part")
part.Size = Vector3.new(4, 4, 4)
part.Position = Vector3.new(0, 10, 0)
part.BrickColor = BrickColor.Random()
part.Parent = workspace
```

### Crear Múltiples Partes:
```lua
for i = 1, 10 do
    local part = Instance.new("Part")
    part.Size = Vector3.new(2, 2, 2)
    part.Position = Vector3.new(i * 3, 5, 0)
    part.BrickColor = BrickColor.Random()
    part.Parent = workspace
    wait(0.1)
end
```

### Crear un GUI:
```lua
local gui = Instance.new("ScreenGui")
gui.Parent = game.Players.LocalPlayer.PlayerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 200, 0, 100)
frame.Position = UDim2.new(0.5, -100, 0.5, -50)
frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
frame.Parent = gui

local label = Instance.new("TextLabel")
label.Size = UDim2.new(1, 0, 1, 0)
label.Text = "Hello World!"
label.TextColor3 = Color3.fromRGB(255, 255, 255)
label.TextSize = 20
label.Parent = frame
```

## 🎨 Interfaz

### Barra Superior:
- **New**: Crear nuevo script
- **Run**: Ejecutar script actual
- **Stop**: Detener todos los scripts
- **Save**: Guardar script
- **Publish**: Publicar aplicación

### Panel Izquierdo (Explorador):
- Lista de todos tus scripts
- Haz clic para seleccionar y editar

### Panel Central (Editor):
- Editor de código con múltiples líneas
- Muestra el nombre del script actual
- Indica el tipo (LocalScript/ServerScript)

### Panel Derecho (Propiedades):
- **Script Type**: Cambiar entre Local y Server
- **Output**: Ver resultados y errores

## 🔧 Tipos de Scripts

### LocalScript:
- Se ejecuta en el cliente (jugador)
- Tiene acceso a PlayerGui
- Ideal para interfaces y efectos locales

### ServerScript:
- Se ejecuta en el servidor
- Tiene acceso completo al workspace
- Ideal para lógica de juego y datos

## 📊 Sistema de Publicación

Cuando publicas una aplicación:
1. Se guarda en DataStore
2. Se le asigna un ID único
3. Aparece en el App Store
4. Otros jugadores pueden instalarla
5. Se registran las descargas

## 🐛 Solución de Problemas

**El editor no aparece:**
- Verifica que ScriptEditorUI.lua esté en StarterPlayerScripts
- Asegúrate de que sea un LocalScript

**Los scripts no se ejecutan:**
- Verifica que ScriptEditorServer.lua esté en ServerScriptService
- Revisa que el RemoteEvent "ScriptEvent" exista en ReplicatedStorage

**No puedo publicar:**
- Activa "Enable Studio Access to API Services" en Game Settings
- Verifica que DataStore esté habilitado

**Error en el Output:**
- Revisa tu código Lua
- Verifica que la sintaxis sea correcta
- Usa print() para debug

## 🎯 Casos de Uso

### Para Desarrolladores:
- Crear prototipos rápidos
- Probar código sin reiniciar
- Compartir scripts con otros
- Aprender Lua programando

### Para Creadores:
- Publicar mini-juegos
- Crear herramientas útiles
- Compartir efectos visuales
- Construir una biblioteca de código

### Para Jugadores:
- Descargar aplicaciones
- Personalizar su experiencia
- Aprender viendo código de otros
- Crear sus propias apps

## 🚀 Próximas Funcionalidades

- [ ] Syntax highlighting avanzado
- [ ] Autocompletado de código
- [ ] Sistema de versiones
- [ ] Comentarios y ratings en apps
- [ ] Categorías en App Store
- [ ] Búsqueda de aplicaciones
- [ ] Favoritos y colecciones
- [ ] Modo colaborativo

## 📄 Licencia

Proyecto educativo - Libre uso y modificación

## 👨‍💻 Autor

Editor de scripts estilo Roblox Studio para crear y compartir aplicaciones
