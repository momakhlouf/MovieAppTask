import XCTest
@testable import MovieDetailsModule
import Combine
import Networking

final class MovieDetailsModuleTests: XCTestCase {
    
    private var mockUseCase: MockMovieDetailsUseCase!
    private var viewModel: MovieDetailsViewModel!
    private var cancellables: Set<AnyCancellable>!

    
    override func setUp() {
        super.setUp()
        cancellables = []
        mockUseCase = MockMovieDetailsUseCase()
        viewModel = MovieDetailsViewModel(useCase: mockUseCase, movieId: 1)
    }
    override func tearDown() {
        cancellables = nil
        mockUseCase = nil
        viewModel = nil
        super.tearDown()
    }
    
    func test_getMovieDetails_success() {
        let mockModel = MovieDetailsModel.mock()
        mockUseCase.result = .success(mockModel)
        let expectation = XCTestExpectation(description: "State should be success")
        
        viewModel.$state
            .dropFirst()
            .sink { state in
                if case .success(let data) = state {
                    XCTAssertEqual(data.id, mockModel.id)
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        viewModel.getMovieDetails()
        
        wait(for: [expectation], timeout: 1)
    }
    
    func test_getMovieDetails_failure() {
        let error = NetworkError.httpResponse
        mockUseCase.result = .failure(error)
        
        let expectation = XCTestExpectation(description: "State should be error")
        
        viewModel.$state
            .dropFirst()
            .sink { state in
                if case .error(let message) = state {
                    XCTAssertEqual(message, error.userMessage)
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        viewModel.getMovieDetails()
        
        wait(for: [expectation], timeout: 1)
    }
    
}
