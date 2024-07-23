//
//  ContentView.swift
//  ScreenshotApp
//
//  Created by Rhett Houston  on 7/23/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            
            Button("Make a screenshot") {
                let task = Process()
                task.executableURL = URL(fileURLWithPath: "/usr/sbin/screencapture")
                task.arguments = ["-cw"]
                
                do {
                    try task.run()
                    task.waitUntilExit()
                } catch {
                    print("could not take screenshot: \(error)")
                }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
