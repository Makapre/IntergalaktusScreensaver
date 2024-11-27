//
//  MakapreScreensaver.swift
//  Intergalaktusse
//
//  Created by Marius Preikschat on 27.11.24.
//

import Foundation
import ScreenSaver
import SwiftUI
import Cocoa

class Screensaver: ScreenSaverView {
    override init?(frame: NSRect, isPreview: Bool) {
        super.init(frame: frame, isPreview: isPreview)
        
        // Enable layer-backed view for better rendering compatibility with SwiftUI
        wantsLayer = true
        
        let timeView = ContentView()
        let hostingController = NSHostingController(rootView: timeView)
        
        // Set frame directly to bounds and enable autoresizing
        hostingController.view.frame = bounds
        hostingController.view.autoresizingMask = [.width, .height]
        addSubview(hostingController.view)
    }
    
    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
        fatalError("Not implemented.")
    }
}
