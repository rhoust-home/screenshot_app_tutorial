//
//  ContentView.swift
//  ScreenshotApp
//
//  Created by Rhett Houston  on 7/23/24.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var vm = ScreenCapViewModel()
    
    var body: some View {
        VStack {
            
            ForEach(vm.images, id: \.self) { image in
                Image(nsImage: image)
                    .resizable()
                    .scaledToFit()
            }
            
            // Create a button that prompts the user to take a screenshot
            Button("Take a screenshot") {
                vm.takeScreenshot()
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
