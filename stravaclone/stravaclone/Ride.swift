//
//  Ride.swift
//  stravaclone
//
//  Created by Momo Khan on 5/16/25.
//

import SwiftData
import MapKit

@Model
class Ride {
    var startLocation: Coordinate
    var endLocation: Coordinate
    var distance: Double
    var route: [Coordinate]
    
    init(startLocation: Coordinate, endLocation: Coordinate, distance: Double, route: [Coordinate]) {
        self.startLocation = startLocation
        self.endLocation = endLocation
        self.distance = distance
        self.route = route
    }
}
