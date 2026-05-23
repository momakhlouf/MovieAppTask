//
//  File.swift
//  MoviesListModule
//
//  Created by Mohamed Makhlouf Ahmed on 19/05/2026.
//

import Foundation
import Networking
import Combine
import CoreModels

public protocol MoviesUseCaseProtocol {
    func getMovies(page: Int) -> AnyPublisher<MoviesModel, NetworkError>
    func searchMovies(searchText: String, page: Int) -> AnyPublisher<MoviesModel, NetworkError>
    func getGenres() -> AnyPublisher<[Genre], NetworkError>

}

public class MoviesUseCase: MoviesUseCaseProtocol {
    public let repository: MovieRepositoryProtocol
    public init(repository: MovieRepositoryProtocol) {
        self.repository = repository
    }
    public func getMovies(page: Int) -> AnyPublisher<MoviesModel, NetworkError> {
        repository.getMovies(currentPage: page)
    }
    public func searchMovies(searchText: String, page: Int) -> AnyPublisher<MoviesModel, NetworkError> {
        repository.searchMovies(searchText: searchText, searchPage: page)
    }
    public func getGenres() -> AnyPublisher<[Genre], NetworkError> {
        repository.getGenres()
    }
}
