//
//  FeedMeApp.swift
//  FeedMe
//
//  Created by David E Bratton on 8/20/22.
//

import SwiftUI

@main
struct FeedMeApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(SearchViewModel())
                .preferredColorScheme(.dark)
        }
    }
}
