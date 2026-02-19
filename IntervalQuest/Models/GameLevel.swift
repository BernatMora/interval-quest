//
//  GameLevel.swift
//  IntervalQuest
//
//  Created by Bernat Mora on 2026-02-19.
//

import Foundation

/// Dificultad del nivel
enum Difficulty: String, CaseIterable {
    case easy = "Fácil"
    case medium = "Medio"
    case hard = "Difícil"
}

/// Tipo de nivel
enum LevelType: String {
    case buildChord = "Construir Acorde"
    case buildScale = "Construir Escala"
    case identifyIntervals = "Identificar Intervalos"
    case completeMissing = "Completar Faltantes"
}

/// Desafío del nivel
struct Challenge {
    let targetChord: Chord?
    let targetScale: Scale?
    let availableIntervals: [Interval]
    let timeLimit: Int? // segundos, nil = sin límite
    let rootNote: Note
    
    /// Crea un desafío de acorde
    static func chordChallenge(chord: Chord, rootNote: Note, availableIntervals: [Interval], timeLimit: Int? = nil) -> Challenge {
        return Challenge(
            targetChord: chord,
            targetScale: nil,
            availableIntervals: availableIntervals,
            timeLimit: timeLimit,
            rootNote: rootNote
        )
    }
    
    /// Crea un desafío de escala
    static func scaleChallenge(scale: Scale, rootNote: Note, availableIntervals: [Interval], timeLimit: Int? = nil) -> Challenge {
        return Challenge(
            targetChord: nil,
            targetScale: scale,
            availableIntervals: availableIntervals,
            timeLimit: timeLimit,
            rootNote: rootNote
        )
    }
    
    /// Obtiene los intervalos objetivo (ya sea del acorde o la escala)
    var targetIntervals: [Interval] {
        if let chord = targetChord {
            return chord.intervals
        } else if let scale = targetScale {
            return scale.intervals
        }
        return []
    }
    
    /// Nombre del objetivo (acorde o escala)
    var targetName: String {
        if let chord = targetChord {
            return "\(rootNote.rawValue) \(chord.name)"
        } else if let scale = targetScale {
            return "\(rootNote.rawValue) \(scale.name)"
        }
        return ""
    }
}

/// Representa un nivel del juego
struct GameLevel: Identifiable {
    let id = UUID()
    let name: String
    let type: LevelType
    let challenge: Challenge
    let difficulty: Difficulty
    
    // MARK: - Niveles de Ejemplo
    
    /// Nivel inicial de ejemplo: Construir acorde Mayor
    static let exampleLevel = GameLevel(
        name: "Nivel 1: Acorde Mayor",
        type: .buildChord,
        challenge: .chordChallenge(
            chord: .major,
            rootNote: .C,
            availableIntervals: [
                .root, .majorSecond, .minorThird, .majorThird,
                .perfectFourth, .diminishedFifth, .perfectFifth,
                .minorSixth, .majorSixth, .minorSeventh, .majorSeventh
            ],
            timeLimit: nil
        ),
        difficulty: .easy
    )
    
    /// Genera niveles básicos de tríadas
    static func basicTriadLevels() -> [GameLevel] {
        let chords: [(Chord, String)] = [
            (.major, "Nivel 1: Acorde Mayor"),
            (.minor, "Nivel 2: Acorde Menor"),
            (.diminished, "Nivel 3: Acorde Disminuido"),
            (.augmented, "Nivel 4: Acorde Aumentado")
        ]
        
        let availableIntervals: [Interval] = [
            .root, .minorSecond, .majorSecond, .minorThird, .majorThird,
            .perfectFourth, .augmentedFourth, .diminishedFifth, .perfectFifth,
            .minorSixth, .majorSixth, .minorSeventh, .majorSeventh
        ]
        
        return chords.map { chord, name in
            GameLevel(
                name: name,
                type: .buildChord,
                challenge: .chordChallenge(
                    chord: chord,
                    rootNote: .C,
                    availableIntervals: availableIntervals,
                    timeLimit: nil
                ),
                difficulty: .easy
            )
        }
    }
}
