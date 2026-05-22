//
//  File.swift
//  MoviesListModule
//
//  Created by Mohamed Makhlouf Ahmed on 22/05/2026.
//

import Combine
import XCTest
import Networking
import CoreModels
@testable import MoviesListModule

final class MoviesRepositoryTests: XCTestCase {
    
    func test_fetchMovies_offline_returnsCache() {
        
        let api = MockAPIClient()
        api.shouldFail = true
        
        let cache = MockCache()
        cache.movies = [
            Movie(id: 1, posterPath: nil, title: "Test", genreIDs: nil, releaseDate: nil)
        ]
        
        let repo = MoviesRepository(client: api, cache: cache)
        
        let exp = expectation(description: "Offline fetch")
        
        _ = repo.getMovies(currentPage: 1)
            .sink(receiveCompletion: { _ in },
                  receiveValue: { result in
                XCTAssertEqual(result.movies.count, 1)
                exp.fulfill()
            })
        
        wait(for: [exp], timeout: 1)
    }
}
