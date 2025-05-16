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
    var body: some Scene {
        WindowGroup {
            TabViews()
                .modelContainer(for: Ride.self)
               // .environmentObject(locationManager)
        }
    }
}
