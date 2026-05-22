//
//  File.swift
//  LocalStorage
//
//  Created by Mohamed Makhlouf Ahmed on 21/05/2026.
//

import Foundation
import CoreModels

extension MovieEntity {
    func toDomain() -> Movie {
        Movie(
            id: id,
            posterPath: posterPath,
            title: title,
            genreIDs: genreIDs,
            releaseDate: releaseDate
        )
    }
}

