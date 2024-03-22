//
//  MovieDetailsView.swift
//  TMDBMovies
//
//  Created by Udaya Sri Senarathne on 2024-03-22.
//

import SwiftUI

struct MovieDetailsView: View {
    
    @Binding var isDetailsViewPresented: Bool
    let movie: Movie?
    let modifiedPosterPath: String?
    
    var body: some View {
        if let movie  = movie {
            
            AsyncImage(url: URL(string: modifiedPosterPath ?? "")) { image in
                image
                    .resizable()
                    .aspectRatio(1.0/1.5, contentMode: .fill)
            } placeholder: {
                Image(systemName: "photo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(Color(.placeholderText))
                    .padding()
            }
            .frame( width: 100,
                    height:  150)
            .cornerRadius(10)
            
            Text("Hello, This is \(movie.title ?? "" ) Details ! ")
            .padding()
        }
    }
}

#Preview {
    MovieDetailsView(isDetailsViewPresented: .constant(true), movie: MockedMovies.sampleMovie, modifiedPosterPath: MockedMovies.samplePosterUrl)
}
