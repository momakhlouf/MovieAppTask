//
//  SwiftUIView.swift
//  MoviesListModule
//
//  Created by Mohamed Makhlouf Ahmed on 20/05/2026.
//

import SwiftUI
import DesignSystem
import CoreModels

struct MovieCardView: View {
    let movie: Movie
    var body: some View {
        VStack(alignment: .leading){
            ImageLoaderView(url: movie.posterURL, contentMode: .fit, height: 250)
                .clipped()
                .clipShape(RoundedRectangle(cornerRadius: 12))
            Text(movie.title ?? "")
                .font(.headline)
                .fontWeight(.semibold)
                .lineLimit(2)
                .minimumScaleFactor(0.7)
                .multilineTextAlignment(.leading)
                .frame(height: 50, alignment: .top)
            Text(movie.releaseDate?.displayFormat ?? "")
        }
        .frame(maxWidth: .infinity)
        .padding(6)
        .background{
            RoundedRectangle(cornerRadius: 12)
                .foregroundStyle(Color.gray.opacity(0.2))
        }
    }
}


#Preview {
    MoviesView(viewModel: MoviesDIContainer.makeMoviesViewModel())
}
