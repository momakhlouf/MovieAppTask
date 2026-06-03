//
//  File.swift
//  MoviesListModule
//
//  Created by Mohamed Makhlouf Ahmed on 21/05/2026.
//

import Combine
import Networking
import CoreModels
@testable import MoviesListModule

final class MockMoviesUseCase: MoviesUseCaseProtocol {
    
    var moviesResult: Result<MoviesModel, AppError>?
    var genresResult: Result<[Genre], AppError>?
    
    func getMovies(page: Int) -> AnyPublisher<MoviesModel, AppError> {
        switch moviesResult {
        case .success(let data):
            return Just(data)
                .setFailureType(to: AppError.self)
                .eraseToAnyPublisher()
        case .failure(let error):
            return Fail(error: error)
                .eraseToAnyPublisher()
        case .none:
            return Empty().eraseToAnyPublisher()
        }
    }
    
    func searchMovies(searchText: String, page: Int) -> AnyPublisher<MoviesModel, AppError> {
        fatalError("Not used")
    }
    
    func getGenres() -> AnyPublisher<[Genre], AppError> {
        switch genresResult {
        case .success(let data):
            return Just(data)
                .setFailureType(to: AppError.self)
                .eraseToAnyPublisher()
        case .failure(let error):
            return Fail(error: error)
                .eraseToAnyPublisher()
        case .none:
            return Empty()
                .eraseToAnyPublisher()
        }
    }
}
