//
//  RideAttributes.swift
//  stravaclone
//
//  Created by Momo Khan on 6/11/25.
//

import ActivityKit
import Foundation

struct RideAttributes: ActivityAttributes {
    let ride: Ride
    
    struct ContentState: Codable, Hashable {
        let rideDistance: Double
        let rideTime: Double
        let rideSpeed: Double
    }
}
