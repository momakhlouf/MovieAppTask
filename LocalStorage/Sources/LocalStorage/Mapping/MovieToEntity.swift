//
//  File.swift
//  LocalStorage
//
//  Created by Mohamed Makhlouf Ahmed on 21/05/2026.
//

import Foundation
import CoreModels


extension Movie {
    func toRealm(page: Int) -> MovieObject {
        let obj = MovieObject()
        obj.id = id
        obj.page = page
        obj.posterPath = posterPath
        obj.title = title
        obj.releaseDate = releaseDate
        return obj
    }
}
