//
//  ContentView.swift
//  FeedMe
//
//  Created by David E Bratton on 8/20/22.
//

import SwiftUI

struct ContentView: View {
    // MARK: - PROPERTIES
    @State private var isLoggedIn = true
    
    // MARK: - BODY
    var body: some View {
        Group {
            if isLoggedIn {
                MainView()
            } else {
                LoginView()
            }
        } //END:GROUP
    }
}

// MARK: - PREVIEW
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
