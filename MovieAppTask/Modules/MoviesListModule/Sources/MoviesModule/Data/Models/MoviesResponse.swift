//
//  File.swift
//  MoviesListModule
//
//  Created by Mohamed Makhlouf Ahmed on 19/05/2026.
//

import Foundation
import Commons
import CoreModels
//MARK: DTO
struct MoviesResponse: Codable {
    let page: Int?
    let movies: [MovieResponse]?
    let totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case page
        case movies = "results"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct MovieResponse: Codable {
    let adult: Bool?
    let backdropPath: String?
    let genreIDS: [Int]?
    let id: Int
    let title: String?
    let originalTitle, overview: String?
    let popularity: Double?
    let posterPath, releaseDate: String?
    let softcore, video: Bool?
    let voteAverage: Double?
    let voteCount: Int?

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id, title
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case softcore, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

extension MovieResponse {
    func toDomain() -> Movie {
        return Movie(
            id: id,
            posterPath: posterPath,
            title: title,
            genreIDs: genreIDS,
            releaseDate: releaseDate.flatMap {
                Date.toString.date(from: $0)
            }
        )
    }
}


