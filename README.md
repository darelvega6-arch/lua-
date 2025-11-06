# 🎮 Roblox Studio Mobile - Editor Completo

Editor de juegos estilo Roblox Studio optimizado para dispositivos móviles.

## 📋 Características

### 🛠️ Herramientas Principales
- **Select (🔍)**: Seleccionar objetos en el workspace
- **Move (✋)**: Mover objetos con drag & drop
- **Scale (📏)**: Cambiar tamaño de objetos (Q/E)
- **Rotate (🔄)**: Rotar objetos (R = 45°)
- **Paint (🎨)**: Cambiar colores con paleta
- **Delete (🗑️)**: Eliminar objetos (X o Delete)

### 📦 Tipos de Partes
- Block (Cubo)
- Sphere (Esfera)
- Cylinder (Cilindro)
- Wedge (Cuña)
- Spawn (Punto de aparición)
- Model (Modelo personalizado)

### 🎨 Paneles de UI
1. **Barra Superior**: Título y controles principales
2. **Toolbar**: Herramientas de edición
3. **Parts Panel**: Crear diferentes tipos de partes
4. **Explorer**: Ver jerarquía de objetos
5. **Properties**: Editar propiedades del objeto seleccionado
6. **Mobile Controls**: Joystick y botones de acción

### 🎯 Controles

#### Teclado (PC)
- `C`: Crear bloque
- `X` / `Delete`: Eliminar objeto
- `R`: Rotar 45°
- `E`: Escalar más grande
- `Q`: Escalar más pequeño
- `Ctrl+C`: Copiar objeto
- `Ctrl+Z`: Deshacer
- `Ctrl+Y`: Rehacer
- `F5`: Modo Play
- `F6`: Modo Stop

#### Táctil (Móvil)
- **Tap**: Seleccionar objeto
- **Drag**: Mover objeto (con herramienta Move)
- **Joystick**: Mover cámara
- **Botones de acción**: Undo, Redo, Copy, Play, Stop, Save

### ⚙️ Funcionalidades Avanzadas
- ✅ Sistema de Grid con snap automático
- ✅ Undo/Redo completo
- ✅ Selector de colores (12 colores)
- ✅ Selector de materiales (19 materiales)
- ✅ SelectionBox visual para objetos seleccionados
- ✅ Panel de propiedades dinámico
- ✅ Explorador actualizado en tiempo real
- ✅ Sistema de duplicación de objetos
- ✅ Baseplate de 512x512

## 📁 Estructura de Archivos

```
EditorUI.lua          - Interfaz completa del editor
EditorServer.lua      - Lógica del servidor
EditorClient.lua      - Controles y interacción del cliente
ColorPicker.lua       - Selector de colores
MaterialPicker.lua    - Selector de materiales
Localscript.lua       - Script local original (legacy)
Serverscript.lua      - Script servidor original (legacy)
```

## 🚀 Instalación

### En Roblox Studio:
1. Crea un nuevo lugar
2. Inserta un **LocalScript** en `StarterPlayer.StarterPlayerScripts`
3. Copia el contenido de `EditorUI.lua`
4. Inserta otro **LocalScript** y copia `EditorClient.lua`
5. Inserta otro **LocalScript** y copia `ColorPicker.lua`
6. Inserta otro **LocalScript** y copia `MaterialPicker.lua`
7. Inserta un **Script** en `ServerScriptService`
8. Copia el contenido de `EditorServer.lua`

### Configuración:
- El sistema crea automáticamente el RemoteEvent en ReplicatedStorage
- Se crea una carpeta "EditorObjects" en Workspace
- Se genera un Baseplate automáticamente

## 🎨 Personalización

### Cambiar tamaño del Grid:
```lua
editorEvent:FireServer("setGridSize", {size = 4})
```

### Activar/Desactivar Grid:
```lua
editorEvent:FireServer("toggleGrid", {})
```

### Crear parte personalizada:
```lua
editorEvent:FireServer("createPart", {
    partType = "Block",
    position = Vector3.new(0, 10, 0)
})
```

## 🔧 Próximas Funcionalidades
- [ ] Sistema de guardado/carga de proyectos
- [ ] Importar modelos desde biblioteca
- [ ] Herramienta de terreno
- [ ] Sistema de scripting integrado
- [ ] Modo colaborativo multijugador
- [ ] Exportar a archivo .rbxl
- [ ] Animaciones y tweening
- [ ] Sistema de iluminación avanzado

## 📱 Optimización Móvil
- Interfaz responsive para pantallas pequeñas
- Controles táctiles optimizados
- Joystick virtual para navegación
- Botones grandes y accesibles
- Paneles colapsables

## 🐛 Solución de Problemas

**El UI no aparece:**
- Verifica que EditorUI.lua esté en StarterPlayerScripts
- Asegúrate de que sea un LocalScript

**No puedo crear objetos:**
- Verifica que EditorServer.lua esté en ServerScriptService
- Revisa que el RemoteEvent esté en ReplicatedStorage

**Los controles táctiles no funcionan:**
- Asegúrate de que EditorClient.lua esté cargado
- Verifica que UserInputService esté habilitado

## 📄 Licencia
Proyecto educativo - Libre uso y modificación

## 👨‍💻 Autor
Creado para desarrollo de juegos móviles estilo Roblox Studio
