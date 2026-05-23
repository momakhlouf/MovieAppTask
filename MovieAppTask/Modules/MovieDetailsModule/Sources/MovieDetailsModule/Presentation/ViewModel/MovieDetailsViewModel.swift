//
//  File.swift
//  MovieDetailsModule
//
//  Created by Mohamed Makhlouf Ahmed on 22/05/2026.
//

import Foundation
import Combine

public final class MovieDetailsViewModel: ObservableObject {
    @Published var state: MovieDetailsContentState = .loading
    
    private let useCase : MovieDetailsUseCaseProtocol
    private var cancellables = Set<AnyCancellable>()
    private let movieId: Int
    
    public init(useCase: MovieDetailsUseCaseProtocol, movieId: Int) {
        self.useCase = useCase
        self.movieId = movieId
    }
    
    func getMovieDetails() {
        state = .loading
        useCase.getMovieDetails(id: movieId)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self else { return }
                switch completion {
                case .failure(let error):
                    self.state = .error(error.userMessage)
                case .finished: break
                }
            } receiveValue: { [weak self] returnedData in
                guard let self else { return }
                self.state = .success(returnedData)
            }
            .store(in: &cancellables)
    }
}

