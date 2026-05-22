//
//  SwiftUIView.swift
//  MoviesListModule
//
//  Created by Mohamed Makhlouf Ahmed on 22/05/2026.
//

import SwiftUI

struct MoviesGridView: View {
    @ObservedObject var viewModel: MoviesViewModel
    var body: some View {
        ScrollViewReader{proxy in
            ScrollView{
                Color.clear
                    .frame(height: 0)
                    .id("top")
                LazyVGrid(columns: viewModel.columns) {
                    ForEach(viewModel.filteredMovies, id: \.id){ movie in
                        MovieCardView(movie: movie)
                            .onAppear{
                                viewModel.handlePagination(movie: movie)
                            }
                            .refreshable {
                                viewModel.getMovies()
                            }
                            .onChange(of: viewModel.selectedGenreID) {
                                withAnimation(.easeInOut){
                                    proxy.scrollTo("top")
                                }
                            }
                            .onChange(of: viewModel.searchText) {
                                withAnimation(.easeInOut){
                                    proxy.scrollTo("top")
                                }
                            }
                    }
                }
            }
        }
    }
}
            
