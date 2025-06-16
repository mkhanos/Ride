import ActivityKit
import CoreLocation
import MapKit
import SwiftData
import SwiftUI
import os

@MainActor
final class RideManager: ObservableObject {
    let logger = Logger(subsystem: "com.momo.stravaclone", category: "LocationManager")
    
    private var backgroundActivitySession: CLBackgroundActivitySession?
    private var context: ModelContext // context to insert into swift db
    
    @Published var lastUpdate: CLLocationUpdate? = nil
    @Published var lastLocation: CLLocation? = nil
    @Published var isStationary = true
    @Published var rideRoute: [CLLocationCoordinate2D] = [] // coordinates for drawing polyline on map
    @Published var ride: Ride?
    @Published var cameraPosition: MapCameraPosition = .userLocation(fallback: .automatic)
    @Published var cameraDistance: Double = 500
    @Published var heading: Double = 0
    @Published var pitch: Double = 0
    @Published var isTracking: Bool = false
    
    private var activity: Activity<RideWidgetAttributes>?
    
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
        ride = Ride(route: [])
        withAnimation {
            isTracking = true
        }
        updatesStarted = true
        requestLiveActivity()
    }
    
    func stop() {
        updatesStarted = false
        
        withAnimation {
            isTracking = false
        }
        Task {
            await endActivty()
            saveCurrentRide()
        }
        
    }
    
    func saveCurrentRide() {
        guard let ride = ride else { return }
        guard ride.route.count >= 2 else { return }
        context.insert(ride)
        try? context.save()
        clearRideData()
    }
    
    func clearRideData() {
        lastUpdate = nil
        lastLocation = nil
        rideRoute = []
        ride = nil
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
                    await updateLiveactivty()
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
        if let last = self.lastLocation {
            self.ride?.route.append(RideCoordinate(from: loc))
            self.rideRoute.append(loc.coordinate)
            updateCamera(to: loc.coordinate)
        } else {
            self.rideRoute.append(loc.coordinate)
            updateCamera(to: loc.coordinate)
        }
        self.lastLocation = loc
    }
    
    func requestLiveActivity() {
        guard let ride = ride else { return }
        let attributes = RideWidgetAttributes()
        let initialState = RideWidgetAttributes.ContentState(rideDistance: ride.totalDistance,
                                                             rideTime: ride.totalTime.formattedTime,
                                                             rideSpeed: ride.averageSpeed)
        let content = ActivityContent(state: initialState, staleDate: nil, relevanceScore: 0)
        
        // TODO: - catch this
        do {
            let activity = try Activity.request(attributes: attributes,
                                                content: content,
                                                pushType: nil)
            self.activity = activity
        } catch {
            print("Failed to start live activity \(error)")
        }
    }
    
    func updateLiveactivty() async  {
        guard let ride = ride else { return }
        guard let activity else { return }
        let newState = RideWidgetAttributes.ContentState(rideDistance: ride.totalDistance, rideTime: ride.totalTime.formattedTime, rideSpeed: ride.averageSpeed)
        await activity.update(using: newState)
    }
    
    func endActivty() async {
        guard let ride = ride else { return }
        guard let activity = activity else { return }
        let finalState = RideWidgetAttributes.ContentState(rideDistance: ride.totalDistance, rideTime: ride.totalTime.formattedTime, rideSpeed: ride.averageSpeed)
        await activity.end(using: finalState, dismissalPolicy: .default)
        self.activity = nil
    }
}
