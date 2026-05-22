//
//  File.swift
//  LocalStorage
//
//  Created by Mohamed Makhlouf Ahmed on 21/05/2026.
//

import Foundation
import SwiftData

//public class MovieEntity: Object{
//    @Persisted(primaryKey: true) var id: Int
//    @Persisted var title: String?
//    @Persisted var posterPath: String?
//    @Persisted var genresID = List<Int>() // doesn't support [int]?
//    @Persisted var releaseDate: Date?
//}

import SwiftData
import CoreModels

@Model
public class MovieEntity {
    @Attribute(.unique) public var id: Int
    public var title: String?
    public var posterPath: String?
    public var releaseDate: Date?
    public var genreIDs: [Int]

    public init(
        id: Int,
        title: String?,
        posterPath: String?,
        releaseDate: Date?,
        genreIDs: [Int]
    ) {
        self.id = id
        self.title = title
        self.posterPath = posterPath
        self.releaseDate = releaseDate
        self.genreIDs = genreIDs
    }
}




