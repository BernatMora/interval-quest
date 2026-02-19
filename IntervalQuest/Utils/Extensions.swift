//
//  Extensions.swift
//  IntervalQuest
//
//  Created by Bernat Mora on 2026-02-19.
//

import Foundation
import SwiftUI

// MARK: - Color Extensions

extension Color {
    /// Colores personalizados para la app
    static let intervalQuestPrimary = Color.blue
    static let intervalQuestSecondary = Color.purple
    static let intervalQuestAccent = Color.green
}

// MARK: - Array Extensions

extension Array where Element: Equatable {
    /// Elimina la primera ocurrencia de un elemento
    mutating func removeFirst(where predicate: (Element) -> Bool) {
        if let index = firstIndex(where: predicate) {
            remove(at: index)
        }
    }
}

// MARK: - View Extensions

extension View {
    /// Oculta el teclado
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
