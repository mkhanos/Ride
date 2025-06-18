//
//  MapView.swift
//  stravaclone
//
//  Created by Momo Khan on 6/18/25.
//

import MapKit
import SwiftUI

struct MapView: View {
    @ObservedObject var rideManager: RideManager
    
    var body: some View {
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
    }
}
