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
        ScrollView(.vertical) {
            LazyVStack(alignment: .center, spacing: 20) {
                ForEach(rides, id: \.id) { ride in
                    RideCard(ride: ride)
                        .scrollTransition(axis: .vertical) { content, phase in
                            content
                                .scaleEffect(
                                    x: phase.isIdentity ? 1.0 : 0.80,
                                    y: phase.isIdentity ? 1.0 : 0.80
                                )
                        }
                }
            }
            .scrollTargetLayout()
        }
        .contentMargins(.horizontal, 20)
        .scrollTargetBehavior(.viewAligned)
        .scrollIndicators(.hidden)
    }
}

#Preview {
    SavedRidesView()
}
