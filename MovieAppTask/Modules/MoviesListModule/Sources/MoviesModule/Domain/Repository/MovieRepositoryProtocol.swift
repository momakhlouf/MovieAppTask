//
//  File.swift
//  MoviesListModule
//
//  Created by Mohamed Makhlouf Ahmed on 19/05/2026.
//

import Networking
import Combine
import CoreModels
protocol MovieRepositoryProtocol {
    func getMovies(currentPage: Int) -> AnyPublisher<MoviesModel, NetworkError>
    func searchMovies(searchText: String, searchPage: Int) -> AnyPublisher<MoviesModel, NetworkError>
    func getGenres() -> AnyPublisher<[Genre], NetworkError>
}
