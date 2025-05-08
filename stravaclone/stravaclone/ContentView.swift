//
//  ContentView.swift
//  stravaclone
//
//  Created by Momo Khan on 5/8/25.
//

import SwiftUI
import MapKit

struct ContentView: View {
    var body: some View {
        Map {
            
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
