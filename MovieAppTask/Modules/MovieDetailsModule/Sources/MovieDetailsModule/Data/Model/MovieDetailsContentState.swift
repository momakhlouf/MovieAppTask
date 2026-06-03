//
//  File.swift
//  MovieDetailsModule
//
//  Created by Mohamed Makhlouf Ahmed on 22/05/2026.
//

import Foundation
import CoreModels
enum MovieDetailsContentState {
    case loading
    case success(MovieDetailsModel)
    case error(AppError)
}
