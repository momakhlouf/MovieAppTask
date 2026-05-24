//
//  File.swift
//  MoviesListModule
//
//  Created by Mohamed Makhlouf Ahmed on 19/05/2026.
//

import Foundation

public struct MoviesModel{
    public let page: Int?
    public let movies: [Movie]
    public let totalPages: Int?
    public let isFromCache: Bool
    
   public init(page: Int?, movies: [Movie], totalPages: Int?, isFromCache: Bool = false) {
        self.page = page
        self.movies = movies
        self.totalPages = totalPages
       self.isFromCache = isFromCache       
    }
}

public struct Movie: Sendable, Equatable{
    public let id: Int
    public let posterPath: String?
    public let title: String?
    public let genreIDs: [Int]?
    public let releaseDate: Date?
    public var posterURL : URL? {
       guard let posterPath else { return nil }
       return URL(string: "https://image.tmdb.org/t/p/w500/\(posterPath)")
    }
    public init(id: Int, posterPath: String?, title: String?, genreIDs: [Int]?, releaseDate: Date?) {
        self.id = id
        self.posterPath = posterPath
        self.title = title
        self.genreIDs = genreIDs
        self.releaseDate = releaseDate
    }
}

extension Movie {
   public static let mockMovies: [Movie] = (1...6).map { index in
        Movie(
            id: index,
            posterPath: nil,
            title: "title title title title title",
            genreIDs: nil,
            releaseDate: nil
        )
    }
}
