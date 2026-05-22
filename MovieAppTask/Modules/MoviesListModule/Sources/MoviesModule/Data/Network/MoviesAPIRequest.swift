//
//  File.swift
//  MoviesListModule
//
//  Created by Mohamed Makhlouf Ahmed on 19/05/2026.
//

import Foundation
import Commons
import Networking

public enum MoviesAPIRequest{
  static func getMovies(page: Int = 1) -> APIRequest<MoviesResponse>{
      APIRequest(method: .get,
                 path: .movies(.movies),
                 queryItems: [URLQueryItem(name: "page", value: "\(page)"),
                             URLQueryItem(name: "sort_by", value: "popularity.desc"),
                              URLQueryItem(name: "include_adult", value: "true")
                             ])
    }
    
    static func searchMovies(searchText: String, searchPage: Int) -> APIRequest<MoviesResponse>{
        APIRequest(method: .get ,
                   path: .movies(.search),
                   queryItems: [URLQueryItem(name: "query", value: "\(searchText)"),
                                URLQueryItem(name: "page", value: "\(searchPage)")])
    }
    
    static func getGenres() -> APIRequest<GenresResponse> {
        APIRequest(method: .get, path: .movies(.genres))
   }
}
