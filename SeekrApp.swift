//
//  SeekrApp.swift
//  Seekr
//
//  Created by Darius Ehsani on 4/19/25.
//

import SwiftUI

@main
struct SeekrApp: App {
    // Implement Progress Value
    @StateObject var progresModel = ProgressModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                // share it across app
                .environmentObject(progresModel)
        }
    }
}
