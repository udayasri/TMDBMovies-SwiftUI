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
        Text(genre.name)
            .font(.title2)
            .fontWeight(.medium)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            
    }
}

#Preview {
    GenresListCellView(genre: MockedGenres.sampleGenre)
}
