//
//  RideTests.swift
//  RideTests
//
//  Created by Momo Khan on 6/12/25.
//

import Foundation
import Testing
@testable import stravaclone

struct RideTests {
    var ride: Ride

    init() {
        ride = Ride.mock
    }
    @Test func rideAverageSpeedCalculatedCorrectly() {
        print(ride.totalDistance)
        print(ride.totalTime)
        #expect(ride.averageSpeed == 126.61)
    }

}
