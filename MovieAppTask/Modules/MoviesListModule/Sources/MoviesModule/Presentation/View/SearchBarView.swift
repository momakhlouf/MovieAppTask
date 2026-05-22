//
//  SwiftUIView.swift
//  MoviesListModule
//
//  Created by Mohamed Makhlouf Ahmed on 20/05/2026.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String
    var body: some View {
        HStack{
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            TextField("Search movies..", text: $searchText)
            if !searchText.isEmpty {
                Button {
                    searchText = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .foregroundStyle(Color.gray.opacity(0.3))
                        .frame(width: 25, height: 25)
                }
            }
        }
        .padding(12)
        .frame(height: 45)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(12)
        .padding(8)
    }
}
#Preview {
    MoviesView(viewModel: MoviesDIContainer.makeMoviesViewModel())
}
