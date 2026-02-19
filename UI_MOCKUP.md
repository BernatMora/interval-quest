# Interval Quest - UI Mockup and Visual Guide

This document provides a text-based representation of the app's user interface.

## Main Menu Screen (ContentView)

```
┌────────────────────────────────────────┐
│                                        │
│         [Blue-Purple Gradient]         │
│                                        │
│              🎵                         │
│                                        │
│         Interval Quest                 │
│   Aprende teoría musical jugando       │
│                                        │
│                                        │
│    ╔════════════════════════╗         │
│    ║    🎮 Jugar           ║         │
│    ╚════════════════════════╝         │
│              (green)                   │
│                                        │
│    ┌────────────────────────┐         │
│    │  🎹 Práctica Libre    │         │
│    └────────────────────────┘         │
│          (blue, faded)                 │
│                                        │
│    ┌────────────────────────┐         │
│    │  ⚙️ Configuración      │         │
│    └────────────────────────┘         │
│          (gray, faded)                 │
│                                        │
│                                        │
│             v1.0.0                     │
└────────────────────────────────────────┘
```

## Game Screen (GameView)

### Header Section
```
┌────────────────────────────────────────┐
│  Nivel 1: Acorde Mayor                 │
│  Construye: C Mayor                    │
│                                        │
│  ⭐ 0    🔥 0x    ⏱️ --                 │
└────────────────────────────────────────┘
```

### Root Note Display
```
┌────────────────────────────────────────┐
│           Nota Raíz                    │
│                                        │
│          ┌─────────┐                   │
│          │         │                   │
│          │    C    │                   │
│          │         │                   │
│          └─────────┘                   │
│          (blue box)                    │
└────────────────────────────────────────┘
```

### Answer Slots (Empty State)
```
┌────────────────────────────────────────┐
│          Tu Respuesta                  │
│                                        │
│  ┌────┐  ┌────┐  ┌────┐               │
│  │ __ │  │ __ │  │ __ │               │
│  └────┘  └────┘  └────┘               │
│  (gray)  (gray)  (gray)                │
└────────────────────────────────────────┘
```

### Answer Slots (Filled State)
```
┌────────────────────────────────────────┐
│          Tu Respuesta                  │
│                                        │
│  ┌────┐  ┌────┐  ┌────┐               │
│  │ R  │  │ 3  │  │ 5  │               │
│  └────┘  └────┘  └────┘               │
│  (blue)  (blue)  (blue)                │
└────────────────────────────────────────┘
```

### Answer Slots (Correct State)
```
┌────────────────────────────────────────┐
│          Tu Respuesta                  │
│                                        │
│  ┌────┐  ┌────┐  ┌────┐               │
│  │ R  │  │ 3  │  │ 5  │               │
│  └────┘  └────┘  └────┘               │
│ (green) (green) (green)                │
└────────────────────────────────────────┘
```

### Interval Bank
```
┌────────────────────────────────────────┐
│       Intervalos Disponibles           │
│                                        │
│  ┌───┐ ┌───┐ ┌───┐ ┌───┐              │
│  │ R │ │ 2 │ │♭3 │ │ 3 │              │
│  └───┘ └───┘ └───┘ └───┘              │
│ purple blue green green                │
│                                        │
│  ┌───┐ ┌───┐ ┌───┐ ┌───┐              │
│  │ 4 │ │♭5 │ │ 5 │ │♭6 │              │
│  └───┘ └───┘ └───┘ └───┘              │
│ orange red  red  teal                  │
│                                        │
│  ┌───┐ ┌───┐ ┌───┐                    │
│  │ 6 │ │♭7 │ │ 7 │                    │
│  └───┘ └───┘ └───┘                    │
│  teal indigo indigo                    │
└────────────────────────────────────────┘
```

### Action Buttons
```
┌────────────────────────────────────────┐
│  ┌────┐  ┌────┐  ┌──────────────┐    │
│  │ 🔊 │  │🗑️ │  │  Comprobar   │    │
│  └────┘  └────┘  └──────────────┘    │
│  (blue)  (red)      (green)           │
└────────────────────────────────────────┘
```

### Feedback (Correct)
```
┌────────────────────────────────────────┐
│                                        │
│    ┌──────────────────────────┐       │
│    │  ✅ ¡Correcto!          │       │
│    └──────────────────────────┘       │
│          (green banner)                │
│                                        │
│    ┌──────────────────────────┐       │
│    │   Siguiente Nivel        │       │
│    └──────────────────────────┘       │
│          (green button)                │
└────────────────────────────────────────┘
```

### Feedback (Incorrect)
```
┌────────────────────────────────────────┐
│                                        │
│    ┌──────────────────────────┐       │
│    │  ❌ Incorrecto.         │       │
│    │  Inténtalo de nuevo.    │       │
│    └──────────────────────────┘       │
│           (red banner)                 │
│                                        │
│    ┌──────────────────────────┐       │
│    │   Intentar de Nuevo      │       │
│    └──────────────────────────┘       │
│         (orange button)                │
└────────────────────────────────────────┘
```

## Complete Game Flow Example

### Step 1: Launch App
```
User sees ContentView with menu options
↓
Taps "🎮 Jugar"
```

### Step 2: Enter Game
```
GameView loads with:
- Challenge: "Construye: C Mayor"
- Root Note: C
- Empty slots: [__, __, __]
- Available intervals: R, 2, ♭3, 3, 4, ♭5, 5, ♭6, 6, ♭7, 7
```

### Step 3: Select Intervals
```
User taps:
1. "R" → Slot 1 filled: [R, __, __]
2. "3" → Slot 2 filled: [R, 3, __]
3. "5" → Slot 3 filled: [R, 3, 5]

"Comprobar" button becomes enabled (green)
```

### Step 4: Check Answer
```
User taps "Comprobar"
↓
GameViewModel validates: [R, 3, 5] == Major chord ✓
↓
Slots turn green
Feedback shows: "✅ ¡Correcto!"
Audio plays: C-E-G chord
Score increases: 0 → 100
Combo increases: 0x → 1x
"Siguiente Nivel" button appears
```

### Step 5: Next Level (or Incorrect)
```
If CORRECT:
  Tap "Siguiente Nivel" → Load next challenge

If INCORRECT:
  Slots turn red
  Feedback shows: "❌ Incorrecto"
  Tap "Intentar de Nuevo" → Reset and try again
```

## Color Scheme

### Main Colors
- **Primary**: Blue (#007AFF)
- **Secondary**: Purple (#8E44AD)
- **Accent**: Green (#2ECC71)
- **Background**: Gradient (Blue to Purple)

### Interval Colors
- **Root (R)**: Purple
- **Seconds (♭2, 2, ♭9, 9, #9)**: Blue
- **Thirds (♭3, 3)**: Green
- **Fourths (4, #4, 11, #11)**: Orange
- **Fifths (♭5, 5)**: Red
- **Sixths (♭6, 6, ♭13, 13)**: Teal
- **Sevenths (♭7, 7)**: Indigo

### State Colors
- **Empty Slot**: Gray with opacity
- **Filled Slot**: Blue with shadow
- **Correct Slot**: Green with shadow
- **Incorrect Slot**: Red with shadow

## Typography

- **Main Title**: 48pt, Bold, Rounded
- **Level Name**: 20pt, Bold
- **Challenge Text**: 18pt, Regular
- **Stats**: 16pt, Headline
- **Interval Buttons**: 26pt, Bold
- **Action Buttons**: 18pt, Headline

## Animations

1. **Button Tap**: Scale down to 0.95 with spring animation
2. **Slot Fill**: Fade in + slide up animation
3. **Feedback**: Scale + opacity transition
4. **Color Change**: Smooth color interpolation

## Accessibility

- **High Contrast**: All text readable on backgrounds
- **Touch Targets**: Minimum 44x44 points
- **Color Blind Safe**: Symbols + colors for intervals
- **VoiceOver**: All elements labeled

## Responsive Design

The UI adapts to different screen sizes:
- **iPhone SE**: Smaller interval buttons, tighter spacing
- **iPhone 14 Pro**: Standard layout as shown
- **iPad**: Larger buttons, more whitespace
- **Landscape**: Adjusted layout to fit horizontal space

## Example Gameplay Scenarios

### Scenario 1: Perfect Game
```
1. Launch → Tap "Jugar"
2. Build C Major: R, 3, 5
3. Check → ✅ Correct! +100 points, 1x combo
4. Next → Build C Minor: R, ♭3, 5
5. Check → ✅ Correct! +100 points, 2x combo
6. Continue building combo...
```

### Scenario 2: Learning from Mistakes
```
1. Launch → Tap "Jugar"
2. Build C Major attempt 1: R, ♭3, 5 (minor chord)
3. Check → ❌ Incorrect! Combo reset
4. Try Again → Clear answer
5. Build C Major attempt 2: R, 3, 5
6. Check → ✅ Correct! Start new combo
```

### Scenario 3: Using Audio Hints
```
1. In game, build partial answer: R, 3
2. Tap 🔊 speaker button
3. Hear C-E (incomplete chord)
4. Add 5 to complete
5. Tap 🔊 again to verify
6. Hear C-E-G (complete major chord)
7. Tap "Comprobar" with confidence
```

## Technical Notes

- All views use SwiftUI declarative syntax
- State management via @Published properties
- Animations use .spring() and .easeInOut
- Colors defined in Assets.xcassets
- Gradients use LinearGradient with opacity
- Shadows use .shadow(radius:) modifier
- Rounded corners use .cornerRadius() modifier

## Future UI Enhancements

- [ ] Animated note playback visualization
- [ ] Particle effects for correct answers
- [ ] Progress bar for level completion
- [ ] Settings screen with toggles
- [ ] Practice mode with freeform selection
- [ ] Dark mode support
- [ ] Custom themes
- [ ] Achievement badges display
- [ ] Statistics graphs
- [ ] Leaderboard UI
