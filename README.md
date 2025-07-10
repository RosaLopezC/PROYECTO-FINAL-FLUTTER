# 📱 Gestor de Tareas Pro

Una aplicación móvil completa desarrollada en **Flutter** que combina un sistema CRUD de gestión de tareas con el consumo de APIs públicas en tiempo real. Diseñada con una interfaz moderna, animaciones profesionales y completamente en español.

## 🌟 Características Principales

### ✨ **Gestión Completa de Tareas (CRUD)**
- ➕ **Crear** nuevas tareas con título, descripción y prioridad
- 📖 **Leer** y visualizar todas las tareas organizadamente
- ✏️ **Actualizar** tareas existentes con edición completa
- 🗑️ **Eliminar** tareas con confirmación de seguridad
- ✅ **Marcar como completadas** con seguimiento de tiempo

### 🌐 **Integración de APIs Públicas**
- 🌤️ **Clima en tiempo real** - Información meteorológica de Lima
- 💭 **Citas motivacionales** - Frases inspiradoras en español
- 🔄 **Datos de respaldo** - Fallback automático si las APIs fallan

### 🎨 **Diseño y Experiencia de Usuario**
- 🎭 **Animaciones suaves** con flutter_staggered_animations
- 🌈 **Gradientes modernos** azul-púrpura
- 📱 **Diseño responsive** que se adapta a cualquier pantalla
- 🇪🇸 **Interfaz 100% en español** con localización completa
- ⚡ **Estados de carga** y feedback visual inmediato

## 🛠️ Tecnologías Utilizadas

### **Framework y Lenguaje**
- **Flutter 3.29.3** - Framework de desarrollo multiplataforma
- **Dart 3.7.2** - Lenguaje de programación

### **Base de Datos**
- **SQLite** (sqflite ^2.3.0) - Base de datos local embebida
- **Persistencia automática** de datos

### **APIs Consumidas**
1. **OpenWeatherMap API** - `https://api.openweathermap.org/data/2.5/weather`
   - Temperatura, humedad, descripción del clima
2. **FraseDelDia API** - `https://frasedeldia.azurewebsites.net/api/phrase`
   - Citas motivacionales en español

### **Dependencias Principales**
```yaml
# UI y Diseño
google_fonts: ^6.1.0              # Tipografía Poppins
flutter_staggered_animations: ^1.1.1  # Animaciones escalonadas
flutter_animate: ^4.2.0+1         # Animaciones adicionales

# Base de Datos
sqflite: ^2.3.0                   # SQLite para Flutter
path: ^1.8.3                      # Manejo de rutas

# Red y APIs
http: ^1.1.0                      # Cliente HTTP

# Internacionalización
intl: ^0.19.0                     # Formateo de fechas en español
flutter_localizations: sdk        # Soporte de localización
```

## 📁 Estructura del Proyecto

```
lib/
├── main.dart                     # Punto de entrada de la aplicación
├── models/                       # Modelos de datos
│   ├── task.dart                # Modelo de tarea
│   ├── weather.dart             # Modelo de clima
│   └── quote.dart               # Modelo de cita
├── services/                     # Servicios y lógica de negocio
│   ├── database_service.dart    # Servicio de base de datos SQLite
│   ├── weather_service.dart     # Servicio API del clima
│   └── quote_service.dart       # Servicio API de citas
├── screens/                      # Pantallas de la aplicación
│   ├── home_screen.dart         # Pantalla principal
│   ├── add_task_screen.dart     # Crear/editar tareas
│   └── task_detail_screen.dart  # Detalles de tarea
├── widgets/                      # Componentes reutilizables
│   ├── task_card.dart           # Tarjeta de tarea
│   ├── weather_widget.dart      # Widget del clima
│   └── quote_widget.dart        # Widget de citas
└── utils/
    └── constants.dart           # Constantes de la aplicación
```

## 🚀 Instalación y Configuración

### **Prerrequisitos**
- Flutter SDK 3.10.0 o superior
- Dart SDK 3.7.2 o superior
- Android Studio / VS Code
- Dispositivo Android o emulador

### **Pasos de Instalación**

1. **Clonar el repositorio**
```bash
git clone https://github.com/RosaLopezC/PROYECTO-FINAL-FLUTTER.git
cd PROYECTO-FINAL-FLUTTER
```

2. **Instalar dependencias**
```bash
flutter pub get
```

3. **Configurar permisos de Android**
En `android/app/src/main/AndroidManifest.xml`, agregar:
```xml
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
```

4. **Ejecutar la aplicación**
```bash
# Ver dispositivos disponibles
flutter devices

# Ejecutar en dispositivo específico
flutter run -d [DEVICE_ID]

# O simplemente
flutter run
```

## 📱 Funcionalidades Detalladas

### **🏠 Pantalla Principal**
- Lista de todas las tareas con animaciones de entrada
- Widget del clima mostrando temperatura y condiciones de Lima
- Widget de cita motivacional que se actualiza
- Contador de tareas totales
- Botón flotante para agregar nuevas tareas

### **➕ Crear/Editar Tareas**
- Formulario validado con campos obligatorios
- Selector visual de prioridad (Baja, Media, Alta)
- Descripciones de ayuda para cada nivel de prioridad
- Animaciones de entrada suaves
- Feedback de éxito/error

### **📋 Detalles de Tarea**
- Vista completa con gradiente dinámico según prioridad
- Cronología con fechas de creación y completado
- Estadísticas de duración y estado
- Botones de acción: completar, editar, eliminar
- Confirmación de eliminación con preview

### **🎨 Sistema de Prioridades**
- **🟢 BAJA**: Tareas que se pueden hacer cuando hay tiempo libre
- **🟡 MEDIA**: Tareas que deberían completarse pronto  
- **🔴 ALTA**: Tareas que necesitan atención inmediata

## 🎯 Características Técnicas

### **Base de Datos SQLite**
- Tabla `tasks` con campos: id, title, description, createdAt, completedAt, isCompleted, priority
- Operaciones CRUD completas
- Consultas optimizadas con índices

### **Manejo de Errores**
- Try-catch en todas las operaciones de red
- Fallback automático para APIs
- Validación de formularios
- Mensajes de error amigables

### **Rendimiento**
- Lazy loading de imágenes
- Animaciones optimizadas (60 FPS)
- Consultas de base de datos eficientes
- Caché automático de datos

### **Internacionalización**
- Soporte completo para español
- Formateo de fechas localizado
- Números y monedas en formato local

## 🏗️ Arquitectura

### **Patrón de Arquitectura**
- **MVC (Model-View-Controller)** modificado para Flutter
- **Separación de responsabilidades** clara
- **Servicios independientes** para cada funcionalidad

### **Flujo de Datos**
```
Usuario → UI (Screens/Widgets) → Services → Database/APIs → UI
```

### **Gestión de Estado**
- **setState()** para estado local simple
- **StatefulWidget** para componentes con estado
- **FutureBuilder** para operaciones asíncronas

## 📸 Capturas de Pantalla

### 🏠 Pantalla Principal
- Lista de tareas con diseño moderno
- Widget del clima con información en tiempo real
- Citas motivacionales en español

### ➕ Crear Nueva Tarea
- Formulario elegante con validación
- Selector de prioridad visual
- Animaciones de entrada suaves

### 📋 Detalles de Tarea
- Vista completa con estadísticas
- Cronología detallada
- Acciones rápidas (editar, eliminar, completar)

## 🧪 Testing

### **Ejecutar Tests**
```bash
# Tests unitarios
flutter test

# Tests de widget
flutter test test/widget_test.dart
```

### **Cobertura de Tests**
- Modelos de datos
- Servicios de base de datos
- Servicios de APIs
- Widgets principales

## 🚀 Build y Deployment

### **Build para Android**
```bash
# Debug APK
flutter build apk --debug

# Release APK
flutter build apk --release

# App Bundle para Google Play Store
flutter build appbundle --release
```

## 📝 Próximas Funcionalidades

- [ ] 🔔 **Notificaciones push** para recordatorios
- [ ] 📊 **Dashboard con estadísticas** de productividad
- [ ] 🏷️ **Sistema de etiquetas** y categorías
- [ ] 🔄 **Sincronización en la nube** (Firebase)
- [ ] 🌙 **Modo oscuro** completo
- [ ] 🎯 **Metas y objetivos** semanales/mensuales
- [ ] 📅 **Calendario integrado** con vista semanal
- [ ] 🤝 **Colaboración** y tareas compartidas

## 🐛 Problemas Conocidos

- ⚠️ **Warning de overflow** en modo debug (no afecta funcionamiento)
- 🌐 **Dependencia de internet** para APIs (con fallback incluido)
- 📱 **Optimizado para Android** (iOS requiere testing adicional)

## 🤝 Contribuciones

Las contribuciones son bienvenidas. Por favor:

1. **Fork** el proyecto
2. **Crear** una rama para tu feature (`git checkout -b feature/nueva-funcionalidad`)
3. **Commit** tus cambios (`git commit -m 'Agregar nueva funcionalidad'`)
4. **Push** a la rama (`git push origin feature/nueva-funcionalidad`)
5. **Crear** un Pull Request

## 📄 Licencia

Este proyecto está bajo la Licencia MIT. Ver el archivo `LICENSE` para más detalles.

## 👨‍💻 Desarrolladora

**Rosa López**
- GitHub: [@RosaLopezC](https://github.com/RosaLopezC)
- Proyecto: [PROYECTO-FINAL-FLUTTER](https://github.com/RosaLopezC/PROYECTO-FINAL-FLUTTER)

## 🙏 Agradecimientos

- **Flutter Team** por el excelente framework
- **OpenWeatherMap** por la API gratuita del clima
- **Google Fonts** por la tipografía Poppins
- **Comunidad Flutter** por los packages utilizados

---

⭐ **¡Si te gusta este proyecto, dale una estrella en GitHub!** ⭐

---

## 📞 Soporte

Si tienes alguna pregunta o problema:

1. **Revisa** las issues existentes
2. **Crea** una nueva issue con detalles
3. **Incluye** logs y capturas de pantalla
4. **Especifica** tu versión de Flutter y dispositivo

**¡Gracias por usar Gestor de Tareas Pro!** 🚀
