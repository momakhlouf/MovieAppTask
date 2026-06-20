//
//  File.swift
//  MoviesListModule
//
//  Created by Mohamed Makhlouf Ahmed on 19/05/2026.
//

import Combine
import CoreModels
public protocol MovieRepositoryProtocol {
    func getMovies(currentPage: Int) -> AnyPublisher<MoviesModel, AppError>
    func getMoviesCacheFirst(currentPage: Int) -> AnyPublisher<MoviesModel, AppError>
    func searchMovies(searchText: String, searchPage: Int) -> AnyPublisher<MoviesModel, AppError>
    func getGenres() -> AnyPublisher<[Genre], AppError>
  //  func getMovies(currentPage: Int) async throws -> MoviesModel
}
