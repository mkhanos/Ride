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
            Map(position: $rideManager.cameraPosition) {
                MapPolyline(coordinates: rideManager.rideRoute)
                    .stroke(.blue, lineWidth: 4)
                UserAnnotation()
            }
            .mapStyle(.standard)
            .mapControls {
                MapUserLocationButton()
            }
            .onMapCameraChange { context in
                rideManager.heading = context.camera.heading
                rideManager.pitch = context.camera.pitch
                rideManager.cameraDistance = context.camera.distance
            }
            .frame(height: 500) // TODO: - remove hard coded value
            .safeAreaPadding(.top)
            Spacer()
            HStack {
                Spacer()
                Button(!rideManager.isTracking ? "Start" : "Stop") {
                    !rideManager.isTracking ? rideManager.start() : rideManager.stop()
                }
                Spacer()
            }
            .padding(.bottom)
        }
    }
}
