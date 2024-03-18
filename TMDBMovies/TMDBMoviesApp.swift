//
//  TMDBMoviesApp.swift
//  TMDBMovies
//
//  Created by Udaya Sri Senarathne on 2024-03-18.
//

import SwiftUI

@main
struct TMDBMoviesApp: App {
    
    @StateObject var networkManager = NetworkManager.shared
    
    var body: some Scene {
        WindowGroup {
            GenresListView()
                .environmentObject(networkManager)
        }
    }
}
