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
    var route: [RideCoordinate]
    
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
    
    init(route: [RideCoordinate]) {
        self.route = route
    }
}
