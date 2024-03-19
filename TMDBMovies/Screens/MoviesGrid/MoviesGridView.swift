//
//  MoviesGridView.swift
//  TMDBMovies
//
//  Created by Udaya Sri Senarathne on 2024-03-18.
//

import SwiftUI

struct MoviesGridView: View {
    
    @StateObject var viewModel =  MoviesGridViewModel()
    @EnvironmentObject var networkManager: NetworkManager
    
    // Toggle between the grid view item ( Just a poster ) & the list view item ( poster & title )
    @State private var isGridStyle = false
    
    var genre: Genre
    
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
                    #if os(tvOS)
                        Button(action: { }) {
                            if isGridStyle {
                                MovieItemGridView(
                                    movie: movie,
                                    posterPath:viewModel.modifiedPosterPath(movie: movie),
                                    numberOfColumns: CGFloat(numberOfColumns.count),
                                    gridItemSpacing: gridItemSpacing)
                                .task {
                                    if movie == viewModel.movies.last {
                                        viewModel.loadMovies(with: networkManager, for: genre.id)
                                    }
                                }
                            } else {
                                MovieItemListView(movie: movie, 
                                                  posterPath: viewModel.modifiedPosterPath(movie: movie))
                                .task {
                                    if movie == viewModel.movies.last {
                                        viewModel.loadMovies(with: networkManager, for: genre.id)
                                    }
                                }
                            }
                        }
                        .background(Color.clear)
                        .foregroundColor(Color.clear)
                        .buttonStyle(CardButtonStyle())
                    #else
                        if isGridStyle {
                            MovieItemGridView(
                                movie: movie,
                                posterPath:viewModel.modifiedPosterPath(movie: movie),
                                numberOfColumns: CGFloat(numberOfColumns.count),
                                gridItemSpacing: gridItemSpacing)
                            .task {
                                if movie == viewModel.movies.last {
                                    viewModel.loadMovies(with: networkManager, for: genre.id)
                                }
                            }
                        } else {
                            MovieItemListView(movie: movie, 
                                              posterPath: viewModel.modifiedPosterPath(movie: movie))
                            .task {
                                if movie == viewModel.movies.last {
                                    viewModel.loadMovies(with: networkManager, for: genre.id)
                                }
                            }
                        }
                    #endif
                }
            }
            .padding()
            .task {
                viewModel.loadMovies(with: networkManager, for: genre.id)
            }
            .navigationTitle(" \(genre.name) - Movies 🍿")
            .navigationBarItems(
                trailing: Button(action: {
                    self.isGridStyle.toggle()
                }) {
                        Image(systemName: self.isGridStyle ? "list.dash" : "square.grid.2x2")
                })
            .alert(item: $viewModel.alertItem) { alertItem in
                Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dismissButton)
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
        .environmentObject(NetworkManager.shared)
}
