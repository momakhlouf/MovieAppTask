//
//  File.swift
//  GenresModule
//
//  Created by Mohamed Makhlouf Ahmed on 20/05/2026.
//

import Foundation
import CoreModels

public struct GenresResponse: Codable {
    let genres: [GenreResponse]?
}

// MARK: - Genre
 struct GenreResponse: Codable {
    let id: Int?
    let name: String?
}

extension GenreResponse{
    func toDomain() -> Genre{
        return Genre(id: id, name: name)
    }
}
