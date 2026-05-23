//
//  File.swift
//  MovieDetailsModule
//
//  Created by Mohamed Makhlouf Ahmed on 22/05/2026.
//

import Foundation
import Combine
import CoreModels
import Networking

public protocol MovieDetailsRepositoryProtocol {
    func getMovieDetails(id: Int) -> AnyPublisher<MovieDetailsModel, NetworkError>
}
