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
class MoviesRepository: MovieRepositoryProtocol{
    let client: MoviesAPIClientProtocol
    let cache: MoviesCacheManagerProtocol
    
    init(client: MoviesAPIClientProtocol, cache: MoviesCacheManagerProtocol) {
        self.client = client
        self.cache = cache
    }
    
    func getMovies(currentPage: Int) -> AnyPublisher<MoviesModel, NetworkError> {
        client.getMovies(page: currentPage)
            .map{ response in
                let movies = response.movies?.map{$0.toDomain()} ?? []
                if currentPage == 1 {
                    self.cache.clear()
                    }
                self.cache.save(movies: movies)
                return MoviesModel(page: response.page, movies: movies, totalPages: response.totalPages)
            }
            .catch{ _ in                
                self.cache.fetchMovies()
                    .map{
                        MoviesModel(page: 1, movies: $0, totalPages: 1)
                    }
                    .mapError({ _ in
                        NetworkError.Transport(.unknown)
                    })
            }
            .eraseToAnyPublisher()
    }
    
    func searchMovies(searchText: String, searchPage: Int) -> AnyPublisher<MoviesModel, NetworkError> {
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

//            .map{response in
//                MoviesModel(
//                    page: response.page,
//                    movies: response.movies?.map{$0.toDomain()} ?? [],
//                    totalPages: response.totalPages)
