//
//  SwiftUIView.swift
//  MoviesListModule
//
//  Created by Mohamed Makhlouf Ahmed on 22/05/2026.
//

import SwiftUI
import CoreModels
import DesignSystem
struct GenreItemView: View {
    let genre: Genre
    let isSelected: Bool
    let onTap: () -> Void
    var body: some View {
        Text(genre.name ?? "")
            .padding(.horizontal,10)
            .padding(.vertical, 5)
            .background{
                if isSelected{
                    Capsule()
                        .fill(Color.customYellow)
                }else{
                    Capsule()
                        .stroke(Color.customYellow, lineWidth: 2)
                }
            }
            .padding(2)
            .onTapGesture {
                onTap()
            }
    }
}
