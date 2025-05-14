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
            backgroundUpdates ? self.backgroundActivitySession = CLBackgroundActivitySession() : self.backgroundActivitySession?.invalidate()
            UserDefaults.standard.set(backgroundUpdates, forKey: "BGActivitySessionStarted")
        }
    }
    
    public init() {
        startLocationUpdates()
    }
    
    func startLocationUpdates() {
        Task {
            do {
                let updates = CLLocationUpdate.liveUpdates(.fitness)
                for try await update in updates {
                    if !self.updatesStarted {
                        break
                    }
                    self.lastUpdate = update
                    if let loc = update.location {
                        pathCoordinates.append(loc.coordinate)
                        position = .camera(.init(centerCoordinate: loc.coordinate, distance: 500))
                        self.lastLocation = loc
                        self.isStationary = update.stationary
                    }
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
}

