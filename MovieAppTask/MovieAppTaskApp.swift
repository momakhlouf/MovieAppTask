//
//  MovieAppTaskApp.swift
//  MovieAppTask
//
//  Created by Mohamed Makhlouf Ahmed on 18/05/2026.
//

import SwiftUI
import MoviesListModule
@main
struct MovieAppTaskApp: App {
    var body: some Scene {
        WindowGroup {
            MoviesView(viewModel: MoviesDIContainer.makeMoviesViewModel())
        }
    }
}
