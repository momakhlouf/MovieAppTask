//
//  File.swift
//  Commons
//
//  Created by Mohamed Makhlouf Ahmed on 23/05/2026.
//

import Foundation

public extension URLQueryItem {
    
    static func page(_ value: Int) -> URLQueryItem {
        URLQueryItem(name: "page", value: "\(value)")
    }
    
    static func sortBy(_ value: String) -> URLQueryItem {
        URLQueryItem(name: "sort_by", value: value)
    }
    
    static func includeAdult(_ value: Bool) -> URLQueryItem {
        URLQueryItem(name: "include_adult", value: "\(value)")
    }
}
