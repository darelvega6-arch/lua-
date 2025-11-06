# 📱 GUÍA DE INSTALACIÓN - Roblox Studio Mobile

## 🎯 Resumen del Proyecto

Has recibido un **editor completo estilo Roblox Studio** optimizado para móviles con:

### ✨ Características Principales:
- ✅ **6 Herramientas**: Select, Move, Scale, Rotate, Paint, Delete
- ✅ **6 Tipos de Partes**: Block, Sphere, Cylinder, Wedge, Spawn, Model
- ✅ **Panel de Propiedades** dinámico
- ✅ **Explorador** de objetos en tiempo real
- ✅ **Selector de Colores** (12 colores)
- ✅ **Selector de Materiales** (19 materiales)
- ✅ **Herramientas Avanzadas** (Terrain, Lighting, Effects, etc.)
- ✅ **Efectos Visuales** y animaciones
- ✅ **Controles Táctiles** optimizados
- ✅ **Sistema Undo/Redo**
- ✅ **Grid con Snap**

---

## 📦 ARCHIVOS CREADOS

### 🔵 Scripts del Cliente (LocalScript)
1. **EditorUI.lua** - Interfaz principal
2. **EditorClient.lua** - Controles y interacción
3. **ColorPicker.lua** - Selector de colores
4. **MaterialPicker.lua** - Selector de materiales
5. **AdvancedTools.lua** - Herramientas avanzadas
6. **VisualEffects.lua** - Efectos y animaciones

### 🔴 Scripts del Servidor (Script)
7. **EditorServer.lua** - Lógica del servidor

### 📄 Documentación
8. **README.md** - Documentación completa
9. **GUIA_INSTALACION.md** - Esta guía

---

## 🚀 INSTALACIÓN PASO A PASO

### Opción 1: Instalación Completa (Recomendada)

#### En Roblox Studio:

**PASO 1: Preparar el Servidor**
```
1. Abre Roblox Studio
2. Crea un nuevo lugar (File > New)
3. Ve a ServerScriptService
4. Inserta un Script (botón +)
5. Copia TODO el contenido de EditorServer.lua
6. Pega en el Script
7. Renombra el script a "EditorServer"
```

**PASO 2: Preparar los Scripts del Cliente**
```
1. Ve a StarterPlayer > StarterPlayerScripts
2. Inserta un LocalScript
3. Copia el contenido de EditorUI.lua
4. Renombra a "EditorUI"

5. Inserta otro LocalScript
6. Copia el contenido de EditorClient.lua
7. Renombra a "EditorClient"

8. Inserta otro LocalScript
9. Copia el contenido de ColorPicker.lua
10. Renombra a "ColorPicker"

11. Inserta otro LocalScript
12. Copia el contenido de MaterialPicker.lua
13. Renombra a "MaterialPicker"

14. Inserta otro LocalScript
15. Copia el contenido de AdvancedTools.lua
16. Renombra a "AdvancedTools"

17. Inserta otro LocalScript
18. Copia el contenido de VisualEffects.lua
19. Renombra a "VisualEffects"
```

**PASO 3: Configurar ReplicatedStorage**
```
1. Ve a ReplicatedStorage
2. El sistema creará automáticamente el RemoteEvent "EditorEvent"
3. Si no se crea, inserta manualmente un RemoteEvent
4. Nómbralo "EditorEvent"
```

**PASO 4: Probar**
```
1. Presiona F5 o el botón Play
2. Deberías ver la interfaz completa del editor
3. Prueba crear objetos desde el panel de Parts
4. Prueba las herramientas de la toolbar
```

---

### Opción 2: Instalación Mínima (Solo lo esencial)

Si quieres empezar con lo básico:

**Scripts Mínimos Necesarios:**
1. EditorServer.lua (en ServerScriptService)
2. EditorUI.lua (en StarterPlayerScripts)
3. EditorClient.lua (en StarterPlayerScripts)

**Luego puedes añadir:**
- ColorPicker.lua (para colores)
- MaterialPicker.lua (para materiales)
- AdvancedTools.lua (herramientas extra)
- VisualEffects.lua (efectos visuales)

---

## 🎮 CÓMO USAR EL EDITOR

### Crear Objetos:
1. Haz clic en el panel "Parts" (izquierda)
2. Selecciona el tipo de parte (Block, Sphere, etc.)
3. El objeto aparecerá en el workspace

### Seleccionar Objetos:
1. Activa la herramienta "Select" (🔍)
2. Haz clic en cualquier objeto en el workspace
3. Verás sus propiedades en el panel derecho

### Mover Objetos:
1. Selecciona un objeto
2. Activa la herramienta "Move" (✋)
3. Arrastra el objeto con el mouse/touch

### Cambiar Color:
1. Selecciona un objeto
2. Activa la herramienta "Paint" (🎨)
3. Elige un color de la paleta

### Cambiar Material:
1. Selecciona un objeto
2. Haz clic en el botón "Mat" (🎭)
3. Elige un material de la lista

### Rotar/Escalar:
- **Rotar**: Presiona R (45° cada vez)
- **Escalar +**: Presiona E
- **Escalar -**: Presiona Q

### Eliminar:
1. Selecciona un objeto
2. Presiona X o Delete
3. O activa la herramienta Delete (🗑️)

---

## 📱 CONTROLES MÓVILES

### Joystick (Inferior Izquierda):
- Mueve la cámara por el mundo

### Botones de Acción:
- **Undo (↶)**: Deshacer última acción
- **Redo (↷)**: Rehacer acción
- **Copy (📋)**: Duplicar objeto seleccionado
- **Play (▶️)**: Modo prueba
- **Stop (⏹️)**: Detener prueba
- **Save (💾)**: Guardar proyecto

### Botones Flotantes:
- **Grid (⊞)**: Activar/desactivar grid
- **Mat (🎭)**: Selector de materiales
- **Adv (⚙️)**: Herramientas avanzadas
- **Meas (📐)**: Herramienta de medición
- **Snap (🧲)**: Snap a objetos

---

## 🎨 PERSONALIZACIÓN

### Cambiar Colores de la UI:
En EditorUI.lua, busca:
```lua
BackgroundColor3 = Color3.fromRGB(46, 46, 46)
```
Y cambia los valores RGB.

### Cambiar Tamaño del Grid:
En EditorServer.lua, busca:
```lua
local gridSize = 2
```
Y cambia el valor (1, 2, 4, 8, etc.)

### Añadir Más Colores:
En ColorPicker.lua, añade a la tabla `colors`:
```lua
Color3.fromRGB(TU_R, TU_G, TU_B),
```

### Añadir Más Materiales:
En MaterialPicker.lua, añade a la tabla `materials`:
```lua
"NombreDelMaterial",
```

---

## 🐛 SOLUCIÓN DE PROBLEMAS

### ❌ "El UI no aparece"
**Solución:**
- Verifica que EditorUI.lua esté en StarterPlayerScripts
- Asegúrate de que sea un LocalScript (no Script)
- Revisa la consola de Output para errores

### ❌ "No puedo crear objetos"
**Solución:**
- Verifica que EditorServer.lua esté en ServerScriptService
- Asegúrate de que sea un Script (no LocalScript)
- Verifica que exista el RemoteEvent en ReplicatedStorage

### ❌ "Los botones no funcionan"
**Solución:**
- Asegúrate de que EditorClient.lua esté cargado
- Verifica que el RemoteEvent se llame exactamente "EditorEvent"
- Revisa la consola para errores

### ❌ "Error: EditorEvent not found"
**Solución:**
1. Ve a ReplicatedStorage
2. Inserta un RemoteEvent
3. Nómbralo exactamente "EditorEvent"

### ❌ "Los controles táctiles no funcionan"
**Solución:**
- Prueba en un dispositivo móvil real o emulador
- En Studio, activa el modo de emulación móvil
- Verifica que UserInputService esté habilitado

---

## 📊 ESTRUCTURA DEL PROYECTO

```
Workspace
├── EditorObjects (Folder) - Se crea automáticamente
├── Baseplate (Part) - Se crea automáticamente
└── VisualGrid (Folder) - Grid visual opcional

ReplicatedStorage
└── EditorEvent (RemoteEvent) - Comunicación cliente-servidor

ServerScriptService
└── EditorServer (Script) - Lógica del servidor

StarterPlayer
└── StarterPlayerScripts
    ├── EditorUI (LocalScript)
    ├── EditorClient (LocalScript)
    ├── ColorPicker (LocalScript)
    ├── MaterialPicker (LocalScript)
    ├── AdvancedTools (LocalScript)
    └── VisualEffects (LocalScript)
```

---

## 🎯 PRÓXIMOS PASOS

Una vez instalado, puedes:

1. **Personalizar la UI** con tus colores favoritos
2. **Añadir más tipos de partes** en EditorServer.lua
3. **Crear herramientas personalizadas** en AdvancedTools.lua
4. **Implementar sistema de guardado** para proyectos
5. **Añadir más efectos visuales** en VisualEffects.lua
6. **Crear un sistema de scripting** integrado
7. **Implementar modo colaborativo** multijugador

---

## 💡 TIPS Y TRUCOS

### Para Desarrolladores:
- Usa `print()` para debug en la consola
- Revisa Output para ver mensajes del sistema
- Usa F9 para abrir el Developer Console
- Ctrl+Z funciona para Undo

### Para Diseñadores:
- Experimenta con diferentes materiales
- Combina colores para crear paletas
- Usa el grid para alinear objetos perfectamente
- Duplica objetos con Copy para trabajar más rápido

### Para Móviles:
- Usa dos dedos para rotar la cámara
- Pellizca para hacer zoom
- Mantén presionado para seleccionar
- Usa el joystick para moverte rápido

---

## 📞 SOPORTE

Si tienes problemas:
1. Revisa esta guía completa
2. Verifica la consola de Output (F9)
3. Asegúrate de que todos los scripts estén en el lugar correcto
4. Verifica que los nombres sean exactos (mayúsculas/minúsculas)

---

## 🎉 ¡LISTO!

Ahora tienes un editor completo estilo Roblox Studio para móviles.

**¡Diviértete creando!** 🚀
