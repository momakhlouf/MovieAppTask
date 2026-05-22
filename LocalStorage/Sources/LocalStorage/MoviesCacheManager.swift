//
//  File.swift
//  LocalStorage
//
//  Created by Mohamed Makhlouf Ahmed on 21/05/2026.
//

import Foundation
import CoreModels
import Combine
import SwiftData
import Networking

public protocol MoviesCacheManagerProtocol {
    func save(movies: [Movie])
    func fetchMovies() -> AnyPublisher<[Movie], NetworkError>
    func clear()
}
public class MoviesCacheManager: MoviesCacheManagerProtocol {
    
    private let context: ModelContext
    private let maxCache = 50
    
    public init(context: ModelContext) {
        self.context = context
    }
    
    public func save(movies: [Movie]) {
        do {
            let existing = try context.fetch(FetchDescriptor<MovieEntity>())
            let existingIDs = Set(existing.map { $0.id })
            
            for movie in movies {
                if !existingIDs.contains(movie.id) {
                    context.insert(movie.toEntity())
                }
            }
            
            try context.save()
        } catch {
            print("Cache error:", error)
        }
        //        movies.forEach {
        //            context.insert($0.toEntity())
        //        }
        //        try? context.save()
    }
    
    public func fetchMovies() -> AnyPublisher<[Movie], NetworkError> {
        Future { promise in
            do {
                let result = try self.context.fetch(FetchDescriptor<MovieEntity>())
                print(("result cache: \(result)"))
                promise(.success(result.map { $0.toDomain() }))
            } catch {
                promise(.failure(.Transport(.offline)))
            }
        }
        .eraseToAnyPublisher()
    }
    
    public func clear() {
          do {
              let items = try context.fetch(FetchDescriptor<MovieEntity>())
              items.forEach { context.delete($0) }
              try context.save()
          } catch {
              print("Cache clear error:", error)
          }
      }
    
}
