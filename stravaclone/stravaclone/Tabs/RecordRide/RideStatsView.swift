//
//  RideStats.swift
//  stravaclone
//
//  Created by Momo Khan on 6/18/25.
//

import SwiftUI

struct RideStatsView: View {
    @ObservedObject var rideManager: RideManager
    @ObservedObject var settingsManager = SettingsManager.shared
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Pace")
                Spacer()
                Text(settingsManager.isMetric ? "\(rideManager.ride?.averageSpeed.metersToKilometers ?? "0.00") km/h" : "\(rideManager.ride?.averageSpeed.metersToMiles ?? "0.0") mph")
            }
            HStack {
                Text("Time")
                Spacer()
                Text("\(rideManager.ride?.totalTime.formattedTime ?? "0s")")
            }
            HStack {
                Text("Distance")
                Spacer()
                Text(settingsManager.isMetric ? "\(rideManager.ride?.totalDistance.metersToKilometers ?? "0.00") km" : "\(rideManager.ride?.totalDistance.metersToMiles ?? "0.0") mi")
            }
            Spacer()
            HStack {
                Spacer()
                Button(!rideManager.isTracking ? "Start" : "Stop") {
                    !rideManager.isTracking ? rideManager.start() : rideManager.stop()
                }
                Spacer()
            }
        }
        .padding()
    }
}

