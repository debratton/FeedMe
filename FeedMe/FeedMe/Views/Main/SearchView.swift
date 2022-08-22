//
//  SearchView.swift
//  FeedMe
//
//  Created by David E Bratton on 8/20/22.
//

import SwiftUI
import MapKit

struct SearchView: View {
    // MARK: - PROPERTIES
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var vm: SearchViewModel
    @State private var searchText = ""
    @State private var previousSarch = ""
    
    // MARK: - BODY
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 0) {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.ultraThinMaterial)
                    HStack {
                        TextField("Search...", text: $searchText)
                            .textFieldStyle(.roundedBorder)
                            .onChange(of: searchText) { newValue in
                                if newValue.isEmpty {
                                    vm.landmarks.removeAll()
                                }
                            }
                        Button {
                            vm.search(query: searchText)
                            previousSarch = searchText
                            searchText = ""
                        } label: {
                            Text("Search")
                        } //END:BUTTON
                        .buttonStyle(.borderedProminent)
                    } //END:HSTACK
                    .padding(.horizontal)
                    
                } //END:ZSTACK
                .frame(height: 60)
                if !vm.landmarks.isEmpty {
                    List {
                        HStack {
                            Button {
                                vm.landmarks.removeAll()
                            } label: {
                                Text("Clear Search")
                                    .padding(.vertical, 3)
                                    .padding(.horizontal, 5)
                                    .background(Color.red)
                                    .foregroundColor(.white)
                                    .cornerRadius(5)
                            }
                            Text("\(previousSarch)")
                                .bold()
                        } //END:HSTACK
                        ForEach(vm.landmarks, id: \.id) { landmark in
                            NavigationLink {
                                SearchDetailsView(landmark: landmark)
                            } label: {
                                SearchCellView(landmark: landmark)
                            }
                        } //END:FOREACH
                    } //END:LIST
                    .listStyle(.plain)
                }
                Spacer()
                Map(coordinateRegion: $vm.region, showsUserLocation: true, annotationItems: vm.landmarks) { landmark in
                    MapAnnotation(coordinate: landmark.coordinate) {
                        Image(systemName: "mappin")
                            .font(.title)
                            .foregroundColor(.red)
                    }
                    //MapMarker(coordinate: landmark.coordinate, tint: .pink)
                } //END:MAP
            } //END:VSTACK
            .navigationBarHidden(true)
        } //END:NAVVIEW
    }
}

// MARK: - PREVIEW
struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
            .environmentObject(SearchViewModel())
    }
}
