//
//  RootView.swift
//  MovieAppTask
//
//  Created by Mohamed Makhlouf Ahmed on 23/05/2026.
//

import SwiftUI
import Commons
import MoviesListModule
import MovieDetailsModule
// in real app, i will make flow & coordinator for every feature or tab, and get all in "root tab view"
struct MoviesFlowView: View {
    @State var coordinator = MovieCoordinator()
    @StateObject private var moviesViewModel =
            MoviesDIContainer.makeMoviesViewModel()
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            MoviesView(viewModel: moviesViewModel)
                .navigationDestination(for: MovieDestination.self) { destination in
                    switch destination {
                        
                    case .movieDetails(let id):
                        return MovieDetailsView(
                            viewModel: MovieDetailsDIContainer.makeMovieDetailsViewModel(id: id)
                        )
                    }
                }
        }
        .environment(coordinator)
    }
}

#Preview {
    MoviesFlowView()
}
