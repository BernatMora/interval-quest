//
//  Chord.swift
//  IntervalQuest
//
//  Created by Bernat Mora on 2026-02-19.
//

import Foundation

/// Categoría de acorde
enum ChordCategory: String, CaseIterable {
    case triad = "Tríada"
    case seventh = "Cuatríada"
    case extended = "Extendido"
}

/// Representa un acorde musical con sus intervalos
struct Chord: Identifiable, Equatable {
    let id = UUID()
    let name: String
    let intervals: [Interval]
    let category: ChordCategory
    
    // MARK: - Biblioteca Estática de Acordes
    
    // Tríadas
    static let major = Chord(
        name: "Mayor",
        intervals: [.root, .majorThird, .perfectFifth],
        category: .triad
    )
    
    static let minor = Chord(
        name: "Menor",
        intervals: [.root, .minorThird, .perfectFifth],
        category: .triad
    )
    
    static let diminished = Chord(
        name: "Disminuido",
        intervals: [.root, .minorThird, .diminishedFifth],
        category: .triad
    )
    
    static let augmented = Chord(
        name: "Aumentado",
        intervals: [.root, .majorThird, .minorSixth],
        category: .triad
    )
    
    static let sus2 = Chord(
        name: "Sus2",
        intervals: [.root, .majorSecond, .perfectFifth],
        category: .triad
    )
    
    static let sus4 = Chord(
        name: "Sus4",
        intervals: [.root, .perfectFourth, .perfectFifth],
        category: .triad
    )
    
    // Cuatríadas
    static let major7 = Chord(
        name: "Maj7",
        intervals: [.root, .majorThird, .perfectFifth, .majorSeventh],
        category: .seventh
    )
    
    static let minor7 = Chord(
        name: "m7",
        intervals: [.root, .minorThird, .perfectFifth, .minorSeventh],
        category: .seventh
    )
    
    static let dominant7 = Chord(
        name: "7",
        intervals: [.root, .majorThird, .perfectFifth, .minorSeventh],
        category: .seventh
    )
    
    static let halfDiminished7 = Chord(
        name: "m7♭5",
        intervals: [.root, .minorThird, .diminishedFifth, .minorSeventh],
        category: .seventh
    )
    
    static let diminished7 = Chord(
        name: "dim7",
        intervals: [.root, .minorThird, .diminishedFifth, .majorSixth],
        category: .seventh
    )
    
    static let minorMajor7 = Chord(
        name: "mMaj7",
        intervals: [.root, .minorThird, .perfectFifth, .majorSeventh],
        category: .seventh
    )
    
    // Acordes Extendidos
    static let ninth = Chord(
        name: "9",
        intervals: [.root, .majorThird, .perfectFifth, .minorSeventh, .majorNinth],
        category: .extended
    )
    
    static let major9 = Chord(
        name: "Maj9",
        intervals: [.root, .majorThird, .perfectFifth, .majorSeventh, .majorNinth],
        category: .extended
    )
    
    static let minor9 = Chord(
        name: "m9",
        intervals: [.root, .minorThird, .perfectFifth, .minorSeventh, .majorNinth],
        category: .extended
    )
    
    static let eleventh = Chord(
        name: "11",
        intervals: [.root, .majorThird, .perfectFifth, .minorSeventh, .majorNinth, .perfectEleventh],
        category: .extended
    )
    
    static let thirteenth = Chord(
        name: "13",
        intervals: [.root, .majorThird, .perfectFifth, .minorSeventh, .majorNinth, .majorThirteenth],
        category: .extended
    )
    
    // MARK: - Colecciones de Acordes
    
    static let allTriads: [Chord] = [
        .major, .minor, .diminished, .augmented, .sus2, .sus4
    ]
    
    static let allSevenths: [Chord] = [
        .major7, .minor7, .dominant7, .halfDiminished7, .diminished7, .minorMajor7
    ]
    
    static let allExtended: [Chord] = [
        .ninth, .major9, .minor9, .eleventh, .thirteenth
    ]
    
    static let allChords: [Chord] = allTriads + allSevenths + allExtended
    
    // MARK: - Métodos de Ayuda
    
    /// Obtiene acordes por categoría
    static func chords(for category: ChordCategory) -> [Chord] {
        switch category {
        case .triad: return allTriads
        case .seventh: return allSevenths
        case .extended: return allExtended
        }
    }
}
