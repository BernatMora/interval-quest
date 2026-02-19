//
//  Scale.swift
//  IntervalQuest
//
//  Created by Bernat Mora on 2026-02-19.
//

import Foundation

/// Categoría de escala
enum ScaleCategory: String, CaseIterable {
    case major = "Mayor"
    case minor = "Menor"
    case pentatonic = "Pentatónica"
    case modes = "Modos"
    case exotic = "Exótica"
}

/// Representa una escala musical con sus intervalos
struct Scale: Identifiable, Equatable {
    let id = UUID()
    let name: String
    let intervals: [Interval]
    let category: ScaleCategory
    
    // MARK: - Biblioteca Estática de Escalas
    
    // Escalas Básicas
    static let major = Scale(
        name: "Mayor",
        intervals: [.root, .majorSecond, .majorThird, .perfectFourth, .perfectFifth, .majorSixth, .majorSeventh],
        category: .major
    )
    
    static let naturalMinor = Scale(
        name: "Menor Natural",
        intervals: [.root, .majorSecond, .minorThird, .perfectFourth, .perfectFifth, .minorSixth, .minorSeventh],
        category: .minor
    )
    
    static let harmonicMinor = Scale(
        name: "Menor Armónica",
        intervals: [.root, .majorSecond, .minorThird, .perfectFourth, .perfectFifth, .minorSixth, .majorSeventh],
        category: .minor
    )
    
    static let melodicMinor = Scale(
        name: "Menor Melódica",
        intervals: [.root, .majorSecond, .minorThird, .perfectFourth, .perfectFifth, .majorSixth, .majorSeventh],
        category: .minor
    )
    
    // Pentatónicas
    static let majorPentatonic = Scale(
        name: "Pentatónica Mayor",
        intervals: [.root, .majorSecond, .majorThird, .perfectFifth, .majorSixth],
        category: .pentatonic
    )
    
    static let minorPentatonic = Scale(
        name: "Pentatónica Menor",
        intervals: [.root, .minorThird, .perfectFourth, .perfectFifth, .minorSeventh],
        category: .pentatonic
    )
    
    // Modos Griegos
    static let ionian = Scale(
        name: "Jónico",
        intervals: [.root, .majorSecond, .majorThird, .perfectFourth, .perfectFifth, .majorSixth, .majorSeventh],
        category: .modes
    )
    
    static let dorian = Scale(
        name: "Dórico",
        intervals: [.root, .majorSecond, .minorThird, .perfectFourth, .perfectFifth, .majorSixth, .minorSeventh],
        category: .modes
    )
    
    static let phrygian = Scale(
        name: "Frigio",
        intervals: [.root, .minorSecond, .minorThird, .perfectFourth, .perfectFifth, .minorSixth, .minorSeventh],
        category: .modes
    )
    
    static let lydian = Scale(
        name: "Lidio",
        intervals: [.root, .majorSecond, .majorThird, .augmentedFourth, .perfectFifth, .majorSixth, .majorSeventh],
        category: .modes
    )
    
    static let mixolydian = Scale(
        name: "Mixolidio",
        intervals: [.root, .majorSecond, .majorThird, .perfectFourth, .perfectFifth, .majorSixth, .minorSeventh],
        category: .modes
    )
    
    static let aeolian = Scale(
        name: "Eólico",
        intervals: [.root, .majorSecond, .minorThird, .perfectFourth, .perfectFifth, .minorSixth, .minorSeventh],
        category: .modes
    )
    
    static let locrian = Scale(
        name: "Locrio",
        intervals: [.root, .minorSecond, .minorThird, .perfectFourth, .diminishedFifth, .minorSixth, .minorSeventh],
        category: .modes
    )
    
    // Escalas Exóticas
    static let arabic = Scale(
        name: "Árabe",
        intervals: [.root, .minorSecond, .majorThird, .perfectFourth, .perfectFifth, .minorSixth, .minorSeventh],
        category: .exotic
    )
    
    static let hungarian = Scale(
        name: "Húngara",
        intervals: [.root, .majorSecond, .minorThird, .augmentedFourth, .perfectFifth, .minorSixth, .majorSeventh],
        category: .exotic
    )
    
    static let japanese = Scale(
        name: "Japonesa",
        intervals: [.root, .minorSecond, .perfectFourth, .perfectFifth, .minorSixth],
        category: .exotic
    )
    
    // MARK: - Colecciones de Escalas
    
    static let basicScales: [Scale] = [
        .major, .naturalMinor, .harmonicMinor, .melodicMinor
    ]
    
    static let pentatonicScales: [Scale] = [
        .majorPentatonic, .minorPentatonic
    ]
    
    static let modes: [Scale] = [
        .ionian, .dorian, .phrygian, .lydian, .mixolydian, .aeolian, .locrian
    ]
    
    static let exoticScales: [Scale] = [
        .arabic, .hungarian, .japanese
    ]
    
    static let allScales: [Scale] = basicScales + pentatonicScales + modes + exoticScales
    
    // MARK: - Métodos de Ayuda
    
    /// Obtiene escalas por categoría
    static func scales(for category: ScaleCategory) -> [Scale] {
        switch category {
        case .major: return [.major]
        case .minor: return [.naturalMinor, .harmonicMinor, .melodicMinor]
        case .pentatonic: return pentatonicScales
        case .modes: return modes
        case .exotic: return exoticScales
        }
    }
}
