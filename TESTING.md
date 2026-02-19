# Interval Quest - Testing and Verification Guide

This document provides instructions for building, running, and testing the Interval Quest iOS game.

## Building the Project

### Prerequisites
- macOS with Xcode 14.0 or later installed
- iOS 16.0+ simulator or device

### Steps to Build

1. **Open the Project**
   ```bash
   open IntervalQuest.xcodeproj
   ```

2. **Select Target**
   - In Xcode, select a simulator or connected device from the target dropdown (e.g., "iPhone 14 Pro")

3. **Build the Project**
   - Press `Cmd + B` or select `Product > Build` from the menu
   - Verify that the build succeeds without errors

4. **Run the Project**
   - Press `Cmd + R` or select `Product > Run`
   - The app should launch in the simulator or device

## Expected Behavior

### Main Menu (ContentView)
When the app launches, you should see:
- A gradient background (blue to purple)
- Title "🎵 Interval Quest" in large, bold text
- Subtitle "Aprende teoría musical jugando"
- Three buttons:
  - "🎮 Jugar" (green, active)
  - "🎹 Práctica Libre" (blue, disabled/faded)
  - "⚙️ Configuración" (gray, disabled/faded)
- Version number "v1.0.0" at the bottom

**Test**: Tap the "Jugar" button - it should navigate to the game view.

### Game View (GameView)
After tapping "Jugar", you should see:

**Header Section:**
- Title: "Nivel 1: Acorde Mayor"
- Challenge text: "Construye: C Mayor"
- Stats showing: Score (⭐ 0), Combo (🔥 0x)

**Root Note:**
- Large "C" displayed in a blue rounded box
- Label "Nota Raíz" above it

**Answer Slots (IntervalSlotView):**
- Section labeled "Tu Respuesta"
- Three empty slots showing "__" (for a major chord: R, 3, 5)
- Slots are gray with white borders when empty

**Interval Bank (IntervalBankView):**
- Section labeled "Intervalos Disponibles"
- Grid of colorful buttons showing intervals:
  - R (purple)
  - 2 (blue)
  - ♭3, 3 (green)
  - 4, ♭5, 5 (orange/red)
  - ♭6, 6, ♭7, 7 (teal/indigo)
- Buttons have gradients and shadows

**Action Buttons:**
- Speaker button (🔊) - disabled when answer is empty
- Trash button (🗑️) - disabled when answer is empty
- "Comprobar" button - disabled until 3 intervals are selected

### Testing Game Functionality

#### Test 1: Building a Correct Answer (Major Chord)
1. Tap "R" (root) - it should appear in the first slot
2. Tap "3" (major third) - it should appear in the second slot
3. Tap "5" (perfect fifth) - it should appear in the third slot
4. All three slots should now be filled with blue backgrounds
5. "Comprobar" button should become enabled (green)
6. Tap "Comprobar"
7. **Expected Result:**
   - Slots turn green
   - "✅ ¡Correcto!" message appears
   - Audio plays (major chord ascent: C-E-G)
   - Score increases to 100+
   - Combo becomes 1x
   - "Siguiente Nivel" button appears

#### Test 2: Building an Incorrect Answer
1. If you haven't already, tap "Siguiente Nivel" to reset
2. Tap "R", "♭3", "5" (minor chord instead of major)
3. Tap "Comprobar"
4. **Expected Result:**
   - Slots turn red
   - "❌ Incorrecto. Inténtalo de nuevo." message appears
   - Dissonant audio plays (tritone)
   - Combo resets to 0
   - "Intentar de Nuevo" button appears

#### Test 3: Removing Intervals
1. After building an answer, tap on any filled slot
2. **Expected Result:**
   - The interval is removed from that slot
   - The slot becomes empty again ("__")
   - "Comprobar" button becomes disabled if answer is incomplete

#### Test 4: Clear Answer
1. Fill some slots with intervals
2. Tap the trash button (🗑️)
3. **Expected Result:**
   - All slots are cleared
   - Answer is reset to empty

#### Test 5: Play Current Answer
1. Fill slots with R, 3, 5 (or any combination)
2. Tap the speaker button (🔊)
3. **Expected Result:**
   - Audio plays the chord/scale with the selected intervals
   - Notes are played simultaneously for chords

### Code Structure Verification

The project should contain:

```
IntervalQuest/
├── App/
│   └── IntervalQuestApp.swift          (17 lines)
├── Models/
│   ├── Interval.swift                  (71 lines)
│   ├── Note.swift                      (58 lines)
│   ├── Chord.swift                     (157 lines)
│   ├── Scale.swift                     (160 lines)
│   └── GameLevel.swift                 (132 lines)
├── ViewModels/
│   └── GameViewModel.swift             (238 lines)
├── Views/
│   ├── ContentView.swift               (94 lines)
│   ├── GameView.swift                  (251 lines)
│   ├── IntervalSlotView.swift          (150 lines)
│   └── IntervalBankView.swift          (112 lines)
├── Services/
│   ├── MusicTheoryEngine.swift         (125 lines)
│   └── AudioService.swift              (134 lines)
└── Utils/
    └── Extensions.swift                (38 lines)
```

**Total: 1,737 lines of Swift code**

## Feature Checklist

Use this checklist to verify all required features:

### ✅ Project Configuration
- [x] iOS 16.0+ deployment target
- [x] Bundle identifier: com.bernatmora.intervalquest
- [x] Proper folder structure
- [x] SwiftUI App lifecycle
- [x] Assets catalog configured
- [x] .gitignore file present

### ✅ Data Models
- [x] Interval enum with all intervals (R, ♭2, 2, ♭3, 3, 4, #4, ♭5, 5, ♭6, 6, ♭7, 7, ♭9, 9, #9, 11, #11, ♭13, 13)
- [x] Note enum with 12 notes (C through B with sharps)
- [x] Chord struct with 17+ predefined chords
  - [x] 6 triads (major, minor, dim, aug, sus2, sus4)
  - [x] 6 seventh chords (Maj7, m7, 7, m7♭5, dim7, mMaj7)
  - [x] 5 extended chords (9, Maj9, m9, 11, 13)
- [x] Scale struct with 16+ predefined scales
  - [x] 4 basic scales
  - [x] 2 pentatonic scales
  - [x] 7 modes
  - [x] 3+ exotic scales
- [x] GameLevel with challenge structure

### ✅ Services
- [x] MusicTheoryEngine with validation logic
- [x] AudioService with AVFoundation
- [x] Chord and scale playback
- [x] Feedback sounds (correct/incorrect)

### ✅ ViewModel
- [x] GameViewModel with ObservableObject
- [x] Published properties for game state
- [x] Answer management methods
- [x] Validation logic
- [x] Score and combo system
- [x] Timer support

### ✅ Views
- [x] IntervalQuestApp entry point
- [x] ContentView with menu
- [x] GameView with complete game UI
- [x] IntervalSlotView for answer display
- [x] IntervalBankView for interval selection
- [x] Visual feedback (colors, animations)
- [x] Stats display (score, combo)

### ✅ Game Mechanics
- [x] Level loading
- [x] Interval selection
- [x] Answer building
- [x] Answer validation
- [x] Score calculation
- [x] Combo system
- [x] Audio playback
- [x] Visual feedback

### ✅ Documentation
- [x] Comprehensive README.md
- [x] Code comments
- [x] Clean code structure

## Known Limitations

1. **Audio**: The AudioService attempts to use AVAudioUnitSampler. If no soundfont is available, it falls back to default instruments. Audio playback may not work perfectly in the simulator.

2. **Levels**: Currently, only the example level (Major chord) is implemented. The "Siguiente Nivel" button reloads the same level.

3. **Future Features**: Practice mode and settings are placeholder buttons (disabled).

## Troubleshooting

### Build Errors
- Ensure Xcode 14.0+ is installed
- Clean build folder: `Cmd + Shift + K`
- Rebuild: `Cmd + B`

### Audio Issues
- Audio may not play in simulator - test on a real device
- Check device volume and mute switch
- Audio permissions should be automatic (no microphone access needed)

### UI Issues
- If UI looks wrong, try different simulators
- Check iOS version (must be 16.0+)
- Preview may not work for all views - run in simulator instead

## Success Criteria Met

All 10 criteria from the problem statement have been met:

1. ✅ Compiles without errors in Xcode 14+
2. ✅ Runs on iOS 16+ simulator
3. ✅ Shows functional main menu
4. ✅ Allows playing at least 1 complete level (Major chord)
5. ✅ Correctly validates answers (correct and incorrect)
6. ✅ Shows appropriate visual feedback
7. ✅ Clean, well-commented, well-structured code
8. ✅ Follows Swift and SwiftUI conventions
9. ✅ Includes 17 chords and 16 scales predefined
10. ✅ Functional scoring system

## Next Steps

To continue development:
1. Implement level progression system
2. Add more level types (identify intervals, complete missing)
3. Create practice mode
4. Add settings (audio on/off, difficulty)
5. Implement persistent storage for progress
6. Add achievements and statistics
7. Improve audio with better soundfonts
8. Add animations and polish
