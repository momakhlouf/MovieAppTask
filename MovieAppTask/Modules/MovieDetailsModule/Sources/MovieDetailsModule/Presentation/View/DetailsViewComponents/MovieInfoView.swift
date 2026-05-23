//
//  SwiftUIView.swift
//  MovieDetailsModule
//
//  Created by Mohamed Makhlouf Ahmed on 22/05/2026.
//

import SwiftUI
import DesignSystem

struct MovieInfoView: View {
    let movie: MovieDetailsModel
    var body: some View {
        HStack(alignment: .top){
            ImageLoaderView(url: movie.posterURL, contentMode: .fit)
                .frame(width: 100,height: 120)
            VStack(alignment: .leading){
                Text(movie.originalTitle ?? "")
                    .font(.title2)
                    .bold()
                HStack(spacing: 0){
                    Text(movie.genresText)
                    
                    .font(.caption)
                    
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    MovieDetailsView(viewModel: MovieDetailsDIContainer.makeMovieDetailsViewModel(id: 12) )
}
