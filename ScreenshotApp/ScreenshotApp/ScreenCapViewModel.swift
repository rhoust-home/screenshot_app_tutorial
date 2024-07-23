//
//  ScreenCapViewModel.swift
//  ScreenshotApp
//
//  Created by Rhett Houston  on 7/23/24.
//

import SwiftUI

class ScreenCapViewModel: ObservableObject {
    
    @Published var images = [NSImage]()
    
    func takeScreenshot() {
        // Create a new process called task
        let task = Process()
        
        // Point the task to an already existing macOS command line tool
        task.executableURL = URL(fileURLWithPath: "/usr/sbin/screencapture")
        task.arguments = ["-cw"]
        
        // Run the task - protect against errors
        do {
            try task.run()
            task.waitUntilExit()
            getImageFromPasteboard()
        } catch {
            print("could not take screenshot: \(error)")
        }
    }
    
    private func getImageFromPasteboard() {
        guard NSPasteboard.general.canReadItem(withDataConformingToTypes: NSImage.imageTypes) else { return }
        
        guard let image = NSImage(pasteboard: NSPasteboard.general) else { return }
        
        self.images.append(image)
    }
    
}
