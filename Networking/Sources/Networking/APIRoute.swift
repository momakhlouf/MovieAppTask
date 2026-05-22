//
//  File 2.swift
//  Networking
//
//  Created by Mohamed Makhlouf Ahmed on 19/05/2026.
//

import Foundation

public enum APIRoute {
    // i can make all here, but incase add more endpoints.
    case movies(MovieEndpoint)
    
    var path: String {
        switch self {
        case .movies(let route):
            return route.path
        }
    }
}
public enum MovieEndpoint {
    case movies
    case search
    case genres
    case movieDetails(Int)
    
    var path: String {
        switch self {
        case .movies:
            return "discover/movie"
        case .search:
            return "search/movie"
        case .genres:
            return "genre/movie/list"
        case .movieDetails(let id):
            return "movie/\(id)"
        }
    }
}
