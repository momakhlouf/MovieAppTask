//
//  File.swift
//  LocalStorage
//
//  Created by Mohamed Makhlouf Ahmed on 21/05/2026.
//

import Foundation
import CoreModels
import RealmSwift

//extension MovieEntity {
//    func toDomain() -> Movie {
//        Movie(
//            id: id,
//            posterPath: posterPath,
//            title: title,
//            genreIDs: genreIDs,
//            releaseDate: releaseDate
//        )
//    }
//}
public final class MovieObject: Object {
    @Persisted(primaryKey: true) public var id: Int
    @Persisted public var page: Int
    @Persisted public var posterPath: String?
    @Persisted public var title: String?
    @Persisted public var releaseDate: Date?
}
extension MovieObject {
    func toDomain() -> Movie {
        Movie(
            id: id,
            posterPath: posterPath,
            title: title,
            genreIDs: nil,
            releaseDate: releaseDate
        )
    }
}


