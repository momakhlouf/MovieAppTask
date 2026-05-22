//
//  File.swift
//  MoviesListModule
//
//  Created by Mohamed Makhlouf Ahmed on 19/05/2026.
//

import Foundation
import Combine
import Networking

protocol MoviesAPIClientProtocol{
    func getMovies(page: Int) -> AnyPublisher<MoviesResponse, NetworkError>
    func searchMovie(searchText: String, searchPage: Int) -> AnyPublisher<MoviesResponse, NetworkError>
    func getGenres() -> AnyPublisher<GenresResponse, NetworkError>
    
}

class MoviesAPIClient: MoviesAPIClientProtocol{
    private let apiClient: BaseAPIClient
    init(apiClient: BaseAPIClient) {
        self.apiClient = apiClient
    }
    
    func getMovies(page: Int) -> AnyPublisher<MoviesResponse, NetworkError> {
        let request = MoviesAPIRequest.getMovies(page: page)
        return apiClient.execute(request)
    }
    func searchMovie(searchText: String, searchPage: Int) -> AnyPublisher<MoviesResponse, NetworkError> {
        let request = MoviesAPIRequest.searchMovies(searchText: searchText, searchPage: searchPage)
        return apiClient.execute(request)
    }
    public func getGenres() -> AnyPublisher<GenresResponse, NetworkError> {
        let request = MoviesAPIRequest.getGenres()
        return apiClient.execute(request)
    }
}

    
    
