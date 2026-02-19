//
//  GameViewModel.swift
//  IntervalQuest
//
//  Created by Bernat Mora on 2026-02-19.
//

import Foundation
import Combine

/// ViewModel para gestionar el estado del juego
class GameViewModel: ObservableObject {
    
    // MARK: - Published Properties
    
    @Published var currentLevel: GameLevel?
    @Published var currentChallenge: Chord?
    @Published var currentScale: Scale?
    @Published var playerAnswer: [Interval] = []
    @Published var availableIntervals: [Interval] = []
    @Published var score: Int = 0
    @Published var combo: Int = 0
    @Published var timeRemaining: Int = 0
    @Published var isCorrect: Bool? = nil
    @Published var showFeedback: Bool = false
    @Published var isAnswerChecked: Bool = false
    
    // MARK: - Private Properties
    
    private var timer: Timer?
    private var audioService = AudioService()
    
    // MARK: - Initialization
    
    init() {
        // Cargar nivel de ejemplo al iniciar
        loadExampleLevel()
    }
    
    // MARK: - Level Management
    
    /// Carga el nivel de ejemplo inicial
    func loadExampleLevel() {
        startLevel(GameLevel.exampleLevel)
    }
    
    /// Inicia un nivel específico
    func startLevel(_ level: GameLevel) {
        currentLevel = level
        
        // Configurar el desafío según el tipo
        if let chord = level.challenge.targetChord {
            currentChallenge = chord
            currentScale = nil
        } else if let scale = level.challenge.targetScale {
            currentScale = scale
            currentChallenge = nil
        }
        
        // Mezclar y configurar intervalos disponibles
        availableIntervals = MusicTheoryEngine.shuffleIntervals(level.challenge.availableIntervals)
        
        // Reiniciar respuesta del jugador
        playerAnswer = []
        isCorrect = nil
        showFeedback = false
        isAnswerChecked = false
        
        // Configurar timer si hay límite de tiempo
        if let timeLimit = level.challenge.timeLimit {
            timeRemaining = timeLimit
            startTimer()
        } else {
            timeRemaining = 0
            stopTimer()
        }
    }
    
    /// Carga el siguiente nivel (implementación básica)
    func nextLevel() {
        // Por ahora, simplemente recarga el nivel de ejemplo
        // En una implementación completa, cargaría el siguiente nivel de una progresión
        loadExampleLevel()
        
        // Reproducir sonido de éxito
        audioService.playCorrectSound()
    }
    
    // MARK: - Answer Management
    
    /// Añade un intervalo a la respuesta del jugador
    func addInterval(_ interval: Interval) {
        guard !isAnswerChecked else { return }
        
        // Verificar que el intervalo esté disponible
        guard availableIntervals.contains(where: { $0.id == interval.id }) else {
            return
        }
        
        // Añadir a la respuesta
        playerAnswer.append(interval)
    }
    
    /// Elimina un intervalo de la respuesta en un índice específico
    func removeInterval(at index: Int) {
        guard index >= 0 && index < playerAnswer.count else { return }
        guard !isAnswerChecked else { return }
        
        playerAnswer.remove(at: index)
    }
    
    /// Limpia la respuesta del jugador
    func resetAnswer() {
        guard !isAnswerChecked else { return }
        playerAnswer = []
        isCorrect = nil
        showFeedback = false
    }
    
    // MARK: - Answer Validation
    
    /// Verifica si la respuesta del jugador es correcta
    @discardableResult
    func checkAnswer() -> Bool {
        guard let level = currentLevel else { return false }
        
        let targetIntervals = level.challenge.targetIntervals
        let isAnswerCorrect = MusicTheoryEngine.intervalsMatch(playerAnswer, targetIntervals)
        
        isCorrect = isAnswerCorrect
        showFeedback = true
        isAnswerChecked = true
        
        // Actualizar puntuación y combo
        if isAnswerCorrect {
            combo += 1
            let earnedScore = MusicTheoryEngine.calculateScore(
                difficulty: level.difficulty,
                timeRemaining: timeRemaining > 0 ? timeRemaining : nil,
                combo: combo
            )
            score += earnedScore
            
            // Reproducir audio del acorde/escala correcto
            playTargetSound()
            
            // Detener el timer
            stopTimer()
        } else {
            combo = 0
            
            // Reproducir sonido de error
            audioService.playIncorrectSound()
        }
        
        return isAnswerCorrect
    }
    
    // MARK: - Audio Playback
    
    /// Reproduce el sonido del objetivo (acorde o escala)
    func playTargetSound() {
        guard let level = currentLevel else { return }
        
        let rootNote = level.challenge.rootNote
        let intervals = level.challenge.targetIntervals
        let notes = MusicTheoryEngine.getNotesForChord(root: rootNote, intervals: intervals)
        
        if level.challenge.targetChord != nil {
            audioService.playChord(notes: notes)
        } else if level.challenge.targetScale != nil {
            audioService.playScale(notes: notes)
        }
    }
    
    /// Reproduce el sonido de la respuesta actual del jugador
    func playCurrentAnswer() {
        guard let level = currentLevel else { return }
        guard !playerAnswer.isEmpty else { return }
        
        let rootNote = level.challenge.rootNote
        let notes = MusicTheoryEngine.getNotesForChord(root: rootNote, intervals: playerAnswer)
        
        if level.challenge.targetChord != nil {
            audioService.playChord(notes: notes)
        } else {
            audioService.playScale(notes: notes)
        }
    }
    
    // MARK: - Timer Management
    
    /// Inicia el temporizador
    private func startTimer() {
        stopTimer() // Detener cualquier timer existente
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
            } else {
                // Tiempo agotado
                self.stopTimer()
                if !self.isAnswerChecked {
                    self.checkAnswer()
                }
            }
        }
    }
    
    /// Detiene el temporizador
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    // MARK: - Computed Properties
    
    /// Obtiene el nombre del desafío actual
    var challengeName: String {
        currentLevel?.challenge.targetName ?? ""
    }
    
    /// Obtiene el número de slots necesarios
    var numberOfSlots: Int {
        currentLevel?.challenge.targetIntervals.count ?? 0
    }
    
    /// Verifica si la respuesta está completa
    var isAnswerComplete: Bool {
        playerAnswer.count == numberOfSlots
    }
    
    deinit {
        stopTimer()
    }
}
