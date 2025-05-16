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
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    SavedRidesView()
}
