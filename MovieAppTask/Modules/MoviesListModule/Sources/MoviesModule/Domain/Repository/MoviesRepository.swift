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
    
    public func getMovies(currentPage: Int) -> AnyPublisher<MoviesModel, NetworkError> {
        return client.getMovies(page: currentPage)
            .map { response in
                
                let movies = response.movies?.map { $0.toDomain() } ?? []
                self.cache.saveMovies(movies, page: currentPage)
                return MoviesModel(
                    page: response.page,
                    movies: response.movies?.map{$0.toDomain()} ?? [],
                    totalPages: response.totalPages)
            }
            .catch { _ in
                // fallback to cache
                self.cache.getAllMovies()
                    .map {
                        MoviesModel(
                            page: currentPage,
                            movies: $0,
                            totalPages: nil
                        )
                    }
                    .setFailureType(to: NetworkError.self)
            }
            .eraseToAnyPublisher()
        
    }
    public func searchMovies(searchText: String, searchPage: Int) -> AnyPublisher<MoviesModel, NetworkError> {
        client.searchMovie(searchText: searchText, searchPage: searchPage)
            .map{response in
                MoviesModel(
                    page: response.page,
                    movies: response.movies?.map{$0.toDomain()} ?? [],
                    totalPages: response.totalPages)
            }
            .eraseToAnyPublisher()
    }
    public func getGenres() -> AnyPublisher<[Genre], NetworkError> {
        client.getGenres()
            .map{response in
                response.genres?.map{$0.toDomain()} ?? []
            }
            .eraseToAnyPublisher()
    }
}


