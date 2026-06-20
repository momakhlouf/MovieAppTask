//
//  File.swift
//  MoviesListModule
//
//  Created by Mohamed Makhlouf Ahmed on 19/05/2026.
//

import Foundation
import Combine
import CoreModels

public protocol MoviesUseCaseProtocol {
    func getMovies(page: Int) -> AnyPublisher<MoviesModel, AppError>
    func searchMovies(searchText: String, page: Int) -> AnyPublisher<MoviesModel, AppError>
    func getGenres() -> AnyPublisher<[Genre], AppError>

}
// in prod will separate use case , one struct for each use case
public struct MoviesUseCase: MoviesUseCaseProtocol {
    public let repository: MovieRepositoryProtocol
    public init(repository: MovieRepositoryProtocol) {
        self.repository = repository
    }
    public func getMovies(page: Int) -> AnyPublisher<MoviesModel, AppError> {
        //repository.getMovies(currentPage: page)
        repository.getMoviesCacheFirst(currentPage: page)
    }
    public func searchMovies(searchText: String, page: Int) -> AnyPublisher<MoviesModel, AppError> {
        repository.searchMovies(searchText: searchText, searchPage: page)
    }
    public func getGenres() -> AnyPublisher<[Genre], AppError> {
        repository.getGenres()
    }
}
