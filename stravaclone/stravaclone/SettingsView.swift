//
//  SettingsView.swift
//  stravaclone
//
//  Created by Momo Khan on 5/27/25.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var settingsManager: SettingsManager
    
    var body: some View {
        VStack(alignment: .leading) {
            Toggle("Dark Mode",
                   systemImage:"moon.fill",
                   isOn: $settingsManager.isDarkMode.animation()
            )
            Toggle("Use metric",
                   systemImage: "ruler.fill",
                   isOn: $settingsManager.isMetric)
            Spacer()
        }
        .padding()
    }
}
