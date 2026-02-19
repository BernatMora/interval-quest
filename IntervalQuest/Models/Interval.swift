//
//  Interval.swift
//  IntervalQuest
//
//  Created by Bernat Mora on 2026-02-19.
//

import Foundation

/// Representa un intervalo musical con su distancia en semitonos
enum Interval: String, CaseIterable, Identifiable {
    // Fundamental
    case root = "R"
    
    // Segundas
    case minorSecond = "♭2"
    case majorSecond = "2"
    
    // Terceras
    case minorThird = "♭3"
    case majorThird = "3"
    
    // Cuartas
    case perfectFourth = "4"
    case augmentedFourth = "#4"
    
    // Quintas
    case diminishedFifth = "♭5"
    case perfectFifth = "5"
    
    // Sextas
    case minorSixth = "♭6"
    case majorSixth = "6"
    
    // Séptimas
    case minorSeventh = "♭7"
    case majorSeventh = "7"
    
    // Extensiones
    case minorNinth = "♭9"
    case majorNinth = "9"
    case augmentedNinth = "#9"
    case perfectEleventh = "11"
    case augmentedEleventh = "#11"
    case minorThirteenth = "♭13"
    case majorThirteenth = "13"
    
    var id: String { rawValue }
    
    /// Distancia en semitonos desde la raíz
    var semitones: Int {
        switch self {
        case .root: return 0
        case .minorSecond, .minorNinth: return 1
        case .majorSecond, .majorNinth: return 2
        case .minorThird, .augmentedNinth: return 3
        case .majorThird: return 4
        case .perfectFourth, .perfectEleventh: return 5
        case .augmentedFourth, .diminishedFifth, .augmentedEleventh: return 6
        case .perfectFifth: return 7
        case .minorSixth, .minorThirteenth: return 8
        case .majorSixth, .majorThirteenth: return 9
        case .minorSeventh: return 10
        case .majorSeventh: return 11
        }
    }
    
    /// Nombre para mostrar en la UI
    var displayName: String { rawValue }
}
