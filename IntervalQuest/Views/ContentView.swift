//
//  ContentView.swift
//  IntervalQuest
//
//  Created by Bernat Mora on 2026-02-19.
//

import SwiftUI

/// Pantalla principal del menú
struct ContentView: View {
    @State private var showGame = false
    
    var body: some View {
        NavigationView {
            ZStack {
                // Fondo con gradiente
                LinearGradient(
                    gradient: Gradient(colors: [Color.blue.opacity(0.6), Color.purple.opacity(0.8)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                VStack(spacing: 40) {
                    Spacer()
                    
                    // Título
                    VStack(spacing: 10) {
                        Text("🎵")
                            .font(.system(size: 80))
                        
                        Text("Interval Quest")
                            .font(.system(size: 48, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                        
                        Text("Aprende teoría musical jugando")
                            .font(.title3)
                            .foregroundColor(.white.opacity(0.9))
                    }
                    
                    Spacer()
                    
                    // Botones del menú
                    VStack(spacing: 20) {
                        // Botón Jugar
                        NavigationLink(destination: GameView(), isActive: $showGame) {
                            MenuButton(title: "🎮 Jugar", color: .green)
                        }
                        
                        // Botón Práctica Libre (futuro)
                        MenuButton(title: "🎹 Práctica Libre", color: .blue)
                            .opacity(0.5)
                        
                        // Botón Configuración (futuro)
                        MenuButton(title: "⚙️ Configuración", color: .gray)
                            .opacity(0.5)
                    }
                    .padding(.horizontal, 40)
                    
                    Spacer()
                    
                    // Versión
                    Text("v1.0.0")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.6))
                        .padding(.bottom, 20)
                }
            }
            .navigationBarHidden(true)
        }
    }
}

/// Botón de menú reutilizable
struct MenuButton: View {
    let title: String
    let color: Color
    
    var body: some View {
        Text(title)
            .font(.title2.bold())
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 18)
            .background(color)
            .cornerRadius(15)
            .shadow(color: color.opacity(0.5), radius: 10, x: 0, y: 5)
    }
}

#Preview {
    ContentView()
}
