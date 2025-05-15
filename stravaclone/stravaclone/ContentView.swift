//
//  ContentView.swift
//  stravaclone
//
//  Created by Momo Khan on 5/8/25.
//

import MapKit
import SwiftUI

struct ContentView: View {
    @StateObject var locationManager = LocationManager()
    
    
    var body: some View {
        Map(position: $locationManager.position) {
            MapPolyline(coordinates: locationManager.pathCoordinates)
                .stroke(.blue, lineWidth: 4)
            UserAnnotation()
        }
        .mapStyle(.standard)
        .mapControls {
            MapUserLocationButton()
        }
        .onMapCameraChange { context in
            locationManager.heading = context.camera.heading
            locationManager.pitch = context.camera.pitch
            locationManager.cameraDistance = context.camera.distance
        }
        .safeAreaInset(edge: .bottom) {
            HStack {
                Spacer()
                Button("Start") {
                    locationManager.start()
                }
                Button("Stop") {
                    locationManager.stop()
                }
                Button("Finish") {
                    print("Finish")
                }
                Spacer()
            }
            .padding(.top)
            .background(.thinMaterial)
        }
    }
}

#Preview {
    ContentView()
}
