//
//  File.swift
//  MovieDetailsModule
//
//  Created by Mohamed Makhlouf Ahmed on 22/05/2026.
//

import Foundation
import Networking

public struct MovieDetailsDIContainer {
   public static func makeMovieDetailsViewModel(id: Int) -> MovieDetailsViewModel {
        let baseClient = BaseAPIClient(baseURL: APIConfig.baseURL, apiKey: APIConfig.apiKey)
        
        let movieDetailsAPIClient  = MovieDetailsAPIClient(apiClient: baseClient)
        let movieDetailsRepository = MovieDetailsRepository(client: movieDetailsAPIClient)
        let movieDetailsUseCase = MovieDetailsUseCase(repository: movieDetailsRepository)
        
        return MovieDetailsViewModel(useCase: movieDetailsUseCase, movieId: id)
    }
}
