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
        
        let moviesAPIClient = MoviesAPIClient(apiClient: baseClient)
        let cacheManager = MoviesCacheManager()
        
        let moviesRepository = MoviesRepository(client: moviesAPIClient, cache: cacheManager)
        let moviesUseCase = MoviesUseCase(repository: moviesRepository)
        return MoviesViewModel(useCase: moviesUseCase)
    }
}


