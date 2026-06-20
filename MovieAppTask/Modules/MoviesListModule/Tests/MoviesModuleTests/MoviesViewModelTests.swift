//
//  Test.swift
//  MoviesListModule
//
//  Created by Mohamed Makhlouf Ahmed on 21/05/2026.
//

import Combine
import XCTest
import Networking
import CoreModels
@testable import MoviesListModule

final class MoviesViewModelTests: XCTestCase {
 
    private var sut: MoviesViewModel!
    private var mockUseCase: MockMoviesUseCase!
    private var cancellables: Set<AnyCancellable>!
 
    override func setUp() {
        super.setUp()
        mockUseCase = MockMoviesUseCase()
        sut = MoviesViewModel(useCase: mockUseCase)
        cancellables = []
    }
    override func tearDown() {
        sut = nil
        mockUseCase = nil
        cancellables = nil
        super.tearDown()
    }
}
 
// MARK: - getMovies Tests
 
extension MoviesViewModelTests {
    
    func test_getMovies_success_updatesMoviesAndState() {
            let movie = Movie(id: 1, posterPath: nil, title: "Batman", genreIDs: [1], releaseDate: nil)
            mockUseCase.moviesResult = .success(
                MoviesModel(page: 1, movies: [movie], totalPages: 1)
            )
            
            let exp = expectation(description: "Movies loaded")
            
            sut.$movies
                .dropFirst()
                .sink { movies in
                    XCTAssertEqual(movies.count, 1)
                    exp.fulfill()
                }
                .store(in: &cancellables)
            
            sut.getMovies()
            wait(for: [exp], timeout: 1)
            XCTAssertEqual(sut.loadingState, .complete)
        }
        
        func test_getMovies_empty_showsEmptyState() {
            mockUseCase.moviesResult = .success(
                MoviesModel(page: 1, movies: [], totalPages: 1)
            )
            
            let exp = expectation(description: "Empty state")
            
            sut.$loadingState
                .dropFirst()
                .sink { state in
                    if state == .empty {
                        exp.fulfill()
                    }
                }
                .store(in: &cancellables)
            
            sut.getMovies()
            wait(for: [exp], timeout: 1)
        }
        
        func test_getMovies_failure_setsErrorState_whenNoData() {
            mockUseCase.moviesResult = .failure(.unknown)
            
            let exp = expectation(description: "Error state")
            
            sut.$loadingState
                .dropFirst()
                .sink { state in
                    if case .error = state {
                        exp.fulfill()
                    }
                }
                .store(in: &cancellables)
            
            sut.getMovies()
            wait(for: [exp], timeout: 1)
        }

        
    func test_search_filtersMoviesLocally() {
        let movie1 = Movie(id: 1, posterPath: nil, title: "Batman", genreIDs: nil, releaseDate: nil)
        let movie2 = Movie(id: 2, posterPath: nil, title: "Superman", genreIDs: nil, releaseDate: nil)

        mockUseCase.moviesResult = .success(
            MoviesModel(page: 1, movies: [movie1, movie2], totalPages: 1)
        )

        sut.getMovies()
        RunLoop.main.run(until: Date(timeIntervalSinceNow: 0.1))

        sut.searchText = "bat"

        let result = sut.filteredMovies
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first?.title, "Batman")
    }

    func test_genreFilter_filtersCorrectly() {
        let movie1 = Movie(id: 1, posterPath: nil, title: "A", genreIDs: [1], releaseDate: nil)
        let movie2 = Movie(id: 2, posterPath: nil, title: "B", genreIDs: [2], releaseDate: nil)

        mockUseCase.moviesResult = .success(
            MoviesModel(page: 1, movies: [movie1, movie2], totalPages: 1)
        )

        sut.getMovies()
        RunLoop.main.run(until: Date(timeIntervalSinceNow: 0.1))

        sut.selectGenre(1)

        let result = sut.filteredMovies
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first?.id, 1)
    }
    
    func test_getMovies_loadMore_appendsMoviesCorrectly() {

        let moviePage1 = Movie(id: 1, posterPath: nil, title: "A", genreIDs: nil, releaseDate: nil)
        let moviePage2 = Movie(id: 2, posterPath: nil, title: "B", genreIDs: nil, releaseDate: nil)

        mockUseCase.moviesResult = .success(
            MoviesModel(page: 1, movies: [moviePage1], totalPages: 2)
        )

        let exp1 = expectation(description: "first page")

        var cancellables = Set<AnyCancellable>()

        sut.$movies
            .dropFirst()
            .sink { movies in
                if movies.count == 1 {
                    exp1.fulfill()
                }
            }
            .store(in: &cancellables)

        sut.getMovies()

        wait(for: [exp1], timeout: 1)

        mockUseCase.moviesResult = .success(
            MoviesModel(page: 2, movies: [moviePage2], totalPages: 2)
        )

        let exp2 = expectation(description: "second page")

        sut.$movies
            .dropFirst()
            .sink { movies in
                if movies.count == 2 {
                    XCTAssertTrue(movies.contains(where: { $0.id == 1 }))
                    XCTAssertTrue(movies.contains(where: { $0.id == 2 }))
                    exp2.fulfill()
                }
            }
            .store(in: &cancellables)

        sut.handlePagination(movie: moviePage1)

        wait(for: [exp2], timeout: 1)
    }
    
    func test_pagination_stopsAtLastPage() {

        let movie = Movie(id: 1, posterPath: nil, title: "A", genreIDs: nil, releaseDate: nil)

        mockUseCase.moviesResult = .success(
            MoviesModel(page: 1, movies: [movie], totalPages: 1)
        )

        let exp = expectation(description: "movies loaded")

        var cancellables = Set<AnyCancellable>()

        sut.$movies
            .dropFirst()
            .sink { movies in
                if !movies.isEmpty {
                    exp.fulfill()
                }
            }
            .store(in: &cancellables)

        sut.getMovies()

        wait(for: [exp], timeout: 1)
        sut.handlePagination(movie: movie)

        XCTAssertEqual(sut.loadingState, .complete)
    }
    
    func test_navigate_appendsDestinationToPath() {
        let coordinator = MovieCoordinator()
        
        coordinator.navigate(to: .movieDetails(id: 10))
        
        XCTAssertEqual(coordinator.path.count, 1)
    }
}
 

