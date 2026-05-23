//
//  File.swift
//  MovieDetailsModule
//
//  Created by Mohamed Makhlouf Ahmed on 22/05/2026.
//

import Foundation

enum MovieDetailsContentState {
    case loading
    case success(MovieDetailsModel)
    case error(String)
}
