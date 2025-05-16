//
//  Coordinate.swift
//  stravaclone
//
//  Created by Momo Khan on 5/16/25.
//

import Foundation
import CoreLocation

struct Coordinate: Codable {
    var latitude: Double
    var longitude: Double
    
    init(from location: CLLocationCoordinate2D) {
        latitude = location.latitude
        longitude = location.longitude
    }
    
    var clLocationCordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    var clLocation: CLLocation {
        CLLocation(latitude: latitude, longitude: longitude)
    }
}
