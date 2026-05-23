//
//  File.swift
//  MovieDetailsModule
//
//  Created by Mohamed Makhlouf Ahmed on 22/05/2026.
//

import Foundation
import Combine
import Networking

public protocol MovieDetailsAPIClientProtocol {
    func getMovieDetails(_ movieId: Int) -> AnyPublisher<MovieDetailsResponse, NetworkError>
}

public class MovieDetailsAPIClient: MovieDetailsAPIClientProtocol {
    private let apiClient: BaseAPIClient
    public init(apiClient: BaseAPIClient) {
        self.apiClient = apiClient
    }
    
   public func getMovieDetails(_ movieId: Int) -> AnyPublisher<MovieDetailsResponse, NetworkError>{
        let request = MovieDetailsAPIRequest.getMovieDetails(id: movieId)
        return apiClient.execute(request)
    }

}
