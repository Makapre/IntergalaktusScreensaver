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
    private var textToDisplay: String = "Standardtext"
    private var configWindow: NSWindow? // Referenz zum Konfigurationsfenster

    override var hasConfigureSheet: Bool {
        true
    }
    
    override var configureSheet: NSWindow? {
        if configWindow == nil {
            // Konfigurationsfenster erstellen
            let configureWindow = NSWindow(
                contentRect: NSMakeRect(0, 0, 400, 200),
                styleMask: [.titled, .closable],
                backing: .buffered,
                defer: false
            )
            configureWindow.title = "Bildschirmschoner-Einstellungen"
            
            // Textfeld
            let textField = NSTextField(frame: NSRect(x: 20, y: 120, width: 360, height: 24))
            textField.stringValue = textToDisplay
            textField.placeholderString = "Gib deinen Text ein"
            textField.identifier = NSUserInterfaceItemIdentifier(rawValue: "TextField")
            configureWindow.contentView?.addSubview(textField)
            
            // Speichern-Button
            let saveButton = NSButton(frame: NSRect(x: 80, y: 50, width: 100, height: 30))
            saveButton.title = "Speichern"
            saveButton.action = #selector(saveConfiguration)
            saveButton.target = self
            configureWindow.contentView?.addSubview(saveButton)
            
            // Abbrechen-Button
            let cancelButton = NSButton(frame: NSRect(x: 220, y: 50, width: 100, height: 30))
            cancelButton.title = "Abbrechen"
            cancelButton.action = #selector(cancelConfiguration)
            cancelButton.target = self
            configureWindow.contentView?.addSubview(cancelButton)
            
            configWindow = configureWindow
        }
        
        return configWindow
    }
    
    @objc private func saveConfiguration() {
        guard let textField = configWindow?.contentView?.subviews.compactMap({ $0 as? NSTextField }).first else { return }
        
        // Text speichern
        textToDisplay = textField.stringValue
        let defaults = ScreenSaverDefaults(forModuleWithName: Bundle.main.bundleIdentifier!)!
        defaults.set(textToDisplay, forKey: "TextToDisplay")
        defaults.synchronize()
        
        // Fenster schließen
        closeConfigWindow()
    }
    
    @objc private func cancelConfiguration() {
        // Fenster schließen ohne Änderungen
        closeConfigWindow()
    }
    
    private func closeConfigWindow() {
        configWindow?.close()
        configWindow = nil // Referenz löschen, damit sie erneut erstellt werden kann
    }
    
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
