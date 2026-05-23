//
//  File.swift
//  MovieDetailsModule
//
//  Created by Mohamed Makhlouf Ahmed on 22/05/2026.
//

import Foundation

public struct MovieDetailsResponse: Codable{
    let id: Int
    let adult: Bool?
    let backdropPath: String?
    let budget: Int?
    let genres: [MovieDetailsGenreResponse]?
    let homepage: String?
    let imdbID: String?
    let originCountry: [String]?
    let originalLanguage, originalTitle, overview: String?
    let popularity: Double?
    let posterPath: String?
    let releaseDate: String?
    let revenue, runtime: Int?
    let spokenLanguages: [SpokenLanguageResponse]?
    let status, tagline, title: String?
    let voteAverage: Double?
    let voteCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case budget, genres, homepage, id
        case imdbID = "imdb_id"
        case originCountry = "origin_country"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case revenue, runtime
        case spokenLanguages = "spoken_languages"
        case status, tagline, title
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

// MARK: - Genre
struct MovieDetailsGenreResponse: Codable {
    let id: Int
    let name: String?
}

// MARK: - SpokenLanguage
struct SpokenLanguageResponse: Codable {
    let englishName, name: String?
    
    enum CodingKeys: String, CodingKey {
        case englishName = "english_name"
        case name
    }
}

extension MovieDetailsResponse {
    
    func toDomain() -> MovieDetailsModel {
        return MovieDetailsModel(
            id: id,
            originalLanguage: originalLanguage,
            originalTitle: originalTitle,
            overview: overview,
            status: status,
            posterPath: posterPath,
            releaseDate: releaseDate,
            genres: genres?.map { $0.toDomain() },
            homepage: homepage,
            budget: budget,
            revenue: revenue,
            runtime: runtime,
            spokenLanguages: spokenLanguages?.map { $0.toDomain() }
        )
    }
}

extension MovieDetailsGenreResponse {
    
    func toDomain() -> MovieDetailsGenreModel {
        return MovieDetailsGenreModel(
            id: id,
            name: name
        )
    }
}

extension SpokenLanguageResponse {
    
    func toDomain() -> SpokenLanguageModel {
        return SpokenLanguageModel(
            englishName: englishName,
            name: name
        )
    }
}
