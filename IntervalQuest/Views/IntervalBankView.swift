//
//  IntervalBankView.swift
//  IntervalQuest
//
//  Created by Bernat Mora on 2026-02-19.
//

import SwiftUI

/// Vista que muestra el banco de intervalos disponibles
struct IntervalBankView: View {
    let intervals: [Interval]
    let onIntervalTapped: (Interval) -> Void
    
    private let columns = [
        GridItem(.adaptive(minimum: 70), spacing: 12)
    ]
    
    var body: some View {
        VStack(spacing: 10) {
            Text("Intervalos Disponibles")
                .font(.headline)
                .foregroundColor(.white.opacity(0.9))
            
            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(intervals) { interval in
                    intervalButton(interval)
                }
            }
        }
        .padding()
        .background(Color.white.opacity(0.1))
        .cornerRadius(15)
    }
    
    private func intervalButton(_ interval: Interval) -> some View {
        Button(action: {
            onIntervalTapped(interval)
        }) {
            ZStack {
                // Background with gradient
                RoundedRectangle(cornerRadius: 12)
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                intervalColor(for: interval),
                                intervalColor(for: interval).opacity(0.7)
                            ]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(height: 70)
                    .shadow(color: intervalColor(for: interval).opacity(0.5), radius: 5, x: 0, y: 3)
                
                // Interval label
                Text(interval.displayName)
                    .font(.system(size: 26, weight: .bold))
                    .foregroundColor(.white)
            }
        }
        .buttonStyle(IntervalButtonStyle())
    }
    
    // MARK: - Styling Helpers
    
    private func intervalColor(for interval: Interval) -> Color {
        switch interval {
        case .root:
            return Color.purple
        case .minorSecond, .majorSecond, .minorNinth, .majorNinth, .augmentedNinth:
            return Color.blue
        case .minorThird, .majorThird:
            return Color.green
        case .perfectFourth, .augmentedFourth, .perfectEleventh, .augmentedEleventh:
            return Color.orange
        case .diminishedFifth, .perfectFifth:
            return Color.red
        case .minorSixth, .majorSixth, .minorThirteenth, .majorThirteenth:
            return Color.teal
        case .minorSeventh, .majorSeventh:
            return Color.indigo
        }
    }
}

/// Custom button style with press animation
struct IntervalButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.spring(response: 0.3, dampingFraction: 0.6), value: configuration.isPressed)
    }
}

#Preview {
    ZStack {
        Color.purple.opacity(0.5).ignoresSafeArea()
        
        IntervalBankView(
            intervals: [
                .root, .majorSecond, .minorThird, .majorThird,
                .perfectFourth, .diminishedFifth, .perfectFifth,
                .minorSixth, .majorSixth, .minorSeventh, .majorSeventh
            ],
            onIntervalTapped: { interval in
                print("Tapped: \(interval.displayName)")
            }
        )
        .padding()
    }
}
