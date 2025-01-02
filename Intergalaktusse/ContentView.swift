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
    
    private var textToDisplay: String = "Standardtext"
    
    init() {
        if let savedText = ScreenSaverDefaults(forModuleWithName: Bundle.main.bundleIdentifier!)?.string(forKey: "TextToDisplay") {
            self.textToDisplay = savedText
        }
    }
    
    var body: some View {
        TimelineView(.animation(minimumInterval: Double.random(in: 3.0...13.0))) { _ in
            ZStack {
//                LinearGradient(colors: [.purple, .yellow], startPoint: animateGradient ? .topLeading : .bottomLeading, endPoint: animateGradient ? .bottomTrailing : .topTrailing)
//                    .ignoresSafeArea()
//                    .onAppear {
//                        withAnimation(.linear(duration: 2.0).repeatForever(autoreverses: true)) {
//                            animateGradient.toggle()
//                        }
//                    }
                LinearGradient(colors: [.purple, .yellow], startPoint: animateGradient ? .topLeading : .bottomLeading, endPoint: animateGradient ? .bottomTrailing : .topTrailing)
                    .hueRotation(.degrees(animateGradient ? 45 : 0))
                    .ignoresSafeArea()
                    .onAppear {
                        withAnimation(.easeInOut(duration: 5.0).repeatForever(autoreverses: true)) {
                            animateGradient.toggle()
                        }
                    }
//                VStack(alignment: .center) {
//                    Text("Makapre")
//                        .font(.custom("", size: 82.0))
//                        .foregroundStyle(Color.random())
//                    
//                    //                Image(.dvdLogo)
//                    //                    .frame(height: 150)
//                    //                    .tint(.red)
//                }
                BouncingTextView(text: textToDisplay, duration: Double.random(in: 0.01...0.04))
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

#Preview {
    ContentView()
        .frame(width: 800, height: 500)
}
