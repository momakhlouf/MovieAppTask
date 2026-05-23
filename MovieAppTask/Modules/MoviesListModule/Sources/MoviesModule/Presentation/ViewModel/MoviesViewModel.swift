//
//  File.swift
//  MoviesListModule
//
//  Created by Mohamed Makhlouf Ahmed on 19/05/2026.
//

import Combine
import SwiftUI
import CoreModels
import Networking

public final class MoviesViewModel: ObservableObject{
    @Published private(set) var movies: [Movie] = []
    @Published private(set) var genres: [Genre] = []
    @Published private(set) var loadingState: ContentLoadingState = .loading
   // @Published private(set) var filteredMovies: [Movie] = []
    @Published private(set) var selectedGenreID: Int? = nil
    @Published var searchText: String = ""
    
    private var cancellables = Set<AnyCancellable>()
    private var currentPage = 1
    private var totalPages = 1
    private var didLoadInitialData = false
    private let useCase: MoviesUseCaseProtocol
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    init(useCase: MoviesUseCaseProtocol) {
        self.useCase = useCase
      //  bindSearch()
     //   bindFiltering()
    }
}

//MARK: Get Movies
extension MoviesViewModel{
    func getMovies(loadMore: Bool = false){
        if !loadMore {
               resetPagination()
           }
        if loadMore {
            guard currentPage < totalPages else { return }
            currentPage += 1
        }
        useCase.getMovies(page: currentPage)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self else { return }
                if case .failure(let error) = completion {
                    self.loadingState = .error(NetworkError.map(error))
                }
            } receiveValue: { [weak self] returnedData in
                guard let self else { return }
                self.totalPages = returnedData.totalPages ?? 1
                if loadMore {
                    let newMovies = returnedData.movies.filter { newMovie in
                        !self.movies.contains(where: { $0.id == newMovie.id })
                    }
                    self.movies.append(contentsOf: newMovies)
                } else {
                    self.movies = returnedData.movies
                }
                self.loadingState = movies.isEmpty ? .empty: .complete
            }
            .store(in: &cancellables)
    }
    
    private func resetPagination() {
          currentPage = 1
          totalPages = 1
      }
    
    func handlePagination(movie: Movie){
        guard movie.id == filteredMovies.last?.id else { return }
        getMovies(loadMore: true)
    }
}


//MARK: Genres
extension MoviesViewModel{
    func getGenres(){
        useCase.getGenres()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self else { return }
                switch completion{
                case .finished: break
                case .failure(let error):
                    loadingState = .error(NetworkError.map(error))
                }
            } receiveValue: { [weak self] genres in
                guard let self else { return }
                self.genres = genres
            }
            .store(in: &cancellables)
    }
    
    func selectGenre(_ id: Int) {
        if selectedGenreID == id {
            selectedGenreID = nil
        } else {
            selectedGenreID = id
        }
    }
}

extension MoviesViewModel {
    func onAppear() {
        guard !didLoadInitialData else { return }
        didLoadInitialData = true
        loadInitialData()
    }

    private func loadInitialData() {
        getMovies()
        getGenres()
    }
}

//MARK: Filter
extension MoviesViewModel {
    var filteredMovies: [Movie] {
        movies.filter { movie in
            
            let moviesBySearch: Bool = {
                let title = movie.title ?? ""
                return searchText.isEmpty ||
                title.localizedCaseInsensitiveContains(searchText)
            }()
            
            let moviesByGenre: Bool = {
                guard let genreID = selectedGenreID else { return true }
                return movie.genreIDs?.contains(genreID) ?? false
            }()
            
            return moviesBySearch && moviesByGenre
        }
    }
    var isEmptyFilteredResults: Bool {
        filteredMovies.isEmpty && !searchText.isEmpty
    }
}
    
    //MARK: local search filter with combineLatest
    //    private func bindFiltering() {
    //        Publishers.CombineLatest3($movies, $selectedGenreID, $searchText)
    //            .map { movies, selectedGenreID, searchText in
    //                var result = movies
    //
    //                if !searchText.isEmpty {
    //                    result = result.filter {
    //                        $0.title?.lowercased().contains(searchText.lowercased()) ?? false
    //                    }
    //                }
    //                if let genreID = selectedGenreID {
    //                    result = result.filter {
    //                        $0.genreIDs?.contains(genreID) ?? false
    //                    }
    //                }
    //                return result
    //            }
    //            .receive(on: DispatchQueue.main)
    //            .assign(to: &$filteredMovies)
    //    }
    
//MARK: for Search API
//extension MoviesViewModel{
//    private func bindSearch(){
//        $searchText
//            .debounce(for: .milliseconds(400), scheduler: DispatchQueue.main)
//            .removeDuplicates()
//            .sink { [weak self] text in
//                guard let self else { return }
//                self.currentPage = 1
//                self.totalPages = 1
//                if text.isEmpty {
//                    self.selectedGenreID = nil
//                    self.getMovies()
//                }
//                //if search api
//                //  else{
//                //    self.searchMovies()
//                //  }
//            }
//            .store(in: &cancellables)
//    }
//}

//MARK: API Search  - Not required but local.
//    func searchMovies(loadMore: Bool = false){
//        guard loadingState != .loading && loadingState != .loadingMore else { return }
//
//        if loadMore {
//            guard currentPage < totalPages else { return }
//            currentPage += 1
//            loadingState = .loadingMore
//        } else {
//            currentPage = 1
//        }
//        moviesUseCase.searchMovies(searchText: searchText, page: currentPage)
//            .receive(on: DispatchQueue.main)
//            .sink { [weak self] completion in
//                guard let self else { return }
//                switch completion{
//                case .finished: break
//                case .failure(let error):
//                    loadingState = .error(error.userMessage)
//                }
//            } receiveValue: { [weak self] returnedData in
//                guard let self else { return }
//
//                self.totalPages = returnedData.totalPages ?? 1
//                if loadMore {
//                    self.movies.append(contentsOf: returnedData.movies)
//                } else {
//                    self.movies = returnedData.movies
//                }
//                self.loadingState = self.movies.isEmpty ? .empty : .idle
//            }
//            .store(in: &cancellables)
//    }

//    private func bindFiltering() {
//        Publishers.CombineLatest($movies, $selectedGenreID)
//            .map { movies, selectedGenreID in
//                guard let genreID = selectedGenreID else {
//                    return movies
//                }
//                return movies.filter {
//                    $0.genreIDs?.contains(genreID) ?? false
//                }
//            }
//            .receive(on: DispatchQueue.main)
//            .assign(to: &$filteredMovies)
//    }


