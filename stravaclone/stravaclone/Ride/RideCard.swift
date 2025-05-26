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
            HStack {
                VerticalTextLabel(title: "Distance", subtitle: ride.totalDistance.twoDecimalString)
                VerticalTextLabel(title: "Time", subtitle: ride.totalTime.twoDecimalString)
                VerticalTextLabel(title: "Avg Speed", subtitle: ride.averageSpeed.twoDecimalString)
            }
            Map() {
                MapPolyline(coordinates: ride.route.map { $0.clLocationCordinate})
                    .stroke(.blue, lineWidth: 4)
            }
            .frame(height: 200)
        }
    }
}

#Preview {
    RideCard(ride: Ride.mock)
}
