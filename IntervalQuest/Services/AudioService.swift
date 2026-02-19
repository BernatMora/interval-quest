//
//  AudioService.swift
//  IntervalQuest
//
//  Created by Bernat Mora on 2026-02-19.
//

import AVFoundation
import Foundation

/// Servicio de audio para reproducir notas, acordes y escalas
class AudioService: ObservableObject {
    
    private var audioEngine: AVAudioEngine
    private var sampler: AVAudioUnitSampler
    
    // Inicialización del motor de audio
    init() {
        audioEngine = AVAudioEngine()
        sampler = AVAudioUnitSampler()
        
        // Conectar el sampler al motor de audio
        audioEngine.attach(sampler)
        audioEngine.connect(sampler, to: audioEngine.mainMixerNode, format: nil)
        
        // Cargar un preset de piano
        loadPianoSound()
        
        // Iniciar el motor de audio
        do {
            try audioEngine.start()
        } catch {
            print("Error al iniciar el motor de audio: \(error.localizedDescription)")
        }
    }
    
    // MARK: - Carga de Sonidos
    
    /// Carga el sonido de piano
    private func loadPianoSound() {
        do {
            // Intentar cargar preset de piano personalizado si existe
            if let soundFontURL = Bundle.main.url(forResource: "piano", withExtension: "sf2") {
                try sampler.loadSoundBankInstrument(at: soundFontURL,
                                                   program: 0,
                                                   bankMSB: UInt8(kAUSampler_DefaultMelodicBankMSB),
                                                   bankLSB: UInt8(kAUSampler_DefaultBankLSB))
            } else {
                // Si no hay soundfont personalizado, usar instrumento de sistema
                // Esto usará el preset de piano predeterminado del sistema
                try sampler.loadPreset(AUAudioUnitPreset())
                print("Usando preset de audio del sistema (soundfont personalizado no disponible)")
            }
        } catch {
            print("Error al cargar el sonido de piano: \(error.localizedDescription)")
            print("El audio puede no funcionar correctamente. Considere agregar un archivo piano.sf2 al bundle.")
        }
    }
    
    // MARK: - Reproducción de Notas
    
    /// Reproduce una nota individual
    func playNote(_ note: Note, velocity: UInt8 = 100, duration: TimeInterval = 0.5) {
        let midiNote = UInt8(note.midiNumber)
        
        // Iniciar nota
        sampler.startNote(midiNote, withVelocity: velocity, onChannel: 0)
        
        // Detener nota después de la duración
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) { [weak self] in
            self?.sampler.stopNote(midiNote, onChannel: 0)
        }
    }
    
    /// Reproduce un acorde (todas las notas simultáneamente)
    func playChord(notes: [Note], velocity: UInt8 = 80, duration: TimeInterval = 1.0) {
        let midiNotes = notes.map { UInt8($0.midiNumber) }
        
        // Iniciar todas las notas
        for midiNote in midiNotes {
            sampler.startNote(midiNote, withVelocity: velocity, onChannel: 0)
        }
        
        // Detener todas las notas después de la duración
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) { [weak self] in
            for midiNote in midiNotes {
                self?.sampler.stopNote(midiNote, onChannel: 0)
            }
        }
    }
    
    /// Reproduce una escala (notas secuencialmente)
    func playScale(notes: [Note], noteDuration: TimeInterval = 0.3) {
        for (index, note) in notes.enumerated() {
            let delay = TimeInterval(index) * noteDuration
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [weak self] in
                self?.playNote(note, duration: noteDuration)
            }
        }
    }
    
    // MARK: - Sonidos de Feedback
    
    /// Reproduce sonido de éxito
    func playCorrectSound() {
        // Reproducir acorde mayor ascendente (C-E-G)
        let notes: [Note] = [.C, .E, .G]
        for (index, note) in notes.enumerated() {
            DispatchQueue.main.asyncAfter(deadline: .now() + TimeInterval(index) * 0.15) { [weak self] in
                self?.playNote(note, velocity: 100, duration: 0.2)
            }
        }
    }
    
    /// Reproduce sonido de error
    func playIncorrectSound() {
        // Reproducir dos notas disonantes (tritono)
        playNote(.C, velocity: 80, duration: 0.15)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) { [weak self] in
            self?.playNote(.Fs, velocity: 80, duration: 0.15)
        }
    }
    
    // MARK: - Control de Audio
    
    /// Detiene todos los sonidos
    func stopAllSounds() {
        sampler.stopAllNotes()
    }
    
    deinit {
        audioEngine.stop()
    }
}
