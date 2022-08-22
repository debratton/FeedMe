//
//  SearchCellView.swift
//  FeedMe
//
//  Created by David E Bratton on 8/21/22.
//

import SwiftUI
import MapKit

struct SearchCellView: View {
    // MARK: - PROPERTIES
    @EnvironmentObject var vm: SearchViewModel
    let landmark: Landmark
    
    func getDistanceAway(location: CLLocationCoordinate2D) -> String {
        if let distance = vm.getDistanceAway(mapPoint: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)) {
            let convertedDistance = distance * 0.000621
            return String(format: "%.2f", convertedDistance)
        } else {
            return "0.0"
        }
    }
    
    // MARK: - BODY
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(landmark.name)
                Spacer()
                Text("\(getDistanceAway(location: CLLocationCoordinate2D(latitude: landmark.coordinate.latitude, longitude: landmark.coordinate.longitude))) mi")
                    .font(.footnote)
                    .padding(5)
                    .background(Color.red)
                    .foregroundColor(.white)
                    .clipShape(Capsule())
            } //END:HSTACK
            Text(landmark.title)
                .foregroundColor(.secondary)
                .font(.footnote)
        } //END:VSTACK
    }
}

// MARK: - PREVIEW
struct SearchCellView_Previews: PreviewProvider {
    static var previews: some View {
        let landmark = Landmark(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 4488, longitude: 4444)))
        SearchCellView(landmark: landmark).environmentObject(SearchViewModel())
    }
}
