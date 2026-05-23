//
//  File.swift
//  MovieDetailsModule
//
//  Created by Mohamed Makhlouf Ahmed on 22/05/2026.
//

import Foundation
public struct MovieDetailsModel {
  let id: Int?
  let originalLanguage, originalTitle, overview: String?
  let status: String?
  let posterPath: String?
  let releaseDate: String?
  let genres: [MovieDetailsGenreModel]?
  let homepage: String?
  let budget: Int?
  let revenue, runtime: Int?
  let spokenLanguages: [SpokenLanguageModel]?
  var posterURL : URL? {
       guard let posterPath else { return nil }
       return URL(string: "https://image.tmdb.org/t/p/w500/\(posterPath)")
    }
}

// MARK: - Genre
struct MovieDetailsGenreModel {
    let id: Int?
    let name: String?
}

// MARK: - SpokenLanguage
struct SpokenLanguageModel {
    let englishName, name: String?
}

extension MovieDetailsModel {
    var languagesText: String {
        spokenLanguages?
            .compactMap { $0.englishName }
            .joined(separator: ", ") ?? ""
    }
    
    var genresText: String {
        genres?
            .compactMap { $0.name }
            .joined(separator: ", ") ?? ""
    }
}

extension MovieDetailsModel {
    static func mock() -> MovieDetailsModel {
        return MovieDetailsModel(
            id: 1,
            originalLanguage: "en",
            originalTitle: "Test Movie",
            overview: "This is a test movie overview This is a test movie overview This is a test movie overview ",
            status: "Released",
            posterPath: "/test.jpg",
            releaseDate: "2024-01-01",
            genres: [
                MovieDetailsGenreModel(id: 1, name: "Action"),
                MovieDetailsGenreModel(id: 2, name: "Drama")
            ],
            homepage: "https://example.com",
            budget: 1000000,
            revenue: 5000000,
            runtime: 120,
            spokenLanguages: [
                SpokenLanguageModel(englishName: "English", name: "English"),
                SpokenLanguageModel(englishName: "Arabic", name: "العربية")
            ]
        )
    }
}
