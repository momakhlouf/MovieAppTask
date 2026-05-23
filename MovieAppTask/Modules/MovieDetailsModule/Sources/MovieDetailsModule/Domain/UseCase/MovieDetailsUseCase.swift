//
//  File.swift
//  MovieDetailsModule
//
//  Created by Mohamed Makhlouf Ahmed on 22/05/2026.
//

import Foundation
import Networking
import Combine
import CoreModels

public protocol MovieDetailsUseCaseProtocol{
    func getMovieDetails(id: Int) -> AnyPublisher<MovieDetailsModel, NetworkError>
}

public class MovieDetailsUseCase: MovieDetailsUseCaseProtocol {
    private let repository: MovieDetailsRepositoryProtocol
    
    public init(repository: MovieDetailsRepositoryProtocol) {
        self.repository = repository
    }
   public func getMovieDetails(id: Int) -> AnyPublisher<MovieDetailsModel, NetworkError> {
        repository.getMovieDetails(id: id)
    }
}
