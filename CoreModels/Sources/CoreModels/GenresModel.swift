//
//  File.swift
//  GenresModule
//
//  Created by Mohamed Makhlouf Ahmed on 20/05/2026.
//

import Foundation

//model
public struct Genre{
    public let id: Int?
    public let name: String?
    
  public init(id: Int?, name: String?) {
        self.id = id
        self.name = name
    }
}
