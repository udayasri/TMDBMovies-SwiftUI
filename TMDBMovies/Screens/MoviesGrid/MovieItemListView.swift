//
//  MovieItemListView.swift
//  TMDBMovies
//
//  Created by Udaya Sri Senarathne on 2024-03-18.
//

import SwiftUI

struct MovieItemListView: View {
    var movie: Movie
    var posterPath: String
    
    /// Define frame size of the image depend on the device
    let frameSize: (CGFloat,CGFloat)  = {
         #if os(iOS)
            return (100, 100)
         #elseif os(tvOS) || targetEnvironment(macCatalyst)
            return (150, 150)
         #else
         fatalError("Unsupported platform")
         #endif
     }()
    
    var body: some View {
        HStack(spacing: 0){
            
            // TODO: As `AsyncImage`is not cacheable, either create a custom downloadable cacheable image or use a workaround
            AsyncImage(url: URL(string: posterPath)) { image in
                image
                   .resizable()
                   .aspectRatio(1.0/1.5, contentMode: .fit)
            } placeholder: {
                Image(systemName: "photo")
                   .resizable()
                   .aspectRatio(1.0/1.5, contentMode: .fill)
            }
            .frame(width: frameSize.0, height: frameSize.1)
            .cornerRadius(10)
            
            Text(movie.title ?? "")
                .font(.caption)
                .fontWeight(.medium)
                .lineLimit(3)
                .minimumScaleFactor(0.8)
                .multilineTextAlignment(.leading)
                .foregroundColor(Color(.label))
                
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
}

#Preview {
    MovieItemListView(movie: MockedMovies.sampleMovie, posterPath: MockedMovies.samplePosterUrl)
}
