//
//  RideManagerProtocol.swift
//  stravaclone
//
//  Created by Momo Khan on 5/16/25.
//

import SwiftUI
import MapKit

@MainActor
protocol RideManagerProtocol: ObservableObject {
    // Published properties
    var lastUpdate: CLLocationUpdate? { get }
    var lastLocation: CLLocation? { get }
    var isStationary: Bool { get }
    var rideRoute: [CLLocationCoordinate2D] { get }
    var cameraPosition: MapCameraPosition { get }
    var cameraDistance: Double { get }
    var heading: Double { get }
    var pitch: Double { get }
    var distanceTravelled: Double { get }
    
    // Core functionality
    func start()
    func stop()
    func saveCurrentRide()
    func clearRideData()
    
    // Location handling
    func handleUpdate(_ update: CLLocationUpdate)
    func handleLocationUpdate(_ loc: CLLocation)
    
    // Camera control
    func updateCamera(to newCenter: CLLocationCoordinate2D)
}
