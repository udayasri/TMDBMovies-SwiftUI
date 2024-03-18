//
//  NetworkManager.swift
//  TMDBMovies
//
//  Created by Udaya Sri Senarathne on 2024-03-18.
//

import Foundation
import SwiftUI

protocol NetworkManagerProtocol {
    func getGenres() async throws -> [Genre]
    func getMovies(genreId: Int, pageNumber: Int) async throws -> ([Movie], Int)
}

final class NetworkManager: ObservableObject, NetworkManagerProtocol {
    
    // TODO: It hurts looking at this 💩 , but my personal opinion is it's ok to have it like this for now as this is a very simple project & over complicating things may not be the best.
    //
    // Nice example implementation for a more complex project using Coordinators & Dependency Injection Container
    // https://github.com/jasonjrr/MVVM.Demo.SwiftUI/tree/master
    // Good article - https://www.linkedin.com/pulse/mvvm-swiftui-classic-dependency-injection-vs-objects-jiri-banas/
    //
    static let shared = NetworkManager()
    
    let dataCacheManager: DataCacheManagerProtocol
    
    init(dataCacheManager: DataCacheManagerProtocol = DataCacheManager()) {
        self.dataCacheManager = dataCacheManager
    }
    
    /// Fetches JSON data from the specified URL and decodes it into the provided codable type.
    /// - Parameter url: The URL from which to fetch the JSON data.
    /// - Returns: Object containing either the decoded data of the specified type on success or an error on failure.
    private func fetchData<T: Decodable>(from url: URL) async throws -> T {
        do {
            let (data, response ) = try await URLSession.shared.data(from: url)
            
            let decoder = JSONDecoder()
            let decodedResponse = try decoder.decode(T.self, from: data)
            return decodedResponse
            
        } catch {
            if let decodingError = error as? DecodingError {
                throw TMDBMError.dataDecodingError(description: decodingError.localizedDescription)
            } else {
                throw TMDBMError.dataFetchingError(description: error.localizedDescription)
            }
        }
    }
}

// MARK: Genres
extension NetworkManager {
    
    /// Get the list of official genres for movies : https://developer.themoviedb.org/reference/genre-movie-list
    /// - Returns: Array of `Genre`s or throws an error
    ///
    func getGenres() async throws -> [Genre] {
        
        // Check if cached genres is available and not expired
        if let cachedGenres: [Genre] = dataCacheManager.getCachedData(fileName: cacheFileNameForGenres), !dataCacheManager.isCacheExpired(fileName: cacheFileNameForGenres, cacheDuration: cacheDuration ) {
            return cachedGenres
        }
        
        guard let url = URL(string: "\(baseUrl)genre/movie/list?api_key=\(apiKey)&language=en") else {
            throw TMDBMError.invalidUrl(description: "Please check your url")
        }
        
        let genreResponse: GenreResponse = try await fetchData(from: url)
        
        // Cache the fetched genres ( TODO: Handle Errors )
        dataCacheManager.cacheData(genreResponse.genres, fileName: cacheFileNameForGenres)
        
        return genreResponse.genres
    }
}

// MARK: Movies
extension NetworkManager {
    
    /// Get `Movie`s  for a given `Genre`
    /// - Returns: Array of `Movie` & `totalPages` or throws an Error
    func getMovies(genreId: Int, pageNumber: Int) async throws -> ([Movie], Int) {
        guard let url = URL(string: "\(baseUrl)/discover/movie?with_genres=\(genreId)&api_key=\(apiKey)&language=en&page=\(pageNumber)") else {
            throw TMDBMError.invalidUrl(description: "Please check your url")
        }
        let moviesResponse: MoviesResponse = try await fetchData(from: url)
        return (moviesResponse.results, moviesResponse.totalPages)
    }
}