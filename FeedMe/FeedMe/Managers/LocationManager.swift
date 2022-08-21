//
//  LocationManager.swift
//  FeedMe
//
//  Created by David E Bratton on 8/20/22.
//

import MapKit
import Combine

enum MapDetails {
    static let defaultLocation = CLLocationCoordinate2D(latitude: 42.190300, longitude: -88.383740)
    static let defaultSpan = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
}

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    @Published var region = MKCoordinateRegion(center: MapDetails.defaultLocation, span: MapDetails.defaultSpan)
    
    override init() {
        super.init()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
    }
    
    private func checkAuthorization() {
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("DEBUG: Your location is restricted.")
        case .denied:
            print("DEBUG: Your have denied access to your location.")
        case .authorizedAlways, .authorizedWhenInUse:
            guard let location = locationManager.location else { return }
            region = MKCoordinateRegion(center: location.coordinate, span: MapDetails.defaultSpan)
        default:
            break
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        DispatchQueue.main.async { [weak self] in
            self?.region = MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.25, longitudeDelta: 0.25))
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}

extension MKCoordinateRegion {

//    static func defaultRegion() -> MKCoordinateRegion {
//        MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 42.201570, longitude: -88.395310), span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
//    }

    static func regionFromLandMark(_ landmark: Landmark) -> MKCoordinateRegion {
        MKCoordinateRegion(center: landmark.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
    }
}
