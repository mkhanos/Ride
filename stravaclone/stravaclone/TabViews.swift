//
//  TabViews.swift
//  stravaclone
//
//  Created by Momo Khan on 5/16/25.
//

import SwiftUI

struct TabViews: View {
    @Environment(\.modelContext) var modelContext
    var body: some View {
        TabView {
            RecordRideView(context: modelContext)
                .tabItem {
                    Label("Record Ride", systemImage: "record.circle")
                }
            SavedRidesView()
                .tabItem {
                    Label("Saved Rides", systemImage: "bicycle")
                }
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
    }
}

#Preview {
    TabViews()
}
