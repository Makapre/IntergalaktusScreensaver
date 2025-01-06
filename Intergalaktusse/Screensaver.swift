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
            let window = NSWindow(
                contentRect: NSRect(x: 0, y: 0, width: 400, height: 200),
                styleMask: [.titled],
                backing: .buffered,
                defer: false
            )
            window.title = "Bildschirmschoner-Einstellungen"
            
            // Textfeld hinzufügen
            let textField = NSTextField(frame: NSRect(x: 20, y: 120, width: 360, height: 24))
            textField.stringValue = textToDisplay
            textField.placeholderString = "Gib deinen Text ein"
            textField.tag = 1001 // Identifier für den Zugriff
            window.contentView?.addSubview(textField)
            
            // Speichern-Button hinzufügen
            let saveButton = NSButton(frame: NSRect(x: 80, y: 50, width: 100, height: 30))
            saveButton.title = "Speichern"
            saveButton.action = #selector(saveConfiguration)
            saveButton.target = self
            window.contentView?.addSubview(saveButton)
            
            // Abbrechen-Button hinzufügen
            let cancelButton = NSButton(frame: NSRect(x: 220, y: 50, width: 100, height: 30))
            cancelButton.title = "Abbrechen"
            cancelButton.action = #selector(cancelConfiguration)
            cancelButton.target = self
            window.contentView?.addSubview(cancelButton)
            
            configWindow = window
        }
        return configWindow
    }
    
    @objc private func saveConfiguration() {
        guard let textField = configWindow?.contentView?.viewWithTag(1001) as? NSTextField else { return }
        
        // Text speichern
        let newText = textField.stringValue.trimmingCharacters(in: .whitespacesAndNewlines)
        textToDisplay = newText.isEmpty ? "Standardtext" : newText // Fallback auf Standardtext
        let defaults = ScreenSaverDefaults(forModuleWithName: Bundle.main.bundleIdentifier!)!
        defaults.set(textToDisplay, forKey: "TextToDisplay")
        defaults.synchronize()
        
        // Fenster schließen
        closeConfigurationWindow()
    }
    
    @objc private func cancelConfiguration() {
        // Fenster schließen ohne Änderungen
        closeConfigurationWindow()
    }
    
    private func closeConfigurationWindow() {
        guard let window = configWindow else { return }
        window.sheetParent?.endSheet(window) // Beendet das Sheet sicher
        configWindow = nil                   // Entfernt die Referenz
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
