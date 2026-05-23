//
//  SwiftUIView.swift
//  MoviesListModule
//
//  Created by Mohamed Makhlouf Ahmed on 19/05/2026.
//

import SwiftUI
import DesignSystem

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
        case .idle, .loadingMore:
            if viewModel.filteredMovies.isEmpty && !viewModel.searchText.isEmpty {
                EmptyContentView(type: .noResults(viewModel.searchText))
            } else {
                VStack{
                    GenresFilterView(
                        genres: viewModel.genres,
                        selectedGenreID: viewModel.selectedGenreID,
                        onSelect: { viewModel.selectGenre($0) }
                    )
                    
                    MoviesGridView(viewModel: viewModel)
                }
            }
        case .empty:
            EmptyContentView(type: .noMovies) {
                viewModel.getMovies()
            }
        case .error(let errorMessage ):
            EmptyContentView(type: .error(errorMessage)) {
                viewModel.getMovies()
            }
            
        case .loading:
            ProgressView()
                .frame(maxHeight: .infinity)
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
