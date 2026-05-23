//
//  File.swift
//  MovieDetailsModule
//
//  Created by Mohamed Makhlouf Ahmed on 23/05/2026.
//

import Foundation
import Combine
import Networking
@testable import MovieDetailsModule

class MockMovieDetailsUseCase: MovieDetailsUseCaseProtocol {
    var result: Result<MovieDetailsModel, NetworkError>?
          
      func getMovieDetails(id: Int) -> AnyPublisher<MovieDetailsModel, NetworkError> {
          guard let result else {
              fatalError("Result not set ")
          }
          return result.publisher.eraseToAnyPublisher()
      }
}
