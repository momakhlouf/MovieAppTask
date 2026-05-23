//
//  SwiftUIView.swift
//  MoviesListModule
//
//  Created by Mohamed Makhlouf Ahmed on 19/05/2026.
//

import SwiftUI
import DesignSystem
import CoreModels
public struct MoviesView: View {
    @StateObject private var viewModel: MoviesViewModel
    
    public init(viewModel: MoviesViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    public var body: some View {
        mainContent
            .task {
                viewModel.onAppear()
            }
            .safeAreaInset(edge: .top, spacing: 0) {
                safeAreaInsetsView
            }
    }
}

#Preview {
    MoviesView(viewModel: MoviesDIContainer.makeMoviesViewModel())
}

extension MoviesView{
    @ViewBuilder
    var mainContent: some View {
        switch viewModel.loadingState{
        case .complete:
            if viewModel.isEmptyFilteredResults {
                EmptyContentView(type: .noResults(viewModel.searchText))
            } else {
                VStack{
                    GenresFilterView(
                        genres: viewModel.genres,
                        selectedGenreID: viewModel.selectedGenreID,
                        onSelect: { viewModel.selectGenre($0) }
                    )
                    
                    MoviesGridView(
                        movies: viewModel.filteredMovies,
                        columns: viewModel.columns,
                        onMovieAppear: { viewModel.handlePagination(movie: $0) },
                        onRefresh: { viewModel.getMovies() }
                    )
                }
            }
        case .empty:
            EmptyContentView(type: .noMovies) {
                viewModel.getMovies()
            }
        case .error(let error):
            EmptyContentView(type: .error(error.userMessage)) {
                viewModel.getMovies()
            }
            
        case .loading:
            MoviesGridView(
                movies: Movie.mockMovies,
                columns: viewModel.columns,
                onMovieAppear: { _ in },
                onRefresh: { }
            )
            .shimmer(speed: 1.2, color: .black, angle: 20, animateOpacity: true, animateScale: true)
            .redacted(reason: .placeholder)
        }
    }
    
    var safeAreaInsetsView: some View {
        VStack(alignment: .leading ,spacing: 15){
            Text("Watch New Movies")
                .foregroundStyle(Color.customYellow)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.largeTitle.bold())
                .padding(.horizontal, 15)
            SearchBarView(searchText: $viewModel.searchText)
        }
        .background(Color(.systemBackground))
    }
}
