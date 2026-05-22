//
//  File.swift
//  MoviesListModule
//
//  Created by Mohamed Makhlouf Ahmed on 20/05/2026.
//

import Foundation
import Networking
import LocalStorage
import Commons
import SwiftData
public struct MoviesDIContainer {
    public static func makeMoviesViewModel() -> MoviesViewModel {
        let baseClient = BaseAPIClient(baseURL: APIConfig.baseURL, apiKey: APIConfig.apiKey)
        
        let container = try! ModelContainer(for: MovieEntity.self)
        let context = ModelContext(container)
        
        let cache = MoviesCacheManager(context: context)
        let moviesAPIClient  = MoviesAPIClient(apiClient: baseClient)
        let moviesRepository = MoviesRepository(client: moviesAPIClient, cache: cache)
        
        return MoviesViewModel(useCase: MoviesUseCase(repository: moviesRepository))
    }
}
