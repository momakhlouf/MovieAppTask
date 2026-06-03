//
//  File.swift
//  MovieDetailsModule
//
//  Created by Mohamed Makhlouf Ahmed on 22/05/2026.
//

import Foundation
import Combine
import CoreModels

public protocol MovieDetailsUseCaseProtocol{
    func getMovieDetails(id: Int) -> AnyPublisher<MovieDetailsModel, AppError>
}

public class MovieDetailsUseCase: MovieDetailsUseCaseProtocol {
    private let repository: MovieDetailsRepositoryProtocol
    
    public init(repository: MovieDetailsRepositoryProtocol) {
        self.repository = repository
    }
   public func getMovieDetails(id: Int) -> AnyPublisher<MovieDetailsModel, AppError> {
        repository.getMovieDetails(id: id)
    }
}
