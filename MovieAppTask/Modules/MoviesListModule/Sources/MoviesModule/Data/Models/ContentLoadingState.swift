//
//  File.swift
//  MoviesListModule
//
//  Created by Mohamed Makhlouf Ahmed on 23/05/2026.
//

import Foundation
import CoreModels
enum ContentLoadingState: Equatable {
    case loading
    case complete
    case empty
    case error(AppError)
}
