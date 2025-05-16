//
//  stravacloneApp.swift
//  stravaclone
//
//  Created by Momo Khan on 5/8/25.
//

import SwiftUI

@main
struct stravacloneApp: App {
    //@StateObject var locationManager = LocationManager()
    @Environment(\.modelContext) var modelContext
    var body: some Scene {
        WindowGroup {
            ContentView(context: modelContext)
                .modelContainer(for: Ride.self)
               // .environmentObject(locationManager)
        }
    }
}
