//
//  File.swift
//  Networking
//
//  Created by Mohamed Makhlouf Ahmed on 19/05/2026.
//

import Foundation
import Combine

public protocol BaseApIClientProtocol {
    func execute<Response: Decodable>( _ request: APIRequest<Response>) -> AnyPublisher<Response, NetworkError>
}
public final class BaseAPIClient: BaseApIClientProtocol{
    let baseURL: URL
    private let apiKey: String
    private let session: URLSession
    public init(baseURL: URL, apiKey: String) {
        self.baseURL = baseURL
        self.apiKey = apiKey
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        config.urlCache = nil
        self.session = URLSession(configuration: config)
    }
    
    public func execute<Response: Decodable>(
        _ request: APIRequest<Response>
    ) -> AnyPublisher<Response, NetworkError> {
        
        do {
            let urlRequest = try request.makeURLRequest(baseURL: baseURL, apiKey: apiKey)
            
            return session.dataTaskPublisher(for: urlRequest)
                .tryMap { data, response in
                    guard let http = response as? HTTPURLResponse else {
                        throw NetworkError.httpResponse
                    }
                    guard (200...299).contains(http.statusCode) else {
                        throw NetworkError.httpStatusCode(http.statusCode)
                    }
                    return data
                }
                .decode(type: Response.self, decoder: JSONDecoder())
                .mapError { error in
                    Self.mapError(error)
                }
                .eraseToAnyPublisher()
            
        } catch {
            return Fail(error: .badURL)
                .eraseToAnyPublisher()
        }
    }
    
    private static func mapError(_ error: Error) -> NetworkError {
        
        if let networkError = error as? NetworkError {
            return networkError
        }
        
        if let urlError = error as? URLError {
            return .Transport(TransportError(urlError: urlError))
        }
        
        if error is DecodingError {
            return .decoding
        }
        return .Transport(.unknown)
    }
}
