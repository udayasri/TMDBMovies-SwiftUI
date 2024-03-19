//
//  MoviesGridViewModel.swift
//  TMDBMovies
//
//  Created by Udaya Sri Senarathne on 2024-03-18.
//

import Foundation
import SwiftUI

@MainActor final class MoviesGridViewModel: ObservableObject {
    
    @Published var movies: [Movie] = []
    @Published var pageNumber: Int = 0
    @Published var isLoading: Bool = false
    @Published var alertItem: TMDBAlertItem?
    
    var totalNumberOfPages = 1
    
    /// Fetches movies for a given  genre id
    /// - Parameters:
    ///   - networkManager: NetworkManager
    ///   - genreId:  genre id
    func loadMovies(with networkManager: NetworkManager, for genreId:Int) {
        isLoading = true
        
        pageNumber = pageNumber + 1
        
        if pageNumber <= totalNumberOfPages  {
            Task {
                do {
                    let (newMovies, totalNumberOfPages) = try await networkManager.getMovies(genreId: genreId, pageNumber: pageNumber)
                    self.totalNumberOfPages = totalNumberOfPages
                    movies.append(contentsOf: newMovies.filter{ !movies.contains($0) })
                } catch {
                    self.alertItem = TMDBAlertContext.errorAlert(error: error as? TMDBMError )
                }
                
                isLoading = false
            }
        } else {
            isLoading = false
        }
    }
    
    /// Modify the path for fetching image urls
    /// - Parameter movie: `Movie`
    /// - Returns: Movie poster image url
    func modifiedPosterPath(movie: Movie) -> String {
        guard let posterPath = movie.posterPath else { return "" }
        return "\(imageBaseUrl)\(moviePosterImageWidth)\(posterPath)"
    }
}
