//
//  MainView.swift
//  FeedMe
//
//  Created by David E Bratton on 8/20/22.
//

import SwiftUI

struct MainView: View {
    // MARK: - PROPERTIES
    
    // MARK: - BODY
    var body: some View {
        TabView {
            FavoritesView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Favorites")
                }
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
        } //END:TABVIEW
    }
}

// MARK: - PREVIEW
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
