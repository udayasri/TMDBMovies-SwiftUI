//
//  MoviesGridViewModel.swift
//  TMDBMovies
//
//  Created by Udaya Sri Senarathne on 2024-03-18.
//

import Foundation
import SwiftUI

@MainActor final class MoviesGridViewModel: ObservableObject, NetworkManagerProtocol {
    
    @Published var movies: [Movie] = []
    @Published var pageNumber: Int = 0
    @Published var isLoading: Bool = false
    @Published var alertItem: TMDBAlertItem?
    @Published var shouldPresentErrorAlert: Bool = false
    
    @Published var isDetailsViewPresented = false
    @Published var selectedMovie: Movie?
    
    var totalNumberOfPages = 1
    
    /// Fetches movies for a given  genre id
    /// - Parameters:
    ///   - networkManager: NetworkManager
    ///   - genreId:  genre id
    func loadMovies(for genreId:Int) {
        isLoading = true
        
        pageNumber = pageNumber + 1
        
        if pageNumber <= totalNumberOfPages  {
            Task {
                do {
                    let (newMovies, totalNumberOfPages) = try await getMovies(genreId: genreId, pageNumber: pageNumber)
                    self.totalNumberOfPages = totalNumberOfPages
                    // movies.append(contentsOf: newMovies)
                    movies.append(contentsOf: newMovies.filter{ !movies.contains($0) })
                    shouldPresentErrorAlert = false
                } catch {
                    shouldPresentErrorAlert = true
                    self.alertItem = TMDBAlertContext.errorAlert(error: error as? TMDBMError )
                }
                
                isLoading = false
            }
        } else {
            isLoading = false
        }
    }

}
