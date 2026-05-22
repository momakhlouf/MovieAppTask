//// MoviesStubs+Tests.swift
//// Test helpers for MoviesListModule tests
//// Created by Assistant on 21/05/2026
//
//import Foundation
//import CoreModels
//@testable import MoviesListModule
//
//// MARK: - Movie Stub
//extension Movie {
//    public static func stub(
//        id: Int = 1,
//        posterPath: String? = nil,
//        title: String = "Title",
//        releaseDate: Date? = nil,
//        genreIds: [Int]? = nil
//    ) -> Movie {
//        return Movie(
//            id: id,
//            posterPath: posterPath,
//            title: title,
//            genreIDs: genreIds,
//            releaseDate: releaseDate
//        )
//    }
//}
//
//// MARK: - MoviesModel Stub
//extension MoviesModel {
//    public static func stub(movies: [Movie] = [],totalPages: Int = 1,page: Int = 1) -> MoviesModel {
//        return MoviesModel(page: page,movies: movies,totalPages: totalPages)
//    }
//}
//
//// MARK: - Genre Stub
//extension Genre {
//    public static func stub(id: Int = 1, name: String = "Genre") -> Genre {
//        return Genre(id: id, name: name)
//    }
//}
//
