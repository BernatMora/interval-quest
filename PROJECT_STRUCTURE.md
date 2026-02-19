# Interval Quest - Project Structure

## Directory Structure

```
interval-quest/
├── README.md                          # Project documentation
├── TESTING.md                         # Testing and verification guide
├── .gitignore                         # Git ignore rules
│
├── IntervalQuest.xcodeproj/           # Xcode project configuration
│   ├── project.pbxproj                # Main project file
│   ├── project.xcworkspace/           # Workspace configuration
│   └── xcshareddata/                  # Shared schemes
│       └── xcschemes/
│           └── IntervalQuest.xcscheme # Build scheme
│
└── IntervalQuest/                     # Main source directory
    │
    ├── App/                           # Application entry point
    │   └── IntervalQuestApp.swift     # @main struct, app lifecycle
    │
    ├── Models/                        # Data models (578 lines total)
    │   ├── Interval.swift             # Musical intervals enum (R, ♭2, 2, ♭3, 3, etc.)
    │   ├── Note.swift                 # Musical notes enum (C, C#, D, etc.)
    │   ├── Chord.swift                # Chord definitions (triads, sevenths, extended)
    │   ├── Scale.swift                # Scale definitions (major, minor, modes, exotic)
    │   └── GameLevel.swift            # Level structure and challenges
    │
    ├── ViewModels/                    # Business logic
    │   └── GameViewModel.swift        # Game state management, answer validation
    │
    ├── Views/                         # SwiftUI user interface (607 lines total)
    │   ├── ContentView.swift          # Main menu screen
    │   ├── GameView.swift             # Main game screen
    │   ├── IntervalSlotView.swift     # Answer slots display
    │   └── IntervalBankView.swift     # Interval selection grid
    │
    ├── Services/                      # Business services (259 lines total)
    │   ├── MusicTheoryEngine.swift    # Validation and generation logic
    │   └── AudioService.swift         # Audio playback (AVFoundation)
    │
    ├── Utils/                         # Utilities
    │   └── Extensions.swift           # Custom extensions (Color, Array, View)
    │
    ├── Assets.xcassets/               # App assets
    │   ├── AppIcon.appiconset/        # App icon
    │   ├── AccentColor.colorset/      # Accent color
    │   └── Contents.json              # Asset catalog manifest
    │
    └── Preview Content/               # SwiftUI previews
        └── Preview Assets.xcassets/   # Preview assets
```

## Architecture: MVVM Pattern

```
┌─────────────────────────────────────────────────────────────┐
│                         View Layer                           │
│  ┌─────────────┐  ┌─────────────┐  ┌──────────────────┐    │
│  │ ContentView │  │  GameView   │  │ IntervalSlotView │    │
│  │             │  │             │  │                  │    │
│  │   (Menu)    │  │   (Game)    │  │ IntervalBankView │    │
│  └──────┬──────┘  └──────┬──────┘  └─────────┬────────┘    │
│         │                │                    │             │
└─────────┼────────────────┼────────────────────┼─────────────┘
          │                │                    │
          │         ┌──────▼─────────┐          │
          │         │  GameViewModel │◄─────────┘
          │         │                │
          │         │  @Published    │
          │         │  properties    │
          │         └────────┬───────┘
          │                  │
┌─────────┼──────────────────┼─────────────────────────────────┐
│         │      Model       │        Services                  │
│         │                  │                                  │
│  ┌──────▼──────┐   ┌───────▼────────┐   ┌─────────────────┐ │
│  │   Models    │   │ MusicTheory    │   │  AudioService   │ │
│  │             │   │    Engine      │   │                 │ │
│  │ • Interval  │   │                │   │  AVFoundation   │ │
│  │ • Note      │   │ • Validation   │   │  • playChord()  │ │
│  │ • Chord     │   │ • Generation   │   │  • playScale()  │ │
│  │ • Scale     │   │ • Scoring      │   │  • playSound()  │ │
│  │ • GameLevel │   │                │   │                 │ │
│  └─────────────┘   └────────────────┘   └─────────────────┘ │
│                                                               │
└───────────────────────────────────────────────────────────────┘
```

## Data Flow

```
User Interaction
      │
      ▼
┌─────────────┐
│    View     │  (User taps interval button)
└──────┬──────┘
       │ binding
       ▼
┌─────────────┐
│  ViewModel  │  (Updates @Published properties)
│             │
│  func addInterval(_ interval: Interval)
│  func checkAnswer() -> Bool
└──────┬──────┘
       │ uses
       ▼
┌─────────────┐        ┌──────────────┐
│   Models    │◄───────┤   Services   │
│             │        │              │
│ Chord.major │        │ MusicTheory  │
│ [R, 3, 5]   │        │ AudioService │
└─────────────┘        └──────────────┘
       │
       │ triggers
       ▼
┌─────────────┐
│    View     │  (Updates UI with feedback)
│             │
│  ✅ Correct! │
└─────────────┘
```

## Game Flow

```
App Launch
    │
    ▼
┌───────────────────┐
│   ContentView     │  Main Menu
│   (Menu Screen)   │
│                   │
│  [🎮 Jugar]       │◄────┐
│  [🎹 Practice]    │     │
│  [⚙️ Settings]    │     │
└─────────┬─────────┘     │
          │               │
          │ Navigate      │
          ▼               │
┌───────────────────┐     │
│    GameView       │     │
│  (Game Screen)    │     │
│                   │     │
│  Header: Level    │     │
│  Root Note: C     │     │
│  Answer Slots     │     │
│  Interval Bank    │     │
│  Action Buttons   │     │
└─────────┬─────────┘     │
          │               │
     User plays           │
          │               │
    ┌─────┴─────┐         │
    │           │         │
Correct?    Incorrect     │
    │           │         │
    ▼           ▼         │
[Next Level] [Try Again]  │
    │           │         │
    └───────────┴─────────┘
```

## Key Components

### Models (Data Structures)
- **Interval**: 20 musical intervals from root to extensions
- **Note**: 12 chromatic notes (C through B)
- **Chord**: 17+ chord types (triads, sevenths, extended)
- **Scale**: 16+ scale types (basic, pentatonic, modes, exotic)
- **GameLevel**: Level configuration with challenges

### ViewModels (State Management)
- **GameViewModel**: Manages game state, user answers, scoring, validation

### Views (UI Components)
- **ContentView**: Main menu with gradient background
- **GameView**: Game screen with header, slots, and interval bank
- **IntervalSlotView**: Visual slots for player's answer
- **IntervalBankView**: Grid of interval buttons with colors

### Services (Business Logic)
- **MusicTheoryEngine**: Validates answers, generates challenges, calculates scores
- **AudioService**: Plays notes, chords, and scales using AVFoundation

## Technologies Used

- **SwiftUI**: Modern declarative UI framework
- **Combine**: Reactive programming with @Published properties
- **AVFoundation**: Audio playback (AVAudioEngine, AVAudioUnitSampler)
- **Swift 5.0**: Modern Swift language features
- **iOS 16.0+**: Latest iOS SDK features

## Code Statistics

| Component        | Files | Lines | Description                    |
|------------------|-------|-------|--------------------------------|
| Models           | 5     | 578   | Data structures                |
| ViewModels       | 1     | 238   | State management               |
| Views            | 4     | 607   | User interface                 |
| Services         | 2     | 259   | Business logic                 |
| Utils            | 1     | 38    | Extensions and helpers         |
| App              | 1     | 17    | Entry point                    |
| **Total**        | **14**| **1,737** | **Complete iOS game**      |

## Build Configuration

- **Target**: iOS 16.0+
- **Swift Version**: 5.0
- **Bundle ID**: com.bernatmora.intervalquest
- **Architecture**: MVVM with SwiftUI
- **Dependencies**: None (native iOS frameworks only)
- **Build System**: Xcode Build System

## Features Implemented

✅ Complete iOS game structure
✅ 20 musical intervals
✅ 17+ predefined chords
✅ 16+ predefined scales
✅ Interactive interval selection
✅ Visual feedback (colors, animations)
✅ Audio playback system
✅ Score and combo system
✅ Answer validation
✅ Clean, documented code
✅ MVVM architecture
✅ SwiftUI modern UI
✅ Comprehensive documentation
