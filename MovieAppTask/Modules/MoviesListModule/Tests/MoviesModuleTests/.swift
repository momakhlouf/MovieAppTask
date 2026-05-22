//
//  File.swift
//  MoviesListModule
//
//  Created by Mohamed Makhlouf Ahmed on 21/05/2026.
//

import Foundation
import Combine
import Networking
import XCTest
@testable import MoviesListModule

class MockMoviesAPIClient: MoviesAPIClientProtocol {
    var shouldFail: Bool = false
    var returnedError: NetworkError = .httpResponse
    
    var moviesResponse: MoviesResponse = MoviesResponse(page: 1, movies: [], totalPages: 1, totalResults: 0)
    
    var genresResponse: GenresResponse = GenresResponse(genres: [])
    
    var getMoviesCallCount = 0
    var searchMovieCallCount = 0
    var getGenresCallCount = 0
    var lastPage: Int?
    var lastSearchText: String?
    
    func getMovies(page: Int) -> AnyPublisher<MoviesResponse, NetworkError> {
        getMoviesCallCount += 1
        lastPage = page
        
        if shouldFail {
            return Fail(error: returnedError).eraseToAnyPublisher()
        }
        return Just(moviesResponse)
            .setFailureType(to: NetworkError.self)
            .eraseToAnyPublisher()
    }
    
    func searchMovie(searchText: String, searchPage: Int) -> AnyPublisher<MoviesResponse, NetworkError> {
        searchMovieCallCount += 1
        lastSearchText = searchText
        lastPage = searchPage
        
        if shouldFail {
            return Fail(error: returnedError).eraseToAnyPublisher()
        }
        return Just(moviesResponse)
            .setFailureType(to: NetworkError.self)
            .eraseToAnyPublisher()
    }
    
    func getGenres() -> AnyPublisher<GenresResponse, NetworkError> {
        getGenresCallCount += 1
        
        if shouldFail {
            return Fail(error: returnedError).eraseToAnyPublisher()
        }
        return Just(genresResponse)
            .setFailureType(to: NetworkError.self)
            .eraseToAnyPublisher()
    }
    
    
    
}

// MARK: - DTO Stubs

extension MovieResponse {
    static func stub(
        id: Int = 1,
        title: String = "Test Movie",
        genreIDs: [Int]? = [28],
        posterPath: String? = "/test.jpg",
        releaseDate: String? = "2024-01-01"
    ) -> MovieResponse {
        MovieResponse(
            adult: false,
            backdropPath: nil,
            genreIDS: genreIDs,
            id: id,
            title: title,
            originalTitle: title,
            overview: nil,
            popularity: 7.5,
            posterPath: posterPath,
            releaseDate: releaseDate,
            softcore: false,
            video: false,
            voteAverage: 8.0,
            voteCount: 100
        )
    }
}

extension MoviesResponse {
    static func stub(
        movies: [MovieResponse] = [],
        totalPages: Int = 1,
        page: Int = 1
    ) -> MoviesResponse {
        MoviesResponse(page: page, movies: movies, totalPages: totalPages, totalResults: movies.count)
    }
}
 
extension GenreResponse {
    static func stub(id: Int = 28, name: String = "Action") -> GenreResponse {
        GenreResponse(id: id, name: name)
    }
}

// MARK: - MoviesRepositoryTests
 
final class MoviesRepositoryTests: XCTestCase {
 
    private var sut: MoviesRepository!
    private var mockClient: MockMoviesAPIClient!
    private var cancellables: Set<AnyCancellable>!
 
    override func setUp() {
        super.setUp()
        mockClient = MockMoviesAPIClient()
        sut = MoviesRepository(client: mockClient)
        cancellables = []
    }
 
    override func tearDown() {
        sut = nil
        mockClient = nil
        cancellables = nil
        super.tearDown()
    }
}
 
// MARK: - getMovies Tests
 
extension MoviesRepositoryTests {
 
    func test_getMovies_mapsResponseToModel_correctly() {
        // Arrange
        let movieResponse = MovieResponse.stub(id: 5, title: "Inception", genreIDs: [28, 35])
        mockClient.moviesResponse = .stub(movies: [movieResponse], totalPages: 5, page: 2)
 
        let expectation = expectation(description: "model received")
        var receivedModel: MoviesModel?
 
        // Act
        sut.getMovies(currentPage: 2)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { model in
                    receivedModel = model
                    expectation.fulfill()
                }
            )
            .store(in: &cancellables)
 
        // Assert
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(receivedModel?.page, 2)
        XCTAssertEqual(receivedModel?.totalPages, 5)
        XCTAssertEqual(receivedModel?.movies.count, 1)
        XCTAssertEqual(receivedModel?.movies.first?.id, 5)
        XCTAssertEqual(receivedModel?.movies.first?.title, "Inception")
        XCTAssertEqual(receivedModel?.movies.first?.genreIDs, [28, 35])
    }
 
    func test_getMovies_passesCorrectPage_toClient() {
        // Arrange
        mockClient.moviesResponse = .stub()
 
        let expectation = expectation(description: "completed")
        sut.getMovies(currentPage: 3)
            .sink(receiveCompletion: { _ in expectation.fulfill() },
                  receiveValue: { _ in })
            .store(in: &cancellables)
 
        // Assert
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(mockClient.lastPage, 3)
        XCTAssertEqual(mockClient.getMoviesCallCount, 1)
    }
 
    func test_getMovies_whenMoviesIsNil_returnsEmptyArray() {
        // Arrange — API returns nil movies
        mockClient.moviesResponse = MoviesResponse(page: 1, movies: nil, totalPages: 1, totalResults: 0)
 
        let expectation = expectation(description: "model received")
        var receivedModel: MoviesModel?
 
        sut.getMovies(currentPage: 1)
            .sink(receiveCompletion: { _ in },
                  receiveValue: { model in
                    receivedModel = model
                    expectation.fulfill()
                  })
            .store(in: &cancellables)
 
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(receivedModel?.movies.count, 0)
    }
 
    func test_getMovies_failure_propagatesError() {
        // Arrange
        mockClient.shouldFail = true
        mockClient.returnedError = .httpResponse
 
        let expectation = expectation(description: "error received")
        var receivedError: NetworkError?
 
        sut.getMovies(currentPage: 1)
            .sink(
                receiveCompletion: { completion in
                    if case .failure(let error) = completion {
                        receivedError = error
                        expectation.fulfill()
                    }
                },
                receiveValue: { _ in }
            )
            .store(in: &cancellables)
 
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(receivedError, .httpResponse)
    }
}
 
// MARK: - searchMovies Tests
 
extension MoviesRepositoryTests {
 
    func test_searchMovies_mapsResponseCorrectly() {
        // Arrange
        let movieResponse = MovieResponse.stub(id: 99, title: "Batman")
        mockClient.moviesResponse = .stub(movies: [movieResponse], totalPages: 2)
 
        let expectation = expectation(description: "search result received")
        var receivedModel: MoviesModel?
 
        sut.searchMovies(searchText: "Batman", searchPage: 1)
            .sink(receiveCompletion: { _ in },
                  receiveValue: { model in
                    receivedModel = model
                    expectation.fulfill()
                  })
            .store(in: &cancellables)
 
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(receivedModel?.movies.first?.title, "Batman")
        XCTAssertEqual(receivedModel?.totalPages, 2)
    }
 
    func test_searchMovies_passesCorrectParams_toClient() {
        // Arrange
        mockClient.moviesResponse = .stub()
 
        let expectation = expectation(description: "completed")
        sut.searchMovies(searchText: "Avengers", searchPage: 2)
            .sink(receiveCompletion: { _ in expectation.fulfill() },
                  receiveValue: { _ in })
            .store(in: &cancellables)
 
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(mockClient.lastSearchText, "Avengers")
        XCTAssertEqual(mockClient.lastPage, 2)
        XCTAssertEqual(mockClient.searchMovieCallCount, 1)
    }
 
    func test_searchMovies_failure_propagatesError() {
        // Arrange
        mockClient.shouldFail = true
        mockClient.returnedError = .decoding
 
        let expectation = expectation(description: "error received")
        var receivedError: NetworkError?
 
        sut.searchMovies(searchText: "anything", searchPage: 1)
            .sink(
                receiveCompletion: { completion in
                    if case .failure(let error) = completion {
                        receivedError = error
                        expectation.fulfill()
                    }
                },
                receiveValue: { _ in }
            )
            .store(in: &cancellables)
 
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(receivedError, .decoding)
    }
}
 
// MARK: - getGenres Tests
 
extension MoviesRepositoryTests {
 
    func test_getGenres_mapsResponseToGenres_correctly() {
        // Arrange
        let genreResponses = [
            GenreResponse.stub(id: 28, name: "Action"),
            GenreResponse.stub(id: 35, name: "Comedy")
        ]
        mockClient.genresResponse = GenresResponse(genres: genreResponses)
 
        let expectation = expectation(description: "genres received")
        var receivedGenres: [Genre]?
 
        sut.getGenres()
            .sink(receiveCompletion: { _ in },
                  receiveValue: { genres in
                    receivedGenres = genres
                    expectation.fulfill()
                  })
            .store(in: &cancellables)
 
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(receivedGenres?.count, 2)
        XCTAssertEqual(receivedGenres?.first?.id, 28)
        XCTAssertEqual(receivedGenres?.first?.name, "Action")
    }
 
    func test_getGenres_whenGenresIsNil_returnsEmptyArray() {
        // Arrange
        mockClient.genresResponse = GenresResponse(genres: nil)
 
        let expectation = expectation(description: "genres received")
        var receivedGenres: [Genre]?
 
        sut.getGenres()
            .sink(receiveCompletion: { _ in },
                  receiveValue: { genres in
                    receivedGenres = genres
                    expectation.fulfill()
                  })
            .store(in: &cancellables)
 
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(receivedGenres?.count, 0)
    }
 
    func test_getGenres_failure_propagatesError() {
        // Arrange
        mockClient.shouldFail = true
        mockClient.returnedError = .httpResponse
 
        let expectation = expectation(description: "error received")
        var receivedError: NetworkError?
 
        sut.getGenres()
            .sink(
                receiveCompletion: { completion in
                    if case .failure(let error) = completion {
                        receivedError = error
                        expectation.fulfill()
                    }
                },
                receiveValue: { _ in }
            )
            .store(in: &cancellables)
 
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(receivedError, .httpResponse)
    }
}
 
// MARK: - Mapping Tests (toDomain)
 
extension MoviesRepositoryTests {
 
    func test_movieResponse_toDomain_mapsPosterURL_correctly() {
        // Arrange
        let response = MovieResponse.stub(posterPath: "/batman.jpg")
 
        // Act
        let movie = response.toDomain()
 
        // Assert
        XCTAssertEqual(movie.posterURL?.absoluteString, "https://image.tmdb.org/t/p/w500//batman.jpg")
    }
 
    func test_movieResponse_toDomain_whenPosterPathIsNil_posterURLIsNil() {
        // Arrange
        let response = MovieResponse.stub(posterPath: nil)
 
        // Act
        let movie = response.toDomain()
 
        // Assert
        XCTAssertNil(movie.posterURL)
    }
 
    func test_movieResponse_toDomain_parsesReleaseDate_correctly() {
        // Arrange
        let response = MovieResponse.stub(releaseDate: "2024-07-15")
 
        // Act
        let movie = response.toDomain()
 
        // Assert
        XCTAssertNotNil(movie.releaseDate)
    }
 
    func test_movieResponse_toDomain_whenReleaseDateIsInvalid_releaseDateIsNil() {
        // Arrange
        let response = MovieResponse.stub(releaseDate: "not-a-date")
 
        // Act
        let movie = response.toDomain()
 
        // Assert
        XCTAssertNil(movie.releaseDate)
    }
}
 
