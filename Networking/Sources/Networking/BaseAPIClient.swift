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

   public init(baseURL: URL, apiKey: String) {
        self.baseURL = baseURL
       self.apiKey = apiKey
    }
    
    public func execute<Response: Decodable>( _ request: APIRequest<Response>) -> AnyPublisher<Response, NetworkError> {
        do{
            let request = try request.makeURLRequest(baseURL: baseURL, apiKey: apiKey)
            
            return URLSession.shared.dataTaskPublisher(for: request)
                .mapError{
                    NetworkError.Transport(TransportError(urlError: $0))
                }
                .tryMap{ data, response in
                    print("response: \(response)")

                    guard let response = response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 300 else {
                  

                        print(NetworkError.httpResponse)
                        throw NetworkError.httpResponse
                    }
                    print("data: \(data)")
                    return data
                }
                .decode(type: Response.self, decoder: JSONDecoder())
                .mapError { error in
                    if let networkError = error as? NetworkError {
                        print("errssr \(error.localizedDescription)")
                        return networkError
                    } else if error is DecodingError {
                        print("errr \(error.localizedDescription)")
                        return .decoding
                    } else {
                        return .Transport(.unknown)
                    }
                }
                .eraseToAnyPublisher()
        }catch{
            return Fail(error: NetworkError.badURL)
                .eraseToAnyPublisher()
        }
    }
}
