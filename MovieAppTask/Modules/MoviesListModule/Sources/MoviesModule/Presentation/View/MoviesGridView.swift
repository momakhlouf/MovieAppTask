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
    let movies: [Movie]
    let columns: [GridItem]
    let onMovieAppear: (Movie) -> Void
    let onRefresh: () -> Void
    @Environment(MovieCoordinator.self) var coordinator
    var body: some View {
        ScrollView(showsIndicators: false){
            LazyVGrid(columns: columns) {
                ForEach(movies, id: \.id){ movie in
                    MovieCardView(movie: movie)
                        .onTapGesture {
                            coordinator.navigate(to: .movieDetails(id: movie.id))
                        }
                        .onAppear{
                            onMovieAppear(movie)
                        }
                }
            }
        }
        .refreshable {
            onRefresh()
        }
    }
}

