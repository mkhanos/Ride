import CoreLocation
import MapKit
import SwiftData
import SwiftUI
import os

@MainActor
final class RideManager: ObservableObject {
    let logger = Logger(subsystem: "com.momo.stravaclone", category: "LocationManager")
    
    private var backgroundActivitySession: CLBackgroundActivitySession?
    private var context: ModelContext
    
    @Published var lastUpdate: CLLocationUpdate? = nil
    @Published var lastLocation: CLLocation? = nil
    @Published var isStationary = true
    @Published var rideRoute: [CLLocationCoordinate2D] = []
    var savedRide: [RideCoordinate] = []
    @Published var cameraPosition: MapCameraPosition = .userLocation(fallback: .automatic)
    @Published var cameraDistance: Double = 500
    @Published var heading: Double = 0
    @Published var pitch: Double = 0
    @Published var distanceTravelled: Double = 0
    
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
    
    public init(context: ModelContext) {
        self.context = context
    }
    
    func start() {
        backgroundUpdates = true
        updatesStarted = true
    }
    
    func stop() {
        updatesStarted = false
        saveCurrentRide()
    }
    
    func saveCurrentRide() {
        guard savedRide.count >= 2 else { return }
        let ride = Ride(route: savedRide)
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
    
    func startLocationUpdates() {
        self.logger.info("Starting location updates")
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
            cameraPosition = .camera(newCamera)
        }
    }
    
    func handleUpdate(_ update: CLLocationUpdate) {
        self.lastUpdate = update
        self.isStationary = update.stationary
    }
    func handleLocationUpdate(_ loc: CLLocation) {
        guard loc.horizontalAccuracy >= 0 && loc.horizontalAccuracy <= 10 else { return }
        if let last = self.lastLocation, loc.distance(from: last) > 1 {
            self.savedRide.append(RideCoordinate(from: loc))
            self.rideRoute.append(loc.coordinate)
            self.distanceTravelled += loc.distance(from: last)
            updateCamera(to: loc.coordinate)
        } else {
            self.rideRoute.append(loc.coordinate)
            updateCamera(to: loc.coordinate)
        }
        self.lastLocation = loc
    }
}
