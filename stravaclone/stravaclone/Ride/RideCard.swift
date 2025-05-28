//
//  RideCard.swift
//  stravaclone
//
//  Created by Momo Khan on 5/26/25.
//

import MapKit
import SwiftUI

struct RideCard: View {
    @EnvironmentObject var settingsManager: SettingsManager
    var ride: Ride
    var body: some View {
        VStack(alignment: .leading) {
            Text(ride.route[0].timestamp.localizedDateWithoutWeekdayAndTimezone)
            HStack {
                VerticalTextLabel(title: "Distance", subtitle: settingsManager.isMetric ? ride.totalDistance.metersToKilometers : ride.totalDistance.metersToMiles)
                VerticalTextLabel(title: "Time", subtitle: ride.totalTime.formattedTime)
                VerticalTextLabel(title: "Avg Speed", subtitle: settingsManager.isMetric ? "\(ride.totalDistance.metersToKilometers)/h" : "\(ride.totalDistance.metersToMiles)/h")
            }
            Map(interactionModes: []) {
                MapPolyline(coordinates: ride.route.map { $0.clLocationCordinate})
                    .stroke(.blue, lineWidth: 4)
            }
        }
        .aspectRatio( 16.0 / 9.0, contentMode: .fit)
        .containerRelativeFrame(.horizontal)
    }
}

#Preview {
    RideCard(ride: Ride.mock)
}
