//
//  SwiftUIView.swift
//  MoviesListModule
//
//  Created by Mohamed Makhlouf Ahmed on 20/05/2026.
//

import SwiftUI
import CoreModels
struct GenresFilterView: View {
    let genres: [Genre]
    let selectedGenreID: Int?
    let onSelect: (Int) -> Void
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 5) {
                ForEach(genres, id: \.id) { genre in
                    
                    let isSelected = selectedGenreID == genre.id
                    GenreItemView(genre: genre, isSelected: isSelected) {
                        if let id = genre.id {
                            onSelect(id)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    MoviesView(viewModel: MoviesDIContainer.makeMoviesViewModel())
}

