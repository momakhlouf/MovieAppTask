//
//  File.swift
//  MoviesListModule
//
//  Created by Mohamed Makhlouf Ahmed on 21/05/2026.
//

import Foundation
import CoreModels
import LocalStorage
import Combine
import Networking
@testable import MoviesListModule

class MockAPIClient: MoviesAPIClientProtocol {
    
    var shouldFail = false
    
    func getMovies(page: Int) -> AnyPublisher<MoviesResponse, NetworkError> {
        if shouldFail {
            return Fail(error: NetworkError.badURL).eraseToAnyPublisher()
        }
        
        let response = MoviesResponse(
            page: 1,
            movies: [],
            totalPages: 1,
            totalResults: 1
        )
        
        return Just(response)
            .setFailureType(to: NetworkError.self)
            .eraseToAnyPublisher()
    }
    
    func searchMovie(searchText: String, searchPage: Int) -> AnyPublisher<MoviesResponse, NetworkError> {
        fatalError()
    }
    
    func getGenres() -> AnyPublisher<GenresResponse, NetworkError> {
        fatalError()
    }
}
