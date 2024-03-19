//
//  GenresListViewModel.swift
//  TMDBMovies
//
//  Created by Udaya Sri Senarathne on 2024-03-18.
//

import SwiftUI

@MainActor  final class GenresListViewModel: ObservableObject, NetworkManagerProtocol {

    @Published var genres: [Genre] = []
    @Published var isLoading: Bool = false
    @Published var alertItem: TMDBAlertItem?

    /// Fetches Genres for movies
    /// - Parameter networkManager: NetworkManager
    func loadGenres() {
        
        isLoading = true
        
        Task {
            do {
                genres = try await getGenres()
            } catch {
                self.alertItem = TMDBAlertContext.errorAlert(error: error as? TMDBMError)
            }
            
            isLoading = false
        }
    }
}
