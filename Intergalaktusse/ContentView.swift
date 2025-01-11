//
//  ContentView.swift
//  Intergalaktusse
//
//  Created by Marius Preikschat on 27.11.24.
//

import SwiftUI
import ScreenSaver

struct ContentView: View {
    @State private var animateGradient = false
    
    private var textToDisplay: String {
        if let savedText = ScreenSaverDefaults(forModuleWithName: Bundle.main.bundleIdentifier!)?.string(forKey: "TextToDisplay") {
            return savedText
        } else {
            return "Standardtext"
        }
    }

//    var body: some View {
//        TimelineView(.animation(minimumInterval: Double.random(in: 15.0...35.0))) { _ in
//            ZStack {
//                LinearGradient(colors: [.purple, .yellow], startPoint: animateGradient ? .topLeading : .bottomLeading, endPoint: animateGradient ? .bottomTrailing : .topTrailing)
//                    .hueRotation(.degrees(animateGradient ? 45 : 0))
//                    .ignoresSafeArea()
//                    .onAppear {
//                        withAnimation(.easeInOut(duration: 5.0).repeatForever(autoreverses: true)) {
//                            animateGradient.toggle()
//                        }
//                    }
//                BouncingTextView(text: textToDisplay, duration: Double.random(in: 0.01...0.04))
//            }
//            .frame(maxWidth: .infinity, maxHeight: .infinity)
//        }
//    }
    
    var body: some View {
        BouncingTextView(
            text: textToDisplay,
            duration: Double.random(in: 0.01...0.04)
        )
        .background(GradientBackground())
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    ContentView()
        .frame(width: 800, height: 500)
}
