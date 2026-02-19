//
//  MusicTheoryEngine.swift
//  IntervalQuest
//
//  Created by Bernat Mora on 2026-02-19.
//

import Foundation

/// Motor de teoría musical para validación y generación de contenido
class MusicTheoryEngine {
    
    // MARK: - Validación de Intervalos
    
    /// Compara si dos arrays de intervalos coinciden (sin importar orden)
    static func intervalsMatch(_ player: [Interval], _ target: [Interval]) -> Bool {
        // Ordenar ambos arrays por semitones para comparar
        let playerSorted = player.sorted { $0.semitones < $1.semitones }
        let targetSorted = target.sorted { $0.semitones < $1.semitones }
        
        guard playerSorted.count == targetSorted.count else {
            return false
        }
        
        return playerSorted.elementsEqual(targetSorted) { $0.semitones == $1.semitones }
    }
    
    // MARK: - Obtención de Notas
    
    /// Obtiene las notas resultantes de aplicar intervalos a una raíz
    static func getNotesForChord(root: Note, intervals: [Interval]) -> [Note] {
        return intervals.map { interval in
            root.applying(interval: interval)
        }
    }
    
    // MARK: - Generación Aleatoria
    
    /// Genera un acorde aleatorio según dificultad
    static func randomChord(difficulty: Difficulty) -> Chord {
        switch difficulty {
        case .easy:
            return Chord.allTriads.randomElement() ?? .major
        case .medium:
            return Chord.allSevenths.randomElement() ?? .major7
        case .hard:
            return Chord.allExtended.randomElement() ?? .ninth
        }
    }
    
    /// Genera una escala aleatoria según dificultad
    static func randomScale(difficulty: Difficulty) -> Scale {
        switch difficulty {
        case .easy:
            return Scale.basicScales.randomElement() ?? .major
        case .medium:
            return Scale.modes.randomElement() ?? .ionian
        case .hard:
            return Scale.exoticScales.randomElement() ?? .arabic
        }
    }
    
    /// Genera una nota raíz aleatoria
    static func randomRootNote() -> Note {
        return Note.allCases.randomElement() ?? .C
    }
    
    // MARK: - Mezcla de Intervalos
    
    /// Mezcla un array de intervalos aleatoriamente
    static func shuffleIntervals(_ intervals: [Interval]) -> [Interval] {
        return intervals.shuffled()
    }
    
    /// Genera intervalos señuelo para aumentar dificultad
    /// - Parameters:
    ///   - target: Intervalos objetivo
    ///   - count: Número de señuelos a generar
    /// - Returns: Array de intervalos señuelo que NO están en el objetivo
    static func generateDecoyIntervals(for target: [Interval], count: Int) -> [Interval] {
        let targetSet = Set(target.map { $0.semitones })
        
        // Filtrar intervalos que no están en el objetivo
        let availableDecoys = Interval.allCases.filter { interval in
            !targetSet.contains(interval.semitones) && interval != .root
        }
        
        // Seleccionar aleatoriamente hasta 'count' señuelos
        let decoys = availableDecoys.shuffled().prefix(count)
        return Array(decoys)
    }
    
    /// Genera un conjunto de intervalos disponibles (objetivo + señuelos)
    /// - Parameters:
    ///   - target: Intervalos objetivo
    ///   - decoyCount: Número de señuelos a añadir
    /// - Returns: Array mezclado de intervalos disponibles
    static func generateAvailableIntervals(target: [Interval], decoyCount: Int) -> [Interval] {
        let decoys = generateDecoyIntervals(for: target, count: decoyCount)
        let all = target + decoys
        return shuffleIntervals(all)
    }
    
    // MARK: - Ayudas y Validaciones
    
    /// Verifica si un intervalo está disponible para usar
    static func isIntervalAvailable(_ interval: Interval, in available: [Interval]) -> Bool {
        return available.contains(interval)
    }
    
    /// Calcula la puntuación basada en dificultad y tiempo
    static func calculateScore(difficulty: Difficulty, timeRemaining: Int?, combo: Int) -> Int {
        let baseScore: Int
        switch difficulty {
        case .easy: baseScore = 100
        case .medium: baseScore = 200
        case .hard: baseScore = 300
        }
        
        let timeBonus = timeRemaining ?? 0
        let comboMultiplier = 1 + (combo / 5) // +1 multiplicador cada 5 combo
        
        return (baseScore + timeBonus) * comboMultiplier
    }
}
