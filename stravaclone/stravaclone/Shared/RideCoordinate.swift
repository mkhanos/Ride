//
//  RideCoordinate.swift
//  stravaclone
//
//  Created by Momo Khan on 5/16/25.
//

import Foundation
import CoreLocation

struct RideCoordinate: Codable {
    var latitude: Double
    var longitude: Double
    var timestamp: Date
    
    init(from location: CLLocation) {
        latitude = location.coordinate.latitude
        longitude = location.coordinate.longitude
        timestamp = location.timestamp
    }
    
    init(latitude: Double, longitude: Double, timestamp: Date) {
        self.latitude = latitude
        self.longitude = longitude
        self.timestamp = timestamp
    }
    
    var clLocationCordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    var clLocation: CLLocation {
        CLLocation(latitude: latitude, longitude: longitude)
    }
}
