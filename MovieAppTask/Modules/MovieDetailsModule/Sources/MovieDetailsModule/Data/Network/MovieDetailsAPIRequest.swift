//
//  File.swift
//  MovieDetailsModule
//
//  Created by Mohamed Makhlouf Ahmed on 22/05/2026.
//

import Foundation
import Commons
import Networking

public enum MovieDetailsAPIRequest{
    static func getMovieDetails(id: Int) -> APIRequest<MovieDetailsResponse> {
        APIRequest(method: .get, path: .movies(.movieDetails(id)))
    }
}
