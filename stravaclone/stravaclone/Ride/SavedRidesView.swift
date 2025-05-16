//
//  Rides.swift
//  stravaclone
//
//  Created by Momo Khan on 5/16/25.
//

import SwiftData
import SwiftUI

struct SavedRidesView: View {
    @Query var rides: [Ride]
    var body: some View {
        List(rides, id: \.id) { ride in
            Text("\(ride.distance)")
        }
        
    }
}

#Preview {
    SavedRidesView()
}
