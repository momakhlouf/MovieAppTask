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
import RealmSwift

public protocol MoviesCacheProtocol {
    func saveMovies(_ movies: [Movie], page: Int)
    func getAllMovies() -> AnyPublisher<[Movie], Never> 

}

public final class MoviesCacheManager: MoviesCacheProtocol {
    
    private let queue = DispatchQueue(label: "realm.queue")
    public init() {}
    
    public func saveMovies(_ movies: [Movie], page: Int) {
        
        guard page <= 3 else { return }
        
        queue.async {
            autoreleasepool {
                do {
                    let realm = try Realm()
                    
                    let objects = movies.map { $0.toRealm(page: page) }
                    
                    try realm.write {
                        let old = realm.objects(MovieObject.self)
                            .where { $0.page == page }
                        
                        realm.delete(old)
                        realm.add(objects, update: .modified)
                    }
                    
                } catch {
                    // i will handle it later
                    print("Realm save error: \(error)")
                }
            }
        }
    }
    
    public func getAllMovies() -> AnyPublisher<[Movie], Never> {
        Future<[Movie], Never> {promise in
            self.queue.async {
                autoreleasepool {
                    do {
                        let realm = try Realm()
                        
                        let results = realm.objects(MovieObject.self)
                            .where { $0.page <= 3 }
                            .sorted(byKeyPath: "page", ascending: true)
                        
                        let movies = results.map { $0.toDomain() }
                        
                        promise(.success(Array(movies)))
                        
                    } catch {
                        print(" Realm fetch error: \(error)")
                        promise(.success([]))
                    }
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
