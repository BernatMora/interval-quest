//
//  GameView.swift
//  IntervalQuest
//
//  Created by Bernat Mora on 2026-02-19.
//

import SwiftUI

/// Vista principal del juego
struct GameView: View {
    @StateObject private var viewModel = GameViewModel()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            // Fondo
            LinearGradient(
                gradient: Gradient(colors: [Color.blue.opacity(0.3), Color.purple.opacity(0.5)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 20) {
                // Header con desafío y stats
                headerView
                
                // Nota raíz
                if let level = viewModel.currentLevel {
                    rootNoteView(rootNote: level.challenge.rootNote)
                }
                
                // Slots de respuesta
                IntervalSlotView(
                    slots: viewModel.playerAnswer,
                    numberOfSlots: viewModel.numberOfSlots,
                    isCorrect: viewModel.isCorrect,
                    onRemove: { index in
                        viewModel.removeInterval(at: index)
                    }
                )
                .disabled(viewModel.isAnswerChecked)
                
                Spacer()
                
                // Banco de intervalos
                IntervalBankView(
                    intervals: viewModel.availableIntervals,
                    onIntervalTapped: { interval in
                        viewModel.addInterval(interval)
                    }
                )
                .disabled(viewModel.isAnswerChecked)
                
                // Botones de acción
                actionButtonsView
                
                // Feedback
                if viewModel.showFeedback {
                    feedbackView
                }
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.white)
                        .font(.title2)
                }
            }
        }
    }
    
    // MARK: - Header View
    
    private var headerView: some View {
        VStack(spacing: 10) {
            // Desafío
            Text(viewModel.currentLevel?.name ?? "")
                .font(.title2.bold())
                .foregroundColor(.white)
            
            Text("Construye: \(viewModel.challengeName)")
                .font(.title3)
                .foregroundColor(.white.opacity(0.9))
            
            // Stats
            HStack(spacing: 30) {
                statView(icon: "star.fill", value: "\(viewModel.score)", color: .yellow)
                statView(icon: "flame.fill", value: "\(viewModel.combo)x", color: .orange)
                
                if viewModel.timeRemaining > 0 {
                    statView(icon: "timer", value: "\(viewModel.timeRemaining)s", color: .red)
                }
            }
        }
        .padding()
        .background(Color.white.opacity(0.1))
        .cornerRadius(15)
    }
    
    private func statView(icon: String, value: String, color: Color) -> some View {
        HStack(spacing: 5) {
            Image(systemName: icon)
                .foregroundColor(color)
            Text(value)
                .font(.headline)
                .foregroundColor(.white)
        }
    }
    
    // MARK: - Root Note View
    
    private func rootNoteView(rootNote: Note) -> some View {
        VStack(spacing: 5) {
            Text("Nota Raíz")
                .font(.caption)
                .foregroundColor(.white.opacity(0.7))
            
            Text(rootNote.rawValue)
                .font(.system(size: 60, weight: .bold))
                .foregroundColor(.white)
                .frame(width: 100, height: 100)
                .background(Color.blue.opacity(0.3))
                .cornerRadius(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.white, lineWidth: 3)
                )
                .shadow(radius: 10)
        }
    }
    
    // MARK: - Action Buttons
    
    private var actionButtonsView: some View {
        HStack(spacing: 15) {
            // Botón Escuchar
            Button(action: {
                viewModel.playCurrentAnswer()
            }) {
                actionButton(icon: "speaker.wave.2.fill", color: .blue)
            }
            .disabled(viewModel.playerAnswer.isEmpty)
            
            // Botón Borrar
            Button(action: {
                viewModel.resetAnswer()
            }) {
                actionButton(icon: "trash.fill", color: .red)
            }
            .disabled(viewModel.playerAnswer.isEmpty || viewModel.isAnswerChecked)
            
            // Botón Comprobar / Siguiente
            if !viewModel.isAnswerChecked {
                Button(action: {
                    viewModel.checkAnswer()
                }) {
                    Text("Comprobar")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 15)
                        .background(viewModel.isAnswerComplete ? Color.green : Color.gray)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                }
                .disabled(!viewModel.isAnswerComplete)
            } else if viewModel.isCorrect == true {
                Button(action: {
                    viewModel.nextLevel()
                }) {
                    Text("Siguiente Nivel")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 15)
                        .background(Color.green)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                }
            } else {
                Button(action: {
                    viewModel.resetAnswer()
                    viewModel.isAnswerChecked = false
                    viewModel.showFeedback = false
                }) {
                    Text("Intentar de Nuevo")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 15)
                        .background(Color.orange)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                }
            }
        }
        .padding(.horizontal)
    }
    
    private func actionButton(icon: String, color: Color) -> some View {
        Image(systemName: icon)
            .font(.title2)
            .foregroundColor(.white)
            .frame(width: 50, height: 50)
            .background(color)
            .cornerRadius(10)
            .shadow(radius: 5)
    }
    
    // MARK: - Feedback View
    
    private var feedbackView: some View {
        HStack(spacing: 10) {
            if viewModel.isCorrect == true {
                Image(systemName: "checkmark.circle.fill")
                    .font(.title)
                    .foregroundColor(.green)
                Text("¡Correcto!")
                    .font(.title2.bold())
                    .foregroundColor(.green)
            } else {
                Image(systemName: "xmark.circle.fill")
                    .font(.title)
                    .foregroundColor(.red)
                Text("Incorrecto. Inténtalo de nuevo.")
                    .font(.title3.bold())
                    .foregroundColor(.red)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(radius: 10)
        .transition(.scale.combined(with: .opacity))
        .animation(.spring(), value: viewModel.showFeedback)
    }
}

#Preview {
    NavigationView {
        GameView()
    }
}
