//
//  IntervalSlotView.swift
//  IntervalQuest
//
//  Created by Bernat Mora on 2026-02-19.
//

import SwiftUI

/// Vista que muestra los slots para la respuesta del jugador
struct IntervalSlotView: View {
    let slots: [Interval]
    let numberOfSlots: Int
    let isCorrect: Bool?
    let onRemove: (Int) -> Void
    
    var body: some View {
        VStack(spacing: 10) {
            Text("Tu Respuesta")
                .font(.headline)
                .foregroundColor(.white.opacity(0.9))
            
            HStack(spacing: 12) {
                ForEach(0..<numberOfSlots, id: \.self) { index in
                    slotView(at: index)
                }
            }
        }
        .padding()
        .background(Color.white.opacity(0.1))
        .cornerRadius(15)
    }
    
    private func slotView(at index: Int) -> some View {
        let hasInterval = index < slots.count
        let interval = hasInterval ? slots[index] : nil
        
        return ZStack {
            // Slot background
            RoundedRectangle(cornerRadius: 12)
                .fill(backgroundColor(for: index))
                .frame(width: slotSize, height: slotSize)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(borderColor(for: index), lineWidth: 2)
                )
                .shadow(color: shadowColor(for: index), radius: 5)
            
            // Content
            if let interval = interval {
                Text(interval.displayName)
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.white)
            } else {
                Text("__")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.white.opacity(0.3))
            }
        }
        .onTapGesture {
            if hasInterval {
                onRemove(index)
            }
        }
        .animation(.spring(), value: slots.count)
    }
    
    // MARK: - Styling Helpers
    
    private var slotSize: CGFloat {
        // Ajustar tamaño según número de slots
        let baseSize: CGFloat = 60
        let maxSlots = 7
        if numberOfSlots > maxSlots {
            return baseSize * CGFloat(maxSlots) / CGFloat(numberOfSlots)
        }
        return baseSize
    }
    
    private func backgroundColor(for index: Int) -> Color {
        let hasInterval = index < slots.count
        
        if let isCorrect = isCorrect {
            return isCorrect ? Color.green.opacity(0.3) : Color.red.opacity(0.3)
        }
        
        return hasInterval ? Color.blue.opacity(0.4) : Color.gray.opacity(0.2)
    }
    
    private func borderColor(for index: Int) -> Color {
        let hasInterval = index < slots.count
        
        if let isCorrect = isCorrect {
            return isCorrect ? Color.green : Color.red
        }
        
        return hasInterval ? Color.blue : Color.white.opacity(0.3)
    }
    
    private func shadowColor(for index: Int) -> Color {
        let hasInterval = index < slots.count
        
        if let isCorrect = isCorrect {
            return isCorrect ? Color.green.opacity(0.5) : Color.red.opacity(0.5)
        }
        
        return hasInterval ? Color.blue.opacity(0.5) : Color.clear
    }
}

#Preview {
    ZStack {
        Color.purple.opacity(0.5).ignoresSafeArea()
        
        VStack(spacing: 30) {
            // Empty slots
            IntervalSlotView(
                slots: [],
                numberOfSlots: 3,
                isCorrect: nil,
                onRemove: { _ in }
            )
            
            // Partially filled
            IntervalSlotView(
                slots: [.root, .majorThird],
                numberOfSlots: 3,
                isCorrect: nil,
                onRemove: { _ in }
            )
            
            // Correct answer
            IntervalSlotView(
                slots: [.root, .majorThird, .perfectFifth],
                numberOfSlots: 3,
                isCorrect: true,
                onRemove: { _ in }
            )
            
            // Incorrect answer
            IntervalSlotView(
                slots: [.root, .minorThird, .perfectFifth],
                numberOfSlots: 3,
                isCorrect: false,
                onRemove: { _ in }
            )
        }
        .padding()
    }
}
