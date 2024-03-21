//
//  GenresTitleView.swift
//  TMDBMovies
//
//  Created by Udaya Sri Senarathne on 2024-03-18.
//

import SwiftUI

struct GenresListCellView: View {
    
    var genre : Genre
    
    var body: some View {
        TMDBTitle(configuration: .init(font: .title2, fontWeight: .medium)) {
            Text(genre.name)
        }
    }
}

#Preview {
    GenresListCellView(genre: MockedGenres.sampleGenre)
}
