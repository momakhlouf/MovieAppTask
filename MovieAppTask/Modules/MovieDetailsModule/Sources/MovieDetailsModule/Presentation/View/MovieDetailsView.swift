//
//  SwiftUIView.swift
//  MovieDetailsModule
//
//  Created by Mohamed Makhlouf Ahmed on 22/05/2026.
//

import SwiftUI
import DesignSystem

public struct MovieDetailsView: View {
    @StateObject var viewModel: MovieDetailsViewModel
    
   public init(viewModel: MovieDetailsViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
   public var body: some View {
       
        VStack{
            switch viewModel.state {
            case .loading:
                movieDetailContent(movie: MovieDetailsModel.mock())
                    .shimmer(speed: 1.2, color: .black, angle: 20, animateOpacity: true, animateScale: true)
                    .redacted(reason: .placeholder)
            case .success(let movie):
               movieDetailContent(movie: movie)
                //.ignoresSafeArea(edges: .top)
            case .error(let error):
                EmptyContentView(type: .error(error.userMessage))
            }
        }
        .task {
            viewModel.getMovieDetails()
        }
    }
}

#Preview {
    MovieDetailsView(viewModel: MovieDetailsDIContainer.makeMovieDetailsViewModel(id: 12))
}

extension MovieDetailsView{
    
    func movieDetailContent(movie: MovieDetailsModel) ->some View {
        ScrollView(showsIndicators: false) {
            MovieDetailsHeaderView(movie: movie)
            VStack(alignment: .leading) {
                MovieInfoView(movie: movie)
                overViewView(movie: movie)
                
               MovieDetailsSectionView(movie: movie)
            }
        }
        
    }
    
    func overViewView(movie: MovieDetailsModel) -> some View {
        Text(movie.overview ?? "")
            .font(.caption)
            .fontWeight(.semibold)
            .padding(8)
    }
}
