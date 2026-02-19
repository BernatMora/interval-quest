# 🎵 Interval Quest

Un juego educativo de iOS sobre teoría musical enfocado en intervalos, acordes y escalas.

![iOS](https://img.shields.io/badge/iOS-16.0+-blue.svg)
![Swift](https://img.shields.io/badge/Swift-5.0-orange.svg)
![SwiftUI](https://img.shields.io/badge/SwiftUI-✓-green.svg)
![License](https://img.shields.io/badge/License-MIT-yellow.svg)

## 📖 Descripción

Interval Quest es un juego interactivo diseñado para ayudar a músicos y estudiantes de música a aprender teoría musical de manera divertida. El juego se enfoca en:

- 🎼 **Intervalos musicales**: Aprende todos los intervalos desde la raíz hasta las extensiones
- 🎹 **Acordes**: Construye tríadas, cuatríadas y acordes extendidos
- 🎸 **Escalas**: Practica escalas mayores, menores, modos y escalas exóticas
- 🎯 **Sin pentagramas**: Solo grados e intervalos numéricos para facilitar el aprendizaje

## ✨ Características Principales

- ✅ **Interfaz intuitiva** con SwiftUI
- ✅ **Sistema de puntuación** con combos
- ✅ **Feedback visual** inmediato (correcto/incorrecto)
- ✅ **Reproducción de audio** de acordes y escalas usando AVFoundation
- ✅ **Múltiples niveles** con dificultad progresiva
- ✅ **Intervalos coloreados** para facilitar el aprendizaje visual
- ✅ **Arquitectura MVVM** limpia y escalable

## 📸 Screenshots

_Screenshots del juego aquí_

## 🎮 Cómo Jugar

1. **Selecciona un nivel**: Comienza con el nivel de ejemplo (Acorde Mayor)
2. **Lee el desafío**: Construye el acorde o escala indicado
3. **Selecciona intervalos**: Toca los intervalos del banco para añadirlos a tu respuesta
4. **Verifica**: Presiona "Comprobar" cuando tu respuesta esté completa
5. **Avanza**: Si es correcto, pasa al siguiente nivel y aumenta tu combo

## 🎯 Biblioteca de Contenido

### Acordes Disponibles

**Tríadas:**
- Mayor, Menor, Disminuido, Aumentado, Sus2, Sus4

**Cuatríadas:**
- Maj7, m7, 7 (dominante), m7♭5, dim7, mMaj7

**Extendidos:**
- 9, Maj9, m9, 11, 13

### Escalas Disponibles

**Básicas:**
- Mayor, Menor Natural, Menor Armónica, Menor Melódica

**Pentatónicas:**
- Pentatónica Mayor, Pentatónica Menor

**Modos Griegos:**
- Jónico, Dórico, Frigio, Lidio, Mixolidio, Eólico, Locrio

**Exóticas:**
- Árabe, Húngara, Japonesa

## 🛠️ Requisitos

- **iOS**: 16.0 o superior
- **Xcode**: 14.0 o superior
- **Swift**: 5.0 o superior
- **Dispositivos**: iPhone y iPad

## 📦 Instalación

1. Clona el repositorio:
```bash
git clone https://github.com/BernatMora/interval-quest.git
cd interval-quest
```

2. Abre el proyecto en Xcode:
```bash
open IntervalQuest.xcodeproj
```

3. Selecciona un simulador o dispositivo

4. Presiona `Cmd + R` para compilar y ejecutar

## 🏗️ Arquitectura

El proyecto sigue el patrón **MVVM (Model-View-ViewModel)**:

```
IntervalQuest/
├── App/                    # Entry point de la aplicación
├── Models/                 # Modelos de datos (Interval, Note, Chord, Scale, GameLevel)
├── ViewModels/            # Lógica de negocio (GameViewModel)
├── Views/                 # Vistas SwiftUI (ContentView, GameView, etc.)
├── Services/              # Servicios (MusicTheoryEngine, AudioService)
└── Utils/                 # Utilidades y extensiones
```

### Componentes Clave

- **MusicTheoryEngine**: Motor de teoría musical para validación y generación
- **AudioService**: Servicio de reproducción de audio con AVFoundation
- **GameViewModel**: Gestiona el estado del juego y la lógica
- **IntervalSlotView**: Muestra los slots para la respuesta del jugador
- **IntervalBankView**: Banco de intervalos disponibles

## 🎨 Diseño

- **Colores**: Gradientes azul-púrpura para un aspecto moderno
- **Tipografía**: San Francisco (sistema iOS)
- **Animaciones**: Spring animations para interacciones fluidas
- **Accesibilidad**: Contraste alto y tamaños de fuente legibles

## 🚀 Roadmap

- [ ] Más tipos de niveles (identificar intervalos, completar faltantes)
- [ ] Sistema de progresión de niveles
- [ ] Modo de práctica libre
- [ ] Estadísticas de rendimiento
- [ ] Achievements y logros
- [ ] Soporte multiidioma
- [ ] Modo oscuro
- [ ] Sonidos de fondo opcionales
- [ ] Tablas de clasificación

## 🤝 Contribuir

Las contribuciones son bienvenidas. Por favor:

1. Fork el proyecto
2. Crea una rama para tu feature (`git checkout -b feature/AmazingFeature`)
3. Commit tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abre un Pull Request

## 📄 Licencia

Este proyecto está bajo la Licencia MIT. Ver el archivo `LICENSE` para más detalles.

## 👤 Autor

**Bernat Mora**

- GitHub: [@BernatMora](https://github.com/BernatMora)

## 🙏 Agradecimientos

- Inspirado en la necesidad de herramientas de aprendizaje musical interactivas
- Construido con ❤️ usando SwiftUI

---

¿Te gusta el proyecto? ¡Dale una ⭐️!
