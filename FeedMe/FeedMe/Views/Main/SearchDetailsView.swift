//
//  SearchDetailsView.swift
//  FeedMe
//
//  Created by David E Bratton on 8/21/22.
//

import SwiftUI
import MapKit

struct SearchDetailsView: View {
    // MARK: - PROPERTIES
    @Environment(\.dismiss) var closeView
    @EnvironmentObject var vm: SearchViewModel
    @State private var landmarkCordRegion = MKCoordinateRegion()
    @State private var landmarks = [Landmark]()
    let landmark: Landmark
    
    func getLandMarkLocation() {
        landmarkCordRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: landmark.coordinate.latitude, longitude: landmark.coordinate.longitude), span: MapDetails.defaultSpan)
        landmarks.append(landmark)
    }
    
    // MARK: - BODY
    var body: some View {
        VStack {
            Text(landmark.name)
                .font(.title2)
                .bold()
            HStack {
                Button {
                    let url = URL(string: "maps://?saddr=&daddr=\(landmark.coordinate.latitude),\(landmark.coordinate.longitude)")
                    if UIApplication.shared.canOpenURL(url!) {
                          UIApplication.shared.open(url!, options: [:], completionHandler: nil)
                    }
                } label: {
                    Text("Get Directions")
                }
            .buttonStyle(.borderedProminent)
                Button {
                    //
                } label: {
                    Text("Add to Favorites")
                }
                .buttonStyle(.borderedProminent)
            } //END:HSTACK
            Spacer()
            Map(coordinateRegion: $landmarkCordRegion, showsUserLocation: true, annotationItems: landmarks) { landmark in
                MapAnnotation(coordinate: landmark.coordinate) {
                    AnnotationView()
                }
            }
        } //END:VSTACK
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar(content: {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    closeView()
                } label: {
                    Image(systemName: "arrow.left.circle")
                        .font(.title2)
                        .foregroundColor(.white)
                }

            }
        })
        .onAppear {
            getLandMarkLocation()
        }
    }
}

// MARK: - PREVIEW
struct SearchDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        let exampleLandmark = Landmark(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 22.4, longitude: 44.4)))
        SearchDetailsView(landmark: exampleLandmark)
            .environmentObject(SearchViewModel())
    }
}
