//
//  Movie.swift
//  TMDBMovies
//
//  Created by Udaya Sri Senarathne on 2024-03-18.
//

import Foundation

struct Movie: Identifiable, Codable, Equatable {
    let id: Int
    let originalTitle: String?
    let posterPath: String?
    let title: String?
    
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        return lhs.id == rhs.id
    }
    
    internal enum CodingKeys: String, CodingKey {
        case id
        case title
        case originalTitle
        case posterPath
    }
}

struct MoviesResponse: Codable {
    let results: [Movie]
    let page: Int
    let totalPages: Int
    let totalResults: Int
}

struct MockedMovies {
    
    static let sampleMovie =  Movie(id: 0, originalTitle: "Sample Title", posterPath: "/1Gf5YdhlJ1G7Tf7WkSRrs6ssZ3G.jpg", title: "Sample Title")
    
    static let samplePosterUrl = "https://placehold.co/600x400/EEE/31343C"
    
    static let mockedMovieData = [
        Movie(id: 0, originalTitle: "Sample Title", posterPath: "/yeHlWPuXOSqTlzVBEovH7SeEKLr.jpg", title: "Sample Title"),
        Movie(id: 1, originalTitle: "Sample Title", posterPath: "/dxdN3RxJRVYzFxVSR0fNhSBqBSL.jpg", title: "Sample Title"),
        Movie(id: 2, originalTitle: "Sample Title", posterPath: "/yEBBtk1eyZltGgJt8Z2zi3KIvvX.jpg", title: "Sample Title"),
        Movie(id: 3, originalTitle: "Sample Title", posterPath: "/bV7eAcBrYb57PwjpQ2ODT6VyFPd.jpg", title: "Sample Title"),
        Movie(id: 4, originalTitle: "Sample Title", posterPath: "/75ot83QOkc02vujyzmIbumQCU6Y.jpg", title: "Sample Title")
        
    ]
}
