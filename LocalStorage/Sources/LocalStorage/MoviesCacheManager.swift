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
    func getMovies() -> AnyPublisher<[Movie], Never>
}

public final class MoviesCacheManager: MoviesCacheProtocol {
    
    private let queue = DispatchQueue(label: "realm.queue")
    public init() {}
    
    public func saveMovies(_ movies: [Movie], page: Int) {
      //  guard page <= 3 else { return }
        queue.async {
            autoreleasepool {
                do {
                    let realm = try Realm()
                    let objects = movies.map { $0.toRealm(page: page) }
                    try realm.write {
                        if page == 1{
                            let old = realm.objects(MovieObject.self)
                            realm.delete(old)
                        }
                        realm.add(objects, update: .modified)
                    }
                } catch {
                    // i will handle it later
                    print("Realm save error: \(error)")
                }
            }
        }
    }
    
    public func getMovies() -> AnyPublisher<[Movie], Never> {
        Deferred {
            Future<[Movie], Never> { promise in
                autoreleasepool {
                    do {
                        let realm = try Realm()
                        let results = realm.objects(MovieObject.self)
                        let movies = results.map { $0.toDomain() }
                        promise(.success(Array(movies)))
                    } catch {
                        print(" Realm fetch error: \(error)")
                        promise(.success([]))
                    }
                }
            }
        }
        .subscribe(on: queue)
        .eraseToAnyPublisher()
    }
}
