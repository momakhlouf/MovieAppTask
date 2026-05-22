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
                .foregroundStyle(Color.customYellow)
            
            Text(title)
                .font(.headline)
            
            Text(subtitle)
                .font(.subheadline)
            
            if let action {
                Button("Retry", action: action)
                    .frame(width: 100)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color("customYellow", bundle: .module))
                    .cornerRadius(10)
            }
            Spacer()
        }
    }
    
    private var icon: String {
        switch type {
        case .noMovies: return "film.slash"
        case .noResults: return "magnifyingglass"
        case .error: return "wifi.slash"
        }
    }
    
    private var title: String {
        switch type {
        case .noMovies:
            return "No Movies"
        case .noResults:
            return " Sorry"
        case .error:
            return "Error"
        }
    }
    
    private var subtitle: String {
        switch type {
        case .noMovies:
            return "Check later"
        case .noResults(let text):
            return "No results for '\(text)'"
        case .error(let message):
            return message
        }
    }
}
