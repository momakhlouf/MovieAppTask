//
//  File.swift
//  MoviesListModule
//
//  Created by Mohamed Makhlouf Ahmed on 23/05/2026.
//

import Foundation
import CoreModels
// in real app, i will make it generic , like:
// enum loadingState<value: decodable>{
//  case .....
//  case loaded or complete(value)
// to use it in all models..
//
enum ContentLoadingState: Equatable {
    case loading
    case complete
    case empty
    case error(AppError)
}
