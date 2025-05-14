//
//  ContentView.swift
//  stravaclone
//
//  Created by Momo Khan on 5/8/25.
//

import MapKit
import SwiftUI

struct ContentView: View {
    @EnvironmentObject var locationManager: LocationManager
    
    
    var body: some View {
        Map(position: $locationManager.position) {
            UserAnnotation()
        }
        .mapStyle(.standard)
        .mapControls {
            MapUserLocationButton()
        }
        .safeAreaInset(edge: .bottom) {
            HStack {
                Spacer()
                Button("Start") {
                    print("Start")
                }
                Button("Stop") {
                    print("Stop")
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
