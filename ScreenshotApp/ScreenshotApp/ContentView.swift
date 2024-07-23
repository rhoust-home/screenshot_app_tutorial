//
//  ContentView.swift
//  ScreenshotApp
//
//  Created by Rhett Houston  on 7/23/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var image: NSImage? = nil
    
    var body: some View {
        VStack {
            
            // if image has been set (screenshot taken) show image in window
            if let image = image {
                Image(nsImage: image)
                    .resizable()
                    .scaledToFit()
            }
            
            // Create a button that prompts the user to take a screenshot
            Button("Take a screenshot") {
                
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
        }
        .padding()
    }
    
    // Sets the var image to the image saved to the machine's clipboard
    func getImageFromPasteboard() {
     
        guard NSPasteboard.general.canReadItem(withDataConformingToTypes: NSImage.imageTypes) else { return }
        
        guard let image = NSImage(pasteboard: NSPasteboard.general) else { return }
        
        self.image = image
    }
}

#Preview {
    ContentView()
}
