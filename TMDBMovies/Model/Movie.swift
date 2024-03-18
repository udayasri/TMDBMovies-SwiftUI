//
//  Movie.swift
//  TMDBMovies
//
//  Created by Udaya Sri Senarathne on 2024-03-18.
//

import Foundation

struct Movie: Hashable, Identifiable, Codable, Equatable {
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
        case originalTitle = "original_title"
        case posterPath = "poster_path"
    }
    
    internal func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encodeIfPresent(title, forKey: .title)
        try container.encodeIfPresent(originalTitle, forKey: .originalTitle)
        try container.encodeIfPresent(posterPath, forKey: .posterPath)
    }
    
    
}

struct MoviesResponse: Codable {
    let results: [Movie]
    let page: Int
    let totalPages: Int
    let totalResults: Int
    
    internal enum CodingKeys: String, CodingKey {
        case results
        case page
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
    
    internal func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(results, forKey: .results)
        try container.encodeIfPresent(page, forKey: .page)
        try container.encodeIfPresent(totalPages, forKey: .totalPages)
        try container.encodeIfPresent(totalResults, forKey: .totalResults)
    }
    
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
