//
//  Note.swift
//  IntervalQuest
//
//  Created by Bernat Mora on 2026-02-19.
//

import Foundation

/// Representa una nota musical
enum Note: String, CaseIterable {
    case C = "C"
    case Cs = "C#"
    case D = "D"
    case Ds = "D#"
    case E = "E"
    case F = "F"
    case Fs = "F#"
    case G = "G"
    case Gs = "G#"
    case A = "A"
    case As = "A#"
    case B = "B"
    
    /// Valor MIDI de la nota (C4 = 60)
    var midiNumber: Int {
        let baseOctave = 4
        let baseMIDI = baseOctave * 12
        
        switch self {
        case .C: return baseMIDI
        case .Cs: return baseMIDI + 1
        case .D: return baseMIDI + 2
        case .Ds: return baseMIDI + 3
        case .E: return baseMIDI + 4
        case .F: return baseMIDI + 5
        case .Fs: return baseMIDI + 6
        case .G: return baseMIDI + 7
        case .Gs: return baseMIDI + 8
        case .A: return baseMIDI + 9
        case .As: return baseMIDI + 10
        case .B: return baseMIDI + 11
        }
    }
    
    /// Calcula la nota resultante al aplicar un intervalo
    func applying(interval: Interval) -> Note {
        let currentIndex = Note.allCases.firstIndex(of: self) ?? 0
        let newIndex = (currentIndex + interval.semitones) % 12
        return Note.allCases[newIndex]
    }
    
    /// Obtiene el valor MIDI para una octava específica
    func midiNumber(octave: Int) -> Int {
        let noteOffset = Note.allCases.firstIndex(of: self) ?? 0
        return octave * 12 + noteOffset
    }
}
