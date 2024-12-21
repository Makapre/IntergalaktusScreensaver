//
//  BouncingTextView.swift
//  Intergalaktusse
//
//  Created by Marius Preikschat on 21.12.24.
//

import SwiftUI

struct BouncingTextView: View {
    @State private var position = CGPoint(x: 100, y: 100) // Startposition
    @State private var velocity = CGSize(width: 3, height: 4) // Geschwindigkeit (x und y)
    @State private var screenSize = CGSize.zero // Größe des Screens
    @State private var color = Color.random()
    
    var text: String = ""
    var duration: Double = 0.01
    
    var body: some View {
        GeometryReader { geometry in
            let size = geometry.size
            
            Text(text)
                .font(.system(size: 82))
                .foregroundStyle(color)
                .position(position) // Position des Textes
                .onAppear {
                    screenSize = size
                    startAnimation()
                }
        }
    }
    
    func startAnimation() {
        Timer.scheduledTimer(withTimeInterval: duration, repeats: true) { _ in
            Task { @MainActor in
                moveText()
            }
        }
    }
    
    @MainActor
    func moveText() {
        // Neue Position berechnen
        position.x += velocity.width
        position.y += velocity.height
        
        // Kollision mit linken und rechten Rändern
        if position.x <= 0 || position.x >= screenSize.width {
            velocity.width *= -1 // Richtung umkehren
            color = Color.random()
        }
        
        // Kollision mit oberen und unteren Rändern
        if position.y <= 0 || position.y >= screenSize.height {
            velocity.height *= -1 // Richtung umkehren
            color = Color.random()
        }
    }
}

#Preview {
    BouncingTextView(text: "Marius")
        .frame(width: 600, height: 400)
}
