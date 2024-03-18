//
//  MovieItemGridView.swift
//  TMDBMovies
//
//  Created by Udaya Sri Senarathne on 2024-03-18.
//

import SwiftUI

struct MovieItemGridView: View {
    
    var movie: Movie
    var posterPath: String
    var numberOfColumns: CGFloat
    var gridItemSpacing: CGFloat
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: posterPath)) { image in
                image
                    .resizable()
                    .aspectRatio(1.0/1.5, contentMode: .fill)
            } placeholder: {
                Image(systemName: "photo")
                    .resizable()
                    .aspectRatio(1.0/1.5, contentMode: .fill)
            }
            .frame( width: (UIScreen.main.bounds.width/numberOfColumns) - (numberOfColumns*gridItemSpacing) ,
                    height:  ((UIScreen.main.bounds.width/numberOfColumns)) * 1.5)
            .cornerRadius(10)
        }
    }
}

#Preview {
    MovieItemGridView(movie: MockedMovies.sampleMovie, posterPath: MockedMovies.samplePosterUrl, numberOfColumns: 2, gridItemSpacing: 10)
}
