//
//  GenresListView.swift
//  TMDBMovies
//
//  Created by Udaya Sri Senarathne on 2024-03-18.
//

import SwiftUI

struct GenresListView: View {

    @StateObject var viewModel =  GenresListViewModel()
    @EnvironmentObject var networkManager: NetworkManager
    @State private var showErrorAlert = false
    @State private var isGridStyle = false
    
    var body: some View {
        
        if viewModel.isLoading {
            VStack {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                    .scaleEffect(2.0, anchor: .center)
            }
        }
        
        NavigationStack{
            List {
                ForEach(viewModel.genres) { genre in
                    #if os(tvOS)
                        Button(action: {
                        }) {
                            GenresListCellView(genre: genre)
                        }
                        .buttonStyle(CardButtonStyle())
                        .background(
                            NavigationLink(destination: MoviesGridView(genre: genre), label: {})
                            )
                    #else
                    NavigationLink(destination: MoviesGridView(genre: genre)){ GenresListCellView(genre: genre) }
                    #endif
                }
            }
            .task {
                viewModel.loadGenres(with: networkManager)
            }
            .alert(item: $viewModel.alertItem){ alertItem in
                Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dismissButton)
            }
            .navigationTitle("Genres 🎞️")
        }
        
    }
}

#Preview {
    GenresListView()
        .environmentObject(NetworkManager.shared)
}
