//
//  File.swift
//  MovieDetailsModule
//
//  Created by Mohamed Makhlouf Ahmed on 22/05/2026.
//

import Foundation
import Combine
import Networking

 class MovieDetailsRepository: MovieDetailsRepositoryProtocol{
    
    let client: MovieDetailsAPIClientProtocol
    
     init(client: MovieDetailsAPIClientProtocol) {
        self.client = client
    }
    
    func getMovieDetails(id: Int) -> AnyPublisher<MovieDetailsModel, NetworkError> {
        return client.getMovieDetails(id)
            .map { response in
                response.toDomain()
            }
            .eraseToAnyPublisher()
    }
}

