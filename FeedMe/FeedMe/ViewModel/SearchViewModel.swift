//
//  SearchViewModel.swift
//  FeedMe
//
//  Created by David E Bratton on 8/21/22.
//

import Foundation
import MapKit
import Combine

class SearchViewModel: ObservableObject {
    
    @Published var region = MKCoordinateRegion(center: MapDetails.defaultLocation, span: MapDetails.defaultSpan)
    @Published var landmarks = [Landmark]()
    @Published var landmark: Landmark?
    @Published var distanceFromLandmark: Double?
    let locationManager = LocationManager()
    var cancellables = Set<AnyCancellable>()
    
    init() {
        locationManager.$region.assign(to: \.region, on: self)
            .store(in: &cancellables)
    }
    
    func search(query: String) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = query
        request.region = locationManager.region
        let search = MKLocalSearch(request: request)
        search.start { response, error in
            if let response = response {
                let mapItems = response.mapItems
                self.landmarks = mapItems.compactMap({ item in
                    Landmark(placemark: item.placemark)
                })
            }
        }
    }
    
    func getDistanceAway(mapPoint: CLLocationCoordinate2D) -> Double? {
        locationManager.getDistanceAway(point: mapPoint)
    }
    
}
