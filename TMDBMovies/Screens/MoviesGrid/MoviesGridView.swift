//
//  MoviesGridView.swift
//  TMDBMovies
//
//  Created by Udaya Sri Senarathne on 2024-03-18.
//

import SwiftUI

struct MoviesGridView: View {
    
    @StateObject var viewModel =  MoviesGridViewModel()
    
    // Toggle between the grid view item (Just a poster) & the list view item (poster & title)
    @State private var isGridStyle = false

    let genre: Genre
    
    init(genre: Genre) {
        self.genre = genre
    }
    
    /// Defines the spacing in between items when the LazyVGrid shows
    /// ( Only applicable when `isGridStyle`: true )
    let gridItemSpacing: CGFloat = {
        #if os(iOS)
            return 10
        #elseif os(tvOS) || targetEnvironment(macCatalyst)
            return 20
        #else
            return 0
            fatalError("Unsupported platform")
        #endif
    }()
    
    /// Defines the number of columns depend on iPhone, iPad, tvOS
    let numberOfColumns: [GridItem] = {
        let gridItem = GridItem(.flexible())
        #if os(iOS)
            if UIDevice.current.userInterfaceIdiom == .pad {
                return [gridItem, gridItem, gridItem, gridItem]
            } else {
                return [gridItem, gridItem]
            }
        #elseif os(tvOS) || targetEnvironment(macCatalyst)
            return [gridItem, gridItem, gridItem, gridItem]
        #else
                fatalError("Unsupported platform")
        #endif
    }()
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: numberOfColumns, spacing: 50) {
                ForEach(viewModel.movies) { movie in
                    Button(action: {
                        viewModel.isDetailsViewPresented.toggle()
                        viewModel.selectedMovie = movie
                    }) {
                        if isGridStyle {
                            MovieItemGridView(
                                movie: movie,
                                posterPath: movie.modifiedPosterPath(),
                                numberOfColumns: CGFloat(numberOfColumns.count),
                                gridItemSpacing: gridItemSpacing)
                            .task {
                                if movie == viewModel.movies.last {
                                    viewModel.loadMovies(for: genre.id)
                                }
                            }
                        } else {
                            MovieItemListView(movie: movie,
                                              posterPath: movie.modifiedPosterPath())
                            .task {
                                if movie == viewModel.movies.last {
                                    viewModel.loadMovies(for: genre.id)
                                }
                            }
                        }
                    }
                    .background(Color.clear)
                    .foregroundColor(Color.clear)
                    #if(tvOS)
                        .buttonStyle(CardButtonStyle())
                    #else
                        .buttonStyle(PlainButtonStyle())
                    #endif
                }
            }
            .padding()
            .sheet(isPresented: $viewModel.isDetailsViewPresented,
                   content: {
                        MovieDetailsView(
                                isDetailsViewPresented: $viewModel.isDetailsViewPresented,
                                movie: viewModel.selectedMovie,
                                modifiedPosterPath: viewModel.selectedMovie?.modifiedPosterPath())
            })
            .task {
                viewModel.loadMovies(for: genre.id)
            }
            .navigationTitle(" \(genre.name) - Movies 🍿")
            .toolbar {
                Button("", systemImage: self.isGridStyle ? "list.dash" : "square.grid.2x2") {
                    self.isGridStyle.toggle()
                }
            }
            .alert(viewModel.alertItem?.titleString ?? "Error",
                   isPresented: $viewModel.shouldPresentErrorAlert,
                   presenting: viewModel.alertItem) { alertItem in
                        alertItem.actionButton
                    } message: { alertItem in
                        alertItem.message
                    }
            
            VStack() {
                if viewModel.isLoading {
                    ProgressView()
                        .progressViewStyle(.circular)
                        .scaleEffect(2.0, anchor: .center)
                }
            }
        }
    }
}


#Preview {
    MoviesGridView(genre: MockedGenres.sampleGenre)
}
