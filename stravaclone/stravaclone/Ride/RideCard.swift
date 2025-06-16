//
//  RideCard.swift
//  stravaclone
//
//  Created by Momo Khan on 5/26/25.
//

import MapKit
import SwiftUI

struct RideCard: View {
    var ride: Ride
    var body: some View {
        VStack(alignment: .leading) {
            Text(ride.route[0].timestamp.localizedDateWithoutWeekdayAndTimezone)
            HStack {
                VerticalTextLabel(title: "Distance", subtitle: SettingsManager.shared.isMetric ? ride.totalDistance.metersToKilometers : ride.totalDistance.metersToMiles)
                VerticalTextLabel(title: "Time", subtitle: ride.totalTime.formattedTime)
                VerticalTextLabel(title: "Avg Speed", subtitle: SettingsManager.shared.isMetric ? "\(ride.averageSpeed.metersToKilometers) km/h" : "\(ride.averageSpeed.metersToMiles) mph")
            }
            Map(interactionModes: []) {
                MapPolyline(coordinates: ride.route.map { $0.clLocationCordinate})
                    .stroke(.blue, lineWidth: 4)
                Marker("Start",
                       systemImage: "mappin.and.ellipse",
                       coordinate: ride.route[0].clLocationCordinate)
                Marker("Finish",
                       systemImage: "flag.pattern.checkered",
                       coordinate: ride.route[ride.route.count-1].clLocationCordinate)
            }
            .frame(height: 250)
        }
        .aspectRatio( 16.0 / 9.0, contentMode: .fit)
        .containerRelativeFrame(.horizontal)
    }
}

#Preview {
    RideCard(ride: Ride.mock)
}
