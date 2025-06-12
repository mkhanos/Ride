//
//  stravacloneApp.swift
//  stravaclone
//
//  Created by Momo Khan on 5/8/25.
//

import SwiftUI

@main
struct stravacloneApp: App {
    @StateObject var settingsManager = SettingsManager()
    var body: some Scene {
        WindowGroup {
            TabViews()
                .modelContainer(sharedModelContainer)
                .environmentObject(settingsManager)
                .preferredColorScheme(settingsManager.isDarkMode ? .dark : .light)
        }
        
    }
}
