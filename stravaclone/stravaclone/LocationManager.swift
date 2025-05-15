import CoreLocation
import MapKit
import SwiftUI
import os

@MainActor
final class LocationManager: ObservableObject {
    let logger = Logger(subsystem: "com.momo.stravaclone", category: "LocationManager")
    
    private var backgroundActivitySession: CLBackgroundActivitySession?
    
    @Published var lastUpdate: CLLocationUpdate? = nil
    @Published var lastLocation: CLLocation? = nil
    @Published var isStationary = true
    @Published var pathCoordinates: [CLLocationCoordinate2D] = []
    @Published var position: MapCameraPosition = .userLocation(fallback: .automatic)
    @Published var cameraDistance: Double = 500
    @Published var heading: Double = 0
    @Published var pitch: Double = 0
    
    @Published
    var updatesStarted: Bool = UserDefaults.standard.bool(forKey: "locationUpdatesStarted") {
        didSet {
            updatesStarted ? self.startLocationUpdates() : self.stopBackgroundUpdates()
            UserDefaults.standard.set(updatesStarted, forKey: "locationUpdatesStarted")
        }
    }
    
    @Published
    var backgroundUpdates: Bool = UserDefaults.standard.bool(forKey: "BGActivitySessionStarted") {
        didSet {
            backgroundUpdates
            ? self.backgroundActivitySession = CLBackgroundActivitySession()
            : self.backgroundActivitySession?.invalidate()
            UserDefaults.standard.set(backgroundUpdates, forKey: "BGActivitySessionStarted")
        }
    }
    
    public init() {}
    
    func start() {
        backgroundUpdates = true
        updatesStarted = true
        startLocationUpdates()
    }
    
    func stop () {
        updatesStarted = false
        stopBackgroundUpdates()
    }
    
    func startLocationUpdates() {
        Task {
            do {
                let updates = CLLocationUpdate.liveUpdates(.fitness)
                for try await update in updates {
                    if !self.updatesStarted {
                        break
                    }
                    handleUpdate(update)
                    guard let loc = update.location else { continue }
                    handleLocationUpdate(loc)
                }
            } catch {
                self.logger.error("Could not start updates")
            }
        }
        return
    }
    
    func stopBackgroundUpdates() {
        self.logger.info("Stopping location updates")
        backgroundUpdates = false
    }
    
    func updateCamera(to newCenter: CLLocationCoordinate2D) {
        let newCamera = MapCamera(
            centerCoordinate: newCenter,
            distance: self.cameraDistance,
            heading: self.heading,
            pitch: self.pitch
        )
        withAnimation(.easeInOut(duration: 0.5)) {
            position = .camera(newCamera)
        }
    }
    
    func handleUpdate(_ update: CLLocationUpdate) {
        self.lastUpdate = update
        self.isStationary = update.stationary
    }
    func handleLocationUpdate(_ loc: CLLocation) {
        if let last = self.lastLocation, loc.distance(from: last) > 1 {
            self.pathCoordinates.append(loc.coordinate)
            updateCamera(to: loc.coordinate)
        } else {
            self.pathCoordinates.append(loc.coordinate)
            updateCamera(to: loc.coordinate)
        }
        self.lastLocation = loc
    }
}
