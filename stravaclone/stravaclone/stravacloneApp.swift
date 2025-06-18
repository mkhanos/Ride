//
//  stravacloneApp.swift
//  stravaclone
//
//  Created by Momo Khan on 5/8/25.
//

import SwiftUI

@main
struct stravacloneApp: App {
    @ObservedObject private var settingsManager = SettingsManager.shared
    var body: some Scene {
        WindowGroup {
            TabViews()
                .modelContainer(sharedModelContainer)
                .preferredColorScheme(settingsManager.isDarkMode ? .dark : .light)
        }
        
    }
}
