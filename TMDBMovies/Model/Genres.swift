//
//  Genres.swift
//  TMDBMovies
//
//  Created by Udaya Sri Senarathne on 2024-03-18.
//

import Foundation

struct Genre: Hashable, Codable, Identifiable {
    let id: Int
    let name: String
}

struct GenreResponse: Decodable {
    let genres: [Genre]
}

struct MockedGenres {
    static let sampleGenre =  Genre(id: 99, name: "Sample Genre")
    
    static let mockedGenreData = [
        Genre(id: 99, name: "Sample Genre"),
        Genre(id: 28, name: "Sample Genre"),
        Genre(id: 2, name: "Sample Genre")
    ]
}
