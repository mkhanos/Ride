//
//  RecordRideView.swift
//  stravaclone
//
//  Created by Momo Khan on 5/8/25.
//

import MapKit
import SwiftData
import SwiftUI

struct RecordRideView: View {
    @StateObject var rideManager: RideManager
    
    init(context: ModelContext) {
        _rideManager = StateObject(wrappedValue: RideManager(context: context))
    }
    
    var body: some View {
        VStack {
            MapView(rideManager: rideManager)
            .frame(height: 500) // TODO: - remove hard coded value
            Spacer()
            RideStatsView(rideManager: rideManager)
            Spacer()
        }
    }
}
