//
//  GradientBackground.swift
//  Intergalaktusse
//
//  Created by Marius Preikschat on 11.01.25.
//

import SwiftUI

struct GradientBackground: View {
    @State private var isAnimating: Bool = false
    
    let colorsRedish1 = (0..<9).map { _ in [Color.orange, .red, .yellow].randomElement()!}
    let colorsRedish2 = (0..<9).map { _ in [Color.orange, .red, .yellow].randomElement()!}
    
    let colorsBlueish1 = (0..<9).map { _ in [Color.green, .blue, .cyan].randomElement()!}
    let colorsBlueish2 = (0..<9).map { _ in [Color.green, .blue, .cyan].randomElement()!}
    
    let colorsMixed1 = (0..<9).map { _ in [Color.green, .purple, .red].randomElement()!}
    let colorsMixed2 = (0..<9).map { _ in [Color.green, .purple, .red].randomElement()!}
        
    var body: some View {
        MeshGradient(
            width: 3,
            height: 3,
            points: [
                .init(x: 0, y: 0),
                .init(x: 0.5, y: 0),
                .init(x: 1, y: 0),
                .init(x: 0, y: 0.5),
                .init(x: 0.5, y: 0.5),
                .init(x: 1, y: 0.5),
                .init(x: 0, y: 1),
                .init(x: 0.5, y: 1),
                .init(x: 1, y: 1),
            ],
            colors: isAnimating ? colorsMixed1 : colorsMixed2
        )
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea(.all)
        .onAppear {
            withAnimation(.easeInOut(duration: 5).repeatForever()) {
                isAnimating.toggle()
            }
        }
    }
}

#Preview {
    GradientBackground()
}
