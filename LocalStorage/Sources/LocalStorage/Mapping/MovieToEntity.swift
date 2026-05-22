//
//  File.swift
//  LocalStorage
//
//  Created by Mohamed Makhlouf Ahmed on 21/05/2026.
//

import Foundation
import CoreModels

extension Movie {
    func toEntity() -> MovieEntity {
        MovieEntity(
            id: id,
            title: title,
            posterPath: posterPath,
            releaseDate: releaseDate,
            genreIDs: genreIDs ?? []
        )
    }
}
