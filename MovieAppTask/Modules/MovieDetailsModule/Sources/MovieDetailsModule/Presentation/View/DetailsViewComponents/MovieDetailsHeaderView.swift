//
//  SwiftUIView.swift
//  MovieDetailsModule
//
//  Created by Mohamed Makhlouf Ahmed on 22/05/2026.
//

import SwiftUI
import DesignSystem
struct MovieDetailsHeaderView: View {
    let movie: MovieDetailsModel
    var body: some View {
        GeometryReader { geo in
            let offset = geo.frame(in: .global).minY
            ImageLoaderView(url: movie.posterURL, contentMode: .fit)
                .scaledToFill()
                .frame(width: geo.size.width,
                       height: offset > 0 ? 300 + offset : 300)
                .clipped()
                .offset(y: offset > 0 ? -offset : 0) // Stick on scroll up
        }
        .frame(height: 300)
    }
}

#Preview {
    MovieDetailsView(viewModel: MovieDetailsDIContainer.makeMovieDetailsViewModel(id: 12) )
}
