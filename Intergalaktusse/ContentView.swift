//
//  ContentView.swift
//  Intergalaktusse
//
//  Created by Marius Preikschat on 27.11.24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TimelineView(.animation(minimumInterval: 3.0)) { _ in
            VStack(alignment: .center) {
                Text("Makapre")
                    .font(.custom("", size: 82.0))
                    .foregroundStyle(Color.random())
                
//                Image(.dvdLogo)
//                    .frame(height: 150)
//                    .tint(.red)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

#Preview {
    ContentView()
}
