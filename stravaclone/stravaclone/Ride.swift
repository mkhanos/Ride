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
    var startLocation: CLLocation
    var endLocation: CLLocation
    var distance: Double
    var route: [CLLocationCoordinate2D]
    
    init(startLocation: CLLocation, endLocation: CLLocation, distance: Double, route: [CLLocationCoordinate2D]) {
        self.startLocation = startLocation
        self.endLocation = endLocation
        self.distance = distance
        self.route = route
    }
}
