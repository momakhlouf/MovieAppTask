//
//  File.swift
//  MoviesListModule
//
//  Created by Mohamed Makhlouf Ahmed on 23/05/2026.
//

import Foundation

enum ContentLoadingState: Equatable {
    case idle
    case loading
    case loadingMore
    case empty
    case error(_ errorMessage: String)
}
