import SwiftUI
import MapKit
import CoreLocation

// MapView.swift
// SwiftUI view that displays a map with the user's current location and a fixed target marker.
// Navigates to ContentView when the user is within 30 meters of the target location.
// Note: Ensure "Privacy - Location When In Use Usage Description" (NSLocationWhenInUseUsageDescription)
// is added in your Info.plist for location access permission.

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    @EnvironmentObject var progressModel: ProgressModel
    @Published var userCoordinate: CLLocationCoordinate2D?
    @Published var isNearTarget: Bool = false

    var lat: Double
    var lon: Double
    var targetCoordinate: CLLocationCoordinate2D
    private let targetLocation: CLLocation
    
    private let locationManager = CLLocationManager()
    
    init(progressModel: ProgressModel) {
        self.lat = progressModel.lat
        self.lon = progressModel.lon
        self.targetCoordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        self.targetLocation = CLLocation(latitude: lat, longitude: lon)
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    /// Requests user permission for location and starts location updates if allowed.
    func requestPermissionAndStartUpdates() {
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                DispatchQueue.main.async {
                    switch self.locationManager.authorizationStatus {
                    case .notDetermined:
                        self.locationManager.requestWhenInUseAuthorization()
                    case .authorizedWhenInUse, .authorizedAlways:
                        self.locationManager.startUpdatingLocation()
                    default:
                        break
                    }
                }
            } else {
                print("Location services are not enabled.")
            }
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let status = manager.authorizationStatus
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            locationManager.startUpdatingLocation()
        }
        // If denied or restricted, location updates won't start (handle as needed).
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let latestLocation = locations.last else { return }
        DispatchQueue.main.async {
            self.userCoordinate = latestLocation.coordinate
            // Check distance to target location
            if latestLocation.distance(from: self.targetLocation) <= 50 {
                self.isNearTarget = true
            } else {
                self.isNearTarget = false
            }
        }
    }
}

struct MapView: View {
    @EnvironmentObject var progressModel: ProgressModel
    @StateObject private var locationManager: LocationManager
    @Environment(\.dismiss) private var dismiss
    
    init(progressModel: ProgressModel) {
        _locationManager = StateObject(wrappedValue: LocationManager(progressModel: progressModel))
    }
    
    // Use MapCameraPosition to control the map's camera. Start at user location if available, otherwise show target region.
    @State private var cameraPosition: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 38.544, longitude: -121.740), // Replace with actual target if needed
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        )
    )
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                }
                .ignoresSafeArea(.all, edges: .top)
                
                Map(position: $cameraPosition, interactionModes: [.all]) {
                    // Show the user's current location indicator
                    UserAnnotation()
                    // Show an "X" marker annotation at the Memorial Union coordinates
                    Annotation("Memorial Union", coordinate: locationManager.targetCoordinate) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.red)
                            .font(.title)
                    }
                }
                .ignoresSafeArea()  // Extend the map to fill the screen
                .onAppear {
                    locationManager.requestPermissionAndStartUpdates()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        if let userCoord = locationManager.userCoordinate {
                            cameraPosition = .region(
                                MKCoordinateRegion(
                                    center: userCoord,
                                    span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                                )
                            )
                        }
                    }
                }
                
                NavigationLink(
                    destination: progressModel.isFourUnlocked ? AnyView(CompleteView()) : AnyView(FoundView()),
                    isActive: $locationManager.isNearTarget
                ) {
                    EmptyView()
                }
                .hidden()
            }
        }
    }
}
