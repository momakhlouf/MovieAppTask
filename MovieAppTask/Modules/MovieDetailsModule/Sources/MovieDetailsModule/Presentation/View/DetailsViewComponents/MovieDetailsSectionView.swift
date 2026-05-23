//
//  SwiftUIView.swift
//  MovieDetailsModule
//
//  Created by Mohamed Makhlouf Ahmed on 23/05/2026.
//

import SwiftUI

struct MovieDetailsSectionView: View {
    let movie: MovieDetailsModel
    private let columns = [
           GridItem(.flexible(), alignment: .leading),
           GridItem(.flexible(), alignment: .leading)
       ]
    var body: some View {
        LazyVGrid(columns: columns, alignment: .leading, spacing: 12) {
                    
                    if let homepage = movie.homepage,
                       !homepage.isEmpty,
                       let url = URL(string: homepage) {
                        
                        detailItem(title: "Homepage") {
                            Link("Visit Website", destination: url)
                        }
                    }
                    
                    detailItem(title: "Languages") {
                        Text(movie.languagesText)
                    }
                    
                    if let status = movie.status {
                        detailItem(title: "Status") {
                            Text(status)
                        }
                    }
                    
                    if let runtime = movie.runtime {
                        detailItem(title: "Runtime") {
                            Text("\(runtime) min")
                        }
                    }
                    
                    if let budget = movie.budget {
                        detailItem(title: "Budget") {
                            Text("\(budget) $")
                        }
                    }
                    
                    if let revenue = movie.revenue {
                        detailItem(title: "Revenue") {
                            Text("\(revenue) $")
                        }
                    }
                }
                .padding(.horizontal, 8)
                .padding(.bottom, 20)
            }
    
    
    @ViewBuilder
    func detailItem<Content: View>(
        title: String,
        @ViewBuilder content: () -> Content
    ) -> some View {
        
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundColor(.gray)
            
            content()
                .font(.caption)
                .fontWeight(.medium)
        }
    }
}

#Preview {
    MovieDetailsView(viewModel: MovieDetailsDIContainer.makeMovieDetailsViewModel(id: 12))
}

