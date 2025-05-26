//
//  Rides.swift
//  stravaclone
//
//  Created by Momo Khan on 5/16/25.
//

import SwiftData
import SwiftUI

struct SavedRidesView: View {
    @Query(sort: \Ride.createdAt, order: .reverse) var rides: [Ride]
    var body: some View {
        List(rides, id: \.id) { ride in
            RideCard(ride: ride)
        }
    }
}

#Preview {
    SavedRidesView()
}
