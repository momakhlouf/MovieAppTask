//
//  SwiftUIView.swift
//  MoviesListModule
//
//  Created by Mohamed Makhlouf Ahmed on 22/05/2026.
//

import SwiftUI
import Commons
import CoreModels

struct MoviesGridView: View {
    @ObservedObject var viewModel: MoviesViewModel
    @Environment(MovieCoordinator.self) var coordinator
    var body: some View {
        ScrollView(showsIndicators: false){
            LazyVGrid(columns: viewModel.columns) {
                ForEach(viewModel.filteredMovies, id: \.id){ movie in
                    MovieCardView(movie: movie)
                        .onTapGesture {
                            coordinator.navigate(to: .movieDetails(id: movie.id))
                        }
                        .onAppear{
                            viewModel.handlePagination(movie: movie)
                        }
                }
            }
        }
        .refreshable {
            viewModel.getMovies()
        }
    }
}

