//
//  stravacloneApp.swift
//  stravaclone
//
//  Created by Momo Khan on 5/8/25.
//

import SwiftUI

@main
struct stravacloneApp: App {
    var body: some Scene {
        WindowGroup {
            TabViews()
                .modelContainer(sharedModelContainer)
                .preferredColorScheme(SettingsManager.shared.isDarkMode ? .dark : .light)
        }
        
    }
}
