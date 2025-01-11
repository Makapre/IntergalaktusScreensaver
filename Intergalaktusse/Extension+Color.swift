//
//  Extension+Color.swift
//  Intergalaktusse
//
//  Created by Marius Preikschat on 27.11.24.
//

import SwiftUI

extension Color {
    static func random() -> Color {
        let red = Double.random(in: 0...0.5)
        let green = Double.random(in: 0...0.5)
        let blue = Double.random(in: 0...0.5)
        return Color(red: red, green: green, blue: blue)
    }
}
