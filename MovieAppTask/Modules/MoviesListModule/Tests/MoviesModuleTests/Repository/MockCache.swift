//
//  File.swift
//  MoviesListModule
//
//  Created by Mohamed Makhlouf Ahmed on 21/05/2026.
//

import Foundation
import LocalStorage
import Combine
import Networking
import CoreModels

class MockCache: MoviesCacheProtocol {
    
    var savedMovies: [Movie] = []

    func saveMovies(_ movies: [Movie], page: Int) {
        savedMovies.append(contentsOf: movies)
      }
    
    func getMovies(page: Int) -> AnyPublisher<[Movie], Never> {
        Just(savedMovies)
            .eraseToAnyPublisher()
    }
}
