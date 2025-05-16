//
//  ContentView.swift
//  stravaclone
//
//  Created by Momo Khan on 5/8/25.
//

import MapKit
import SwiftData
import SwiftUI

struct ContentView: View {
    @StateObject var rideManager: RideManager
    
    init(context: ModelContext) {
        _rideManager = StateObject(wrappedValue: RideManager(context: context))
    }
    
    
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
        .safeAreaInset(edge: .bottom) {
            HStack {
                Spacer()
                Button("Start") {
                    rideManager.start()
                }
                Button("Stop") {
                    rideManager.stop()
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

//#Preview {
//    ContentView()
//}
