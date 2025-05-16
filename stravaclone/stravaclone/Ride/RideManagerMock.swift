//
//  RideManagerMock.swift
//  stravaclone
//
//  Created by Momo Khan on 5/16/25.
//

import CoreLocation
import MapKit
import SwiftData
import SwiftUI

class RideManagerMock: RideManagerProtocol {
    private var testTimer: Timer?
    private var testLocationIndex = 0
    private var updateTask: Task<Void, Never>?
    
    private let testCoordinates: [CLLocationCoordinate2D] = [
        CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194), // San Francisco
        CLLocationCoordinate2D(latitude: 37.7750, longitude: -122.4195),
        CLLocationCoordinate2D(latitude: 37.7751, longitude: -122.4196),
        CLLocationCoordinate2D(latitude: 37.7752, longitude: -122.4197),
        CLLocationCoordinate2D(latitude: 37.7753, longitude: -122.4198),
        CLLocationCoordinate2D(latitude: 37.7754, longitude: -122.4199),
        CLLocationCoordinate2D(latitude: 37.7755, longitude: -122.4200),
        CLLocationCoordinate2D(latitude: 37.7756, longitude: -122.4201),
        CLLocationCoordinate2D(latitude: 37.7757, longitude: -122.4202),
        CLLocationCoordinate2D(latitude: 37.7758, longitude: -122.4203),
    ]
    
    // Published properties required by protocol
    @Published var lastUpdate: CLLocationUpdate?
    @Published var lastLocation: CLLocation?
    @Published var isStationary = true
    @Published var rideRoute: [CLLocationCoordinate2D] = []
    @Published var cameraPosition: MapCameraPosition = .userLocation(fallback: .automatic)
    @Published var cameraDistance: Double = 500
    @Published var heading: Double = 0
    @Published var pitch: Double = 0
    @Published var distanceTravelled: Double = 0
    
    private let context: ModelContext
    
    init(context: ModelContext) {
        self.context = context
    }
    
    func start() {
        updateTask = Task { @MainActor in
            while true {
                let coordinate = testCoordinates[testLocationIndex]
                let location = CLLocation(
                    coordinate: coordinate,
                    altitude: 0,
                    horizontalAccuracy: 5,
                    verticalAccuracy: -1,
                    timestamp: Date()
                )
                handleLocationUpdate(location)
                testLocationIndex = (testLocationIndex + 1) % testCoordinates.count
                try? await Task.sleep(for: .seconds(1))
            }
        }
    }
    
    func stop() {
        // Cancel the task
        updateTask?.cancel()
        updateTask = nil
        Task { @MainActor in
            saveCurrentRide()
            clearRideData()
        }
    }
    
    func saveCurrentRide() {
        guard rideRoute.count > 0 else { return }
        let startLocation = Coordinate(from: rideRoute[0])
        let endLocation = Coordinate(from: rideRoute[rideRoute.count-1])
        let route = rideRoute.map { Coordinate(from: $0) }
        let ride = Ride(startLocation: startLocation,
                        endLocation: endLocation,
                        distance: distanceTravelled,
                        route: route)
        context.insert(ride)
        try? context.save()
        clearRideData()
    }
    
    func clearRideData() {
        lastUpdate = nil
        lastLocation = nil
        rideRoute = []
        distanceTravelled = 0
    }
    
    func handleUpdate(_ update: CLLocationUpdate) {
        self.lastUpdate = update
        self.isStationary = update.stationary
    }
    
    func handleLocationUpdate(_ loc: CLLocation) {
        guard loc.horizontalAccuracy >= 0 && loc.horizontalAccuracy <= 10 else { return }
        if let last = self.lastLocation, loc.distance(from: last) > 1 {
            self.rideRoute.append(loc.coordinate)
            self.distanceTravelled += loc.distance(from: last)
            updateCamera(to: loc.coordinate)
        } else {
            self.rideRoute.append(loc.coordinate)
            updateCamera(to: loc.coordinate)
        }
        self.lastLocation = loc
    }
    
    func updateCamera(to newCenter: CLLocationCoordinate2D) {
        let newCamera = MapCamera(
            centerCoordinate: newCenter,
            distance: self.cameraDistance,
            heading: self.heading,
            pitch: self.pitch
        )
        withAnimation(.easeInOut(duration: 0.5)) {
            cameraPosition = .camera(newCamera)
        }
    }
}
