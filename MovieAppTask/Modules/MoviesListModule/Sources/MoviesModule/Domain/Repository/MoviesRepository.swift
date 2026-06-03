//
//  File.swift
//  MoviesListModule
//
//  Created by Mohamed Makhlouf Ahmed on 19/05/2026.
//

import Foundation
import Combine
import Networking
import LocalStorage
import CoreModels


public final class MoviesRepository: MovieRepositoryProtocol{
    private let client: MoviesAPIClientProtocol
    private let cache: MoviesCacheProtocol
    
    public init(client: MoviesAPIClientProtocol, cache: MoviesCacheProtocol){
        self.client = client
        self.cache = cache
    }
    
    public func getMovies(currentPage: Int) -> AnyPublisher<MoviesModel, AppError> {
        return client.getMovies(page: currentPage)
            .map { response in
                let movies = response.movies?.map { $0.toDomain() } ?? []
                self.cache.saveMovies(movies, page: currentPage)
                return MoviesModel(
                    page: response.page,
                    movies: movies,
                    totalPages: response.totalPages)
            }
            .catch { (error: NetworkError)  in
                 self.cache.getMovies(page: currentPage)
                    .flatMap { movies -> AnyPublisher<MoviesModel, AppError> in
                        if !movies.isEmpty {
                            return Just(
                                MoviesModel(
                                    page: currentPage,
                                    movies: movies,
                                    totalPages: nil,
                                    isFromCache: true
                                )
                            )
                            .setFailureType(to: AppError.self)
                            .eraseToAnyPublisher()
                        }
                        return Fail(error: error.toAppError())
                            .eraseToAnyPublisher()
                    }
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
        
    }
    
    public func searchMovies(searchText: String, searchPage: Int) -> AnyPublisher<MoviesModel, AppError> {
        client.searchMovie(searchText: searchText, searchPage: searchPage)
            .map{response in
                MoviesModel(
                    page: response.page,
                    movies: response.movies?.map{$0.toDomain()} ?? [],
                    totalPages: response.totalPages)
            }
            .mapError { $0.toAppError() }
            .eraseToAnyPublisher()
    }
    public func getGenres() -> AnyPublisher<[Genre], AppError> {
        client.getGenres()
            .map{response in
                response.genres?.map{$0.toDomain()} ?? []
            }
            .mapError { $0.toAppError() }
            .catch { _ in Just([]).setFailureType(to: AppError.self) }
            .eraseToAnyPublisher()
    }
}


