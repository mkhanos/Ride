//
//  Ride.swift
//  
//
//  Created by Momo Khan on 5/16/25.
//

import Foundation
import SwiftData
import MapKit

@Model
class Ride {
    var route: [RideCoordinate]
    var createdAt: Date
    
    var totalTime: TimeInterval {
        let start = route[0].timestamp
        let end = route[route.count-1].timestamp
        return end.timeIntervalSince(start)
    }
    
    var totalDistance: CLLocationDistance {
        var distance = CLLocationDistance()
        for i in 1..<route.count {
            let prev = route[i-1].clLocation
            let curr = route[i].clLocation
            distance += curr.distance(from: prev)
        }
        return distance
    }
    
    var averageSpeed: CLLocationDistance {
        totalDistance / totalTime
    }
    
    var startLocation: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: route[0].latitude, longitude: route[0].longitude)
    }
    
    var endLocation: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: route[route.count-1].latitude, longitude: route[route.count-1].longitude)
    }
    
    init(route: [RideCoordinate]) {
        self.route = route
        self.createdAt = Date()
    }
}

extension Ride {
    static var mock: Ride {
        let startTime = Date()
        
        let coordinates: [RideCoordinate] = [
            RideCoordinate(latitude: 37.7749, longitude: -122.4194, timestamp: startTime),
            RideCoordinate(latitude: 37.7752, longitude: -122.4189, timestamp: startTime.addingTimeInterval(30)),
            RideCoordinate(latitude: 37.7755, longitude: -122.4182, timestamp: startTime.addingTimeInterval(60)),
            RideCoordinate(latitude: 37.7759, longitude: -122.4176, timestamp: startTime.addingTimeInterval(90)),
            RideCoordinate(latitude: 37.7763, longitude: -122.4170, timestamp: startTime.addingTimeInterval(120)),
            RideCoordinate(latitude: 37.7768, longitude: -122.4165, timestamp: startTime.addingTimeInterval(150)),
            RideCoordinate(latitude: 37.7771, longitude: -122.4160, timestamp: startTime.addingTimeInterval(180)),
            RideCoordinate(latitude: 37.7774, longitude: -122.4155, timestamp: startTime.addingTimeInterval(210)),
            RideCoordinate(latitude: 37.7778, longitude: -122.4150, timestamp: startTime.addingTimeInterval(240)),
            RideCoordinate(latitude: 37.7782, longitude: -122.4145, timestamp: startTime.addingTimeInterval(270))
        ]
        
        return Ride(route: coordinates)
    }
}
