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

class MockCache: MoviesCacheManagerProtocol {
    func clear() {
    }
    var movies: [Movie] = []
    
    func save(movies: [Movie]) {
        self.movies = movies
    }
    
    func fetchMovies() -> AnyPublisher<[Movie], NetworkError> {
        Just(movies)
            .setFailureType(to: NetworkError.self)
            .eraseToAnyPublisher()
    }
}
