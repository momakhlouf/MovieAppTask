//
//  SwiftUIView.swift
//  DesignSystem
//
//  Created by Mohamed Makhlouf Ahmed on 22/05/2026.
//

import SwiftUI

public enum EmptyStateType {
    case noMovies
    case noResults(String)
    case error(String)
}

public struct EmptyContentView: View {
    let type: EmptyStateType
    let action: (() -> Void)?
    
    public init(type: EmptyStateType, action: (() -> Void)? = nil) {
        self.type = type
        self.action = action
    }
    
    public var body: some View {
        VStack(spacing: 16) {
            Spacer()
            Image(systemName: icon)
                .font(.system(size: 100))
            
            Text(title)
                .font(.headline)
            
            Text(subtitle)
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .padding()
            
            if let action {
                Button("Retry", action: action)
                    .frame(width: 100)
                    .foregroundStyle(.white)
                    .padding()
                    .background(Color("customYellow", bundle: .module))
                    .cornerRadius(10)
            }
            Spacer()
        }
    }
    
    private var icon: String {
        switch type {
        case .noMovies: return "slash.circle"
        case .noResults: return "magnifyingglass"
        case .error: return "slash.circle"
        }
    }
    
    private var title: String {
        switch type {
        case .noMovies:
            return "No Movies Yet"
        case .noResults:
            return "No Results Found"
        case .error:
            return "Something Went Wrong"
        }
    }
    
    private var subtitle: String {
        switch type {
        case .noMovies:
            return "There are no movies available right now. Please check back later."
        case .noResults(let text):
            return "No results for '\(text)' , Try a different search."
        case .error(let message):
            return message
        }
    }
}
